from flask import Flask, render_template, request, redirect, url_for, session, flash
from models import db, Cinema, MoviesAPI, Session, Seance
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import not_
import hashlib

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'toto24'
    app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root@localhost:3306/Cinema'
    db.init_app(app)
    
    # Route / (acceuil) permet a l'utilisateur de visualiser la liste des Cinémas et leurs films, et de filtrer par ville/film
    # On peut egalement avoir des informations supplémentaires pour chaque film.
    @app.route('/', methods=['GET'])
    def index():
        # Requête SQL permettant de récupérer les villes listées dans la table "Cinema"
        villes = Cinema.query.with_entities(Cinema.city).distinct().all()
        villes = [ville.city for ville in villes]
        # Requête SQL permettant de récupérer les films listés dans table MoviesAPI
        films = MoviesAPI.query.with_entities(MoviesAPI.title).distinct().all()
        films = [film.title for film in films]

        selected_city = request.args.get('city')
        selected_film = request.args.get('film')

        cinema_movies = {}
        seances_par_film = {}
        for cinema in Cinema.query.all():
            query = MoviesAPI.query.filter(MoviesAPI.ID_Cinema == cinema.ID)
            if selected_city and cinema.city != selected_city:
                continue
            if selected_film:
                query = query.filter(MoviesAPI.title == selected_film)
            cinema_movies[cinema] = query.all()
            
            # récupérer les séances pour chaque film
            for movie in cinema_movies[cinema]:
                seances = Seance.query.filter_by(ID_Movie=movie._id, ID_Cinema=cinema.ID).all()
                seances_par_film[movie._id] = seances

        return render_template('index.html', cinema_movies=cinema_movies, villes=villes, films=films, filter_city=selected_city, filter_film=selected_film, seances_par_film=seances_par_film)
    
    @app.route('/cinemas/login', methods=['GET', 'POST'])
    def login():
        if request.method == 'POST':
            username = request.form['username']
            password = request.form['password']
            # Vérifiez ici les identifiants (exemple simplifié)
            if username == "admin" and password == "secret":
                return redirect(url_for('manage_cinemas'))
            else:
                flash("Utilisateur ou mot de passe incorrects","error")
                return render_template('login.html')
        return render_template('login.html')
    
    # Route pour la gestion des cinémas (Ajout / Suppréssion d'un film)
    
    @app.route('/cinemas/manage', methods=['GET', 'POST'])
    def manage_cinemas():
        if request.method == 'POST':
            action = request.form.get('action')
            if action == 'add':
                new_cinema = Cinema(name=request.form['name'], city=request.form['city'])
                db.session.add(new_cinema)
                db.session.commit()
            elif action == 'delete':
                cinema_id = request.form['id']
                cinema = Cinema.query.get(cinema_id)
                if cinema:
                    db.session.delete(cinema)
                    db.session.commit()
        cinemas = Cinema.query.all()
        return render_template('cinema.html', cinemas=cinemas)

    # Route pour la gestion des films (Ajout/suppréssion d'un film, Ajout/suppréssion d'une séance de film)
    @app.route('/movies/manage', methods=['GET', 'POST'])
    def manage_movies():
        films_possibles= []
        if 'cinema_id' not in session:
            if request.method == 'POST':
                if 'create_session' in request.form:
                    
                    cinema_id = request.form['cinema_id']
                    # Vérifiez si l'ID de cinéma existe
                    cinema_exists = Cinema.query.get(cinema_id)
                    if not cinema_exists:
                        flash("ID cinéma renseigné n'existe pas", 'error')
                        return redirect(url_for('manage_movies'))
                                        
                    # Vérifier si une session existe déjà
                    existing_session = Session.query.filter_by(ID_Cinema=cinema_id).first()

                    if existing_session:
                        flash('Une session pour ce cinéma existe déjà', 'error')
                        return redirect(url_for('manage_movies'))

                    # Créer une session
                    Cle = request.form['Cle']
                    new_session = Session(ID_Cinema=cinema_id, Cle=Cle)
                    db.session.add(new_session)
                    db.session.commit()
                    flash('Session créée avec succès', 'success')
                    return redirect(url_for('manage_movies'))
                
                elif 'cinema_id_auth' in request.form:
                    # Authentification
                    cinema_id = request.form['cinema_id_auth']
                    Cle = request.form['Cle']
                    authorized_session = Session.query.filter_by(ID_Cinema=cinema_id, Cle=Cle).first()
                    if authorized_session:
                        session['cinema_id'] = cinema_id
                    else:
                        return 'Authentification échouée', 403

        if 'cinema_id' in session:

            # Récupérer tous les films qui ne sont pas déjà dans le cinéma courant
            cinema_id = session['cinema_id']
            films_associes = MoviesAPI.query.filter_by(ID_Cinema=cinema_id).all()
            tous_les_films = MoviesAPI.query.all()

            # Initialisation de la liste films_possibles
            films_possibles = []

            # Parcourir tous les films
            for film in tous_les_films:
                # Drapeau pour vérifier si le film est différent
                est_different = True

                # Comparer avec chaque film associé
                for associe in films_associes:
                    if (film.title == associe.title and
                        film.genres == associe.genres and
                        film.overview == associe.overview and
                        film.poster_path == associe.poster_path and
                        film.backdrop_path == associe.backdrop_path and
                        film.release_date == associe.release_date):
                        # Si tous les attributs sont identiques, le film n'est pas différent
                        est_different = False
                        break  # Pas besoin de continuer à comparer ce film

                # Si le film est différent, l'ajouter à la liste films_possibles
                if est_different:
                    films_possibles.append(film)

            if request.method == 'POST':
                action = request.form.get('action')

                if action == 'add':
                    film_id = request.form.get('film_id')
                    if film_id:
                        film_existant = MoviesAPI.query.get(film_id)
                        if film_existant and film_existant.ID_Cinema != cinema_id:
                            # Générer un identifiant unique basé sur le hachage
                            unique_string = film_existant.title + film_existant.genres + film_existant.overview
                            unique_id = int(hashlib.sha256(unique_string.encode('utf-8')).hexdigest(), 16) % 10**8
                            # On créer une nouvelle instance de MoviesAPI (table) et on l'ajoute a la table.
                            new_movie = MoviesAPI(
                                _id = unique_id,
                                backdrop_path = film_existant.backdrop_path,
                                genres = film_existant.genres,
                                original_title = film_existant.original_title,
                                overview = film_existant.overview,
                                poster_path = film_existant.poster_path,
                                release_date = film_existant.release_date,
                                title = film_existant.title,
                                contentType = film_existant.contentType,
                                ID_Cinema = cinema_id
                            )
                            db.session.add(new_movie)
                            db.session.commit()
                            flash('Film ajouté avec succès','success')
                    else:
                        # Récupérer les données du formulaire
                        title = request.form.get('title', '')
                        genres = request.form.get('genres', '')
                        overview = request.form.get('overview', '')

                        # Générer un identifiant unique basé sur le hachage
                        unique_string = title + genres + overview
                        unique_id = int(hashlib.sha256(unique_string.encode('utf-8')).hexdigest(), 16) % 10**8
                        # Définir des valeurs par défaut pour backdrop_path et poster_path si elles ne sont pas fournies
                        backdrop_path = request.form.get('backdrop_path') or '/static/img/default_bg_image.jpg'
                        poster_path = request.form.get('poster_path') or '/static/img/default_poster.jpg'
                        # Créer un nouvel objet MoviesAPI
                        new_movie = MoviesAPI(
                            _id=unique_id,
                            backdrop_path=backdrop_path,
                            genres=genres,
                            original_title=title,
                            overview=overview,
                            poster_path=poster_path,
                            release_date=request.form.get('release_date', ''),
                            title=title,
                            contentType='movie',
                            ID_Cinema=session['cinema_id']
                        )
                        db.session.add(new_movie)
                        db.session.commit()
                        flash('Film ajouté avec succès', 'success')

                elif action == 'add_seance':
                    # Programmation d'une séance
                    movie_id = request.form['movie_id']
                    heure_debut = request.form['heure_debut']
                    date = request.form['date']
                    # Création d'un instance de Seance, et l'ajouter a la table.
                    new_seance = Seance(ID_Movie=movie_id, ID_Cinema=session['cinema_id'], HeureDebut=heure_debut, Date=date)
                    db.session.add(new_seance)
                    db.session.commit()
                    flash('Séance programmée avec succès', 'success')
                
                elif action == 'delete_seance' : 
                    seance_id = request.form.get('seance_id')
                    seance_a_supprimer = Seance.query.get(seance_id)
                    if seance_a_supprimer:
                        db.session.delete(seance_a_supprimer)
                        db.session.commit()
                        flash('Séance supprimée avec succès', 'success')

                elif action == 'delete':
                    # Supprimer un film
                    movie_id = request.form['movie_id']
                    movie = MoviesAPI.query.filter_by(_id=movie_id, ID_Cinema=session['cinema_id']).first()
                    if movie:
                        seances = Seance.query.filter_by(ID_Movie= movie._id).all()
                        if seances:
                            flash("Des séances sont encore programmées pour ce film, supprimez-les d'abord", "error")
                        else:
                            db.session.delete(movie)
                            db.session.commit()
                            flash('Film supprimé avec succès', 'success')
                    else:
                        flash('Film non trouvé ou non autorisé', 'error')


        movies = MoviesAPI.query.filter_by(ID_Cinema=session.get('cinema_id')).all()
        movies_seances = {movie._id: Seance.query.filter_by(ID_Movie=movie._id).all() for movie in movies}
        return render_template('movie.html', cinema_id=session.get('cinema_id'), movies=movies, movies_seances=movies_seances, films_possibles=films_possibles)

    @app.route('/movies/manage/logout', methods=['POST'])
    def logout_movie_manage():
        session.pop('cinema_id', None)  # Supprime l'ID du cinéma de la session
        return redirect(url_for('manage_movies'))  # Redirige vers la page d'authentification
    
    # Route dynamique créee a partir de l'identifiant du film
    @app.route('/movie/<int:movie_id>', methods=['GET'])
    def movie_details(movie_id):
        movie = MoviesAPI.query.get(movie_id)
        seances = Seance.query.filter_by(ID_Movie=movie_id).all()
        return render_template('movie_details.html', movie=movie, seances=seances)

    
    return app

if __name__ == '__main__':
    app = create_app()
    app.run(debug=True)