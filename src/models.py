from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Cinema(db.Model):
    __tablename__ = 'Cinema'
    ID = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255))
    city = db.Column(db.String(255))

class MoviesAPI(db.Model):
    __tablename__ = 'MoviesAPI'
    _id = db.Column(db.BigInteger, primary_key=True)
    backdrop_path = db.Column(db.Text)  # Text(65535) équivaut à db.Text dans SQLAlchemy
    genres = db.Column(db.Text)
    original_title = db.Column(db.Text)
    overview = db.Column(db.Text)
    poster_path = db.Column(db.Text)
    release_date = db.Column(db.Text)  
    title = db.Column(db.Text)
    contentType = db.Column(db.Text)
    ID_Cinema = db.Column(db.Integer, db.ForeignKey('Cinema.ID'))


#class Movie(db.Model):
#    __tablename__ = 'Movie'
#    ID = db.Column(db.Integer, primary_key=True)
#    ID_Cinema = db.Column(db.Integer, db.ForeignKey('Cinema.ID'))
#    Title = db.Column(db.String(255))
#    Director = db.Column(db.String(255))
#    Duree = db.Column(db.Integer)
#    Langue = db.Column(db.String(255))
#    DateDebut = db.Column(db.Date)
#    DateFin = db.Column(db.Date)

class Session(db.Model):
    __tablename__ = 'Session'
    ID = db.Column(db.Integer, primary_key=True)
    ID_Cinema = db.Column(db.Integer, db.ForeignKey('Cinema.ID'))
    Cle = db.Column(db.String(255))

class Seance(db.Model):
    __tablename__ = 'Seance'
    ID = db.Column(db.Integer, primary_key=True)
    ID_Movie = db.Column(db.BigInteger, db.ForeignKey('MoviesAPI._id'))
    ID_Cinema = db.Column(db.Integer, db.ForeignKey('Cinema.ID'))
    HeureDebut = db.Column(db.Time)
    Date = db.Column(db.Date)
