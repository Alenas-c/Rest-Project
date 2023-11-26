function fetchMovies() {
    fetch('/movies/Paris')  // Remplacez 'Paris' par la ville de votre choix
        .then(response => response.json())
        .then(movies => {
            const moviesList = document.getElementById('movies-list');
            moviesList.innerHTML = '';  // Effacer les films existants
            movies.forEach(movie => {
                const movieDiv = document.createElement('div');
                movieDiv.innerHTML = `
                    <h3>${movie.title}</h3>
                    <p>Réalisateur: ${movie.director}</p>
                    <p>Cinéma: ${movie.cinema}</p>
                `;
                moviesList.appendChild(movieDiv);
            });
        })
        .catch(error => console.error('Erreur:', error));
}

// Appeler la fonction au chargement de la page
window.onload = fetchMovies;
