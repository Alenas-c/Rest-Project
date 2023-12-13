# CES FICHIERS SONT DES SCRIPTS QUI PERMETTENT DE REMPLIR LES AUTRES TABLE DE FACON ALEATOIRE

from models import db, MoviesAPI, Seance, Cinema
from datetime import datetime, timedelta
import random
from flask import Flask
# Configuration de la base de données - à ajuster selon votre configuration
app = Flask(__name__)
app.config['SECRET_KEY'] = 'toto24'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root@localhost:3306/Cinema'
db.init_app(app)

with app.app_context():
    # Définir la période des séances
    debut_periode = datetime(2023, 12, 10)
    fin_periode = datetime(2024, 1, 1)
    duree_periode = (fin_periode - debut_periode).days

    # Boucler sur tous les cinémas
    for cinema in Cinema.query.all():
        # Récupérer tous les films associés à ce cinéma
        films = MoviesAPI.query.filter_by(ID_Cinema=cinema.ID).all()

        for film in films:
            # Choisir un nombre aléatoire de séances entre 2 et 3 pour chaque film
            nombre_seances = random.randint(2, 3)

            # Choisir des jours aléatoires pour les séances
            jours_seances = random.sample(range(duree_periode), nombre_seances)

            for jour in jours_seances:
                # Choisir une heure aléatoire entre 8h et 22h
                heure_aleatoire = random.randint(8, 21)  # 21 pour garantir que la séance finisse avant 22h
                minute_aleatoire = random.choice([0, 30])  # Séances à heure pile ou et demi

                # Créer une nouvelle séance
                nouvelle_seance = Seance(
                    ID_Movie=film._id,
                    ID_Cinema=cinema.ID,
                    HeureDebut=datetime(2023, 12, 10, heure_aleatoire, minute_aleatoire).time(),
                    Date=(debut_periode + timedelta(days=jour))
                )
                db.session.add(nouvelle_seance)

    db.session.commit()