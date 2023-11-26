from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

class Cinema(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    movies = db.relationship('Movie', backref='cinema', lazy=True)

class Movie(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    cinema_id = db.Column(db.Integer, db.ForeignKey('cinema.id'), nullable=False)
    title = db.Column(db.String(100), nullable=False)
    director = db.Column(db.String(50), nullable=False)

    def serialize(self):
        return {
            "id": self.id,
            "title": self.title,
            "director": self.director,
            "cinema_id": self.cinema_id
        }
