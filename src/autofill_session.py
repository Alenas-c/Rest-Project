import pymysql

# Paramètres de connexion à la base de données MySQL
host = "localhost"
dbname = "Cinema"
user = "root"
password = "A!enas22932293"

# Connexion à la base de données
conn = pymysql.connect(host=host, db=dbname, user=user, passwd=password)
cur = conn.cursor()

# Récupération de tous les ID de la table Cinema
cur.execute("SELECT ID FROM Cinema;")
cinema_ids = [row[0] for row in cur.fetchall()]

# Insertion des enregistrements dans la table Session
for cinema_id in cinema_ids:
    try:
        cur.execute("INSERT INTO Session (ID_Cinema, Cle) VALUES (%s, 'root');", (cinema_id,))
    except pymysql.MySQLError as e:
        print(f"Erreur lors de l'insertion dans la table Session: {e}")
        conn.rollback()

# Validation des changements
conn.commit()

# Fermeture de la connexion
cur.close()
conn.close()
