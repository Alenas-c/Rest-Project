# Gestion de Cinémas et Films

Ce projet est une application web Flask qui permet aux propriétaires de cinémas de gérer leurs films et séances. L'application permet également aux utilisateurs de filtrer les films par ville et cinéma.

### Groupe:
- Alenas CHAOUI
- Eric CHEN
- Haitame CHOUBANNE
- Salaheddin ABIDALLAH

## Important !
A fin de pouvoir executer ce projet, il faudra au préalable créer une base de donnée "Cinema" et y importer le fichier "Cinema.sql", autrement, vous n'aurez pas accès a toutes les informations du projet.

## Fonctionnalités

- Authentification des propriétaires de cinémas. (route /movie/manage)
- Ajout, modification et suppression de films. (route /movie/manage)
- Affichage des films disponibles selon le cinéma sélectionné. ( route /)
- Programmation des séances pour chaque film. (route /movie/manage)
- Filtrage des films et cinémas par ville. (route /)
- Ajout / Suppression d'un cinéma (route /cinema/manage)
- Détails d'un film (route /movie/{id du film})

## Technologies Utilisées

- Langage : Python
- Flask : un micro-framework web Python.
- SQLAlchemy : un ORM (Object-Relational Mapping) pour gérer la base de données.
- MySQL : un système de gestion de base de données.
- Jinja2 : un moteur de templates pour Python.
- HTML/CSS : pour la structure et le style de l'application web.



