from flask import Flask, render_template, request, redirect, url_for, session, flash
from models import db, Cinema, MoviesAPI, Session, Seance
from flask_sqlalchemy import SQLAlchemy
import hashlib

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'toto24'
    app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root@localhost:3306/Cinema'
    db.init_app(app)
    @app.route('/', methods=['GET'])
    def index():
        villes = Cinema.query.with_entities(Cinema.city).distinct().all()
        villes = [ville.city for ville in villes]

        films = MoviesAPI.query.with_entities(MoviesAPI.title).distinct().all()
        films = [film.title for film in films]

        selected_city = request.args.get('city')
        selected_film = request.args.get('film')

        cinema_movies = {}
        for cinema in Cinema.query.all():
            query = MoviesAPI.query.filter(MoviesAPI.ID_Cinema == cinema.ID)
            if selected_city and cinema.city != selected_city:
                continue
            if selected_film:
                query = query.filter(MoviesAPI.title == selected_film)
            cinema_movies[cinema] = query.all()

        return render_template('index.html', cinema_movies=cinema_movies, villes=villes, films=films, filter_city=selected_city, filter_film=selected_film)

    # Route pour la gestion des cinémas
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

    # Route pour la gestion des films
    @app.route('/movies/manage', methods=['GET', 'POST'])
    def manage_movies():
        if 'cinema_id' not in session:
            if request.method == 'POST':
                if 'create_session' in request.form:
                    # Vérifier si une session existe déjà
                    cinema_id = request.form['cinema_id']
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
            if request.method == 'POST':
                action = request.form.get('action')

                if action == 'add':
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

                    new_seance = Seance(ID_Movie=movie_id, ID_Cinema=session['cinema_id'], HeureDebut=heure_debut, Date=date)
                    db.session.add(new_seance)
                    db.session.commit()
                    flash('Séance programmée avec succès', 'success')

                elif action == 'delete':
                    # Supprimer un film
                    movie_id = request.form['movie_id']
                    movie = MoviesAPI.query.filter_by(_id=movie_id, ID_Cinema=session['cinema_id']).first()
                    if movie:
                        db.session.delete(movie)
                        db.session.commit()
                        flash('Film supprimé avec succès', 'success')
                    else:
                        flash('Film non trouvé ou non autorisé', 'error')

        movies = MoviesAPI.query.filter_by(ID_Cinema=session.get('cinema_id')).all()
        movies_seances = {movie._id: Seance.query.filter_by(ID_Movie=movie._id).all() for movie in movies}
        return render_template('movie.html', cinema_id=session.get('cinema_id'), movies=movies, movies_seances=movies_seances)

    @app.route('/movies/manage/logout', methods=['POST'])
    def logout_movie_manage():
        session.pop('cinema_id', None)  # Supprime l'ID du cinéma de la session
        return redirect(url_for('manage_movies'))  # Redirige vers la page d'authentification
    
    return app

if __name__ == '__main__':
    app = create_app()
    app.run(debug=True)