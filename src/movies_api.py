# Fichier permettant de créer un table MoviesAPI a partir de données récupérées d'une API Publique
import requests
import pandas as pd
import sqlalchemy

# Your existing code to get the response
url = "https://movies-api14.p.rapidapi.com/movies"
headers = {
	"X-RapidAPI-Key": "cdad413682mshc84a854663e4d86p14297djsnef9ff83d042c",
	"X-RapidAPI-Host": "movies-api14.p.rapidapi.com"
}

response = requests.get(url, headers=headers)
responseData = response.json()

# Normalizing the data
df = pd.json_normalize(responseData, record_path=['movies'])
engine= sqlalchemy.create_engine('mysql+pymysql://root:A!enas22932293@localhost:3306/Cinema')
# Convert 'genres' list to string
df['genres'] = df['genres'].apply(lambda x: ', '.join(x))

# Then try inserting into the database
df.to_sql(name='MoviesAPI', con=engine, index=False, if_exists='replace')

