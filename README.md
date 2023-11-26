# Gestion de Cinémas et Films

Ce projet est une application web Flask qui permet aux propriétaires de cinémas de gérer leurs films et séances. L'application permet également aux utilisateurs de filtrer les films par ville et cinéma.

## Fonctionnalités

- Authentification des propriétaires de cinémas.
- Ajout, modification et suppression de films.
- Affichage des films disponibles selon le cinéma sélectionné.
- Programmation des séances pour chaque film.
- Filtrage des films et cinémas par ville.

## Technologies Utilisées

- Flask : un micro-framework web Python.
- SQLAlchemy : un ORM (Object-Relational Mapping) pour gérer la base de données.
- MySQL : un système de gestion de base de données.
- Jinja2 : un moteur de templates pour Python.
- HTML/CSS : pour la structure et le style de l'application web.

## Installation

Pour exécuter cette application sur votre machine locale, suivez les étapes ci-dessous :

1. Clonez le dépôt sur votre machine locale :

    ```
    git clone https://github.com/votre_nom_utilisateur/votre_projet.git
    ```

2. Naviguez dans le répertoire du projet :

    ```
    cd votre_projet
    ```

3. Créez un environnement virtuel et activez-le :

    ```
    python -m venv venv
    source venv/bin/activate  # Sur Windows utilisez `venv\Scripts\activate`
    ```

4. Installez les dépendances :

    ```
    pip install -r requirements.txt
    ```

5. Configurez votre base de données MySQL en créant une base de données et en mettant à jour la chaîne de connexion dans `app.py`.

6. Exécutez les migrations pour créer les tables de la base de données :

    ```
    flask db upgrade
    ```

7. Lancez l'application :

    ```
    flask run
    ```

8. Ouvrez un navigateur et accédez à `http://127.0.0.1:5000/` pour voir l'application en action.

## Configuration

Avant de lancer l'application, assurez-vous de configurer les variables d'environnement nécessaires dans un fichier `.env` à la racine du projet :
    ```
    FLASK_APP=app.py
    FLASK_ENV=development
    DATABASE_URL=mysql+pymysql://utilisateur:motdepasse@localhost:3306/nom_de_la_db
    ```

## Contribution

Si vous souhaitez contribuer à ce projet, veuillez suivre les bonnes pratiques de codage et ajouter des tests unitaires pour les nouvelles fonctionnalités.


