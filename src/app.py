from flask import Flask, render_template, request, redirect, url_for, session, flash

from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SECRET_KEY'] = 'toto24'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:A!enas22932293@localhost:3306/Cinema'
db = SQLAlchemy(app)

class Cinema(db.Model):
    __tablename__ = 'Cinema'
    ID = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255))
    city = db.Column(db.String(255))

class Movie(db.Model):
    __tablename__ = 'Movie'
    ID = db.Column(db.Integer, primary_key=True)
    ID_Cinema = db.Column(db.Integer, db.ForeignKey('Cinema.ID'))
    Title = db.Column(db.String(255))
    Director = db.Column(db.String(255))
    Duree = db.Column(db.Integer)  # Supposant que la durée est en minutes
    Langue = db.Column(db.String(255))
    DateDebut = db.Column(db.Date)  # Assurez-vous d'utiliser le bon type de données pour les dates
    DateFin = db.Column(db.Date)

class Session(db.Model):
    __tablename__ = 'Session'
    ID = db.Column(db.Integer, primary_key=True)
    ID_Cinema = db.Column(db.Integer, db.ForeignKey('Cinema.ID'))
    Cle = db.Column(db.String(255))  # Assurez-vous que la longueur est suffisante pour la clé

class Seance(db.Model):
    __tablename__ = 'Seance'
    ID = db.Column(db.Integer, primary_key=True)
    ID_Movie = db.Column(db.Integer, db.ForeignKey('Movie.ID'))
    ID_Cinema = db.Column(db.Integer, db.ForeignKey('Cinema.ID'))
    HeureDebut = db.Column(db.Time)  # Assurez-vous d'utiliser le bon type de données pour l'heure
    Date = db.Column(db.Date)  # Assurez-vous d'utiliser le bon type de données pour la date


@app.route('/', methods=['GET'])
def index():
    # Récupérer une liste de villes et de films uniques
    villes = Cinema.query.with_entities(Cinema.city).distinct().all()
    villes = [ville.city for ville in villes]

    films = Movie.query.with_entities(Movie.Title).distinct().all()
    films = [film.Title for film in films]

    selected_city = request.args.get('city')
    selected_film = request.args.get('film')

    if selected_city:
        cinemas = Cinema.query.filter_by(city=selected_city).all()
    else:
        cinemas = Cinema.query.all()

    cinema_movies = {}
    for cinema in cinemas:
        if selected_film:
            cinema_movies[cinema] = Movie.query.filter_by(ID_Cinema=cinema.ID, Title=selected_film).all()
        else:
            cinema_movies[cinema] = Movie.query.filter_by(ID_Cinema=cinema.ID).all()

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
                # Ajouter un film
                new_movie = Movie(
                    Title=request.form['title'],
                    Director=request.form['director'],
                    Duree=request.form['duree'],
                    Langue=request.form['langue'],
                    DateDebut=request.form['date_debut'],
                    DateFin=request.form['date_fin'],
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
                movie = Movie.query.filter_by(ID=movie_id, ID_Cinema=session['cinema_id']).first()
                if movie:
                    db.session.delete(movie)
                    db.session.commit()
                    flash('Film supprimé avec succès', 'success')
                else:
                    flash('Film non trouvé ou non autorisé', 'error')

    movies = Movie.query.filter_by(ID_Cinema=session.get('cinema_id')).all()
    movies_seances = {movie.ID: Seance.query.filter_by(ID_Movie=movie.ID).all() for movie in movies}
    return render_template('movie.html', cinema_id=session.get('cinema_id'), movies=movies, movies_seances=movies_seances)

@app.route('/movies/manage/logout', methods=['POST'])
def logout_movie_manage():
    session.pop('cinema_id', None)  # Supprime l'ID du cinéma de la session
    return redirect(url_for('manage_movies'))  # Redirige vers la page d'authentification

if __name__ == '__main__':
    app.run(debug=True)