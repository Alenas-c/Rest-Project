# CES FICHIERS SONT DES SCRIPTS QUI PERMETTENT DE REMPLIR LES AUTRES TABLE DE FACON ALEATOIRE
import random
import pymysql

# Paramètres de connexion à la base de données MySQL
host = "localhost"
dbname = "Cinema"
user = "root"
password = "A!enas22932293"

# Connexion à la base de données
conn = pymysql.connect(host=host, db=dbname, user=user, passwd=password)
cur = conn.cursor()

# Ajout de la colonne ID_Cinema à la table MoviesAPI
try:
    cur.execute("ALTER TABLE MoviesAPI ADD COLUMN ID_Cinema INT;")
except pymysql.MySQLError as e:
    print(f"Erreur lors de l'ajout de la colonne: {e}")
    conn.rollback()

# Ajout de la contrainte de clé étrangère
try:
    cur.execute("ALTER TABLE MoviesAPI ADD CONSTRAINT fk_cinema FOREIGN KEY (ID_Cinema) REFERENCES Cinema(ID);")
except pymysql.MySQLError as e:
    print(f"Erreur lors de l'ajout de la contrainte de clé étrangère: {e}")
    conn.rollback()

# Récupération de tous les ID de la table Cinema
cur.execute("SELECT ID FROM Cinema;")
cinema_ids = [row[0] for row in cur.fetchall()]

# Attribution d'un ID de Cinema au hasard pour chaque enregistrement dans MoviesAPI
cur.execute("SELECT _id FROM MoviesAPI;")
for movie_id in cur.fetchall():
    random_cinema_id = random.choice(cinema_ids)
    try:
        cur.execute("UPDATE MoviesAPI SET ID_Cinema = %s WHERE _id = %s;", (random_cinema_id, movie_id[0]))
    except pymysql.MySQLError as e:
        print(f"Erreur lors de la mise à jour de l'enregistrement {_id}: {e}")
        conn.rollback()

# Validation des changements
conn.commit()

# Fermeture de la connexion
cur.close()
conn.close()
