"""
Point d'entrée principal de l'application LearnFlow.
Configure le serveur Bottle, gère les sessions et les routes principales.

Ce module:
- Initialise l'application Bottle
- Configure la gestion des sessions en mémoire
- Enregistre les routes des différents contrôleurs
- Gère l'authentification (login/logout)
"""

from bottle import Bottle, request, redirect, template, response, static_file
import uuid
import time
import os
from controllers.home_controller import home_routes
from controllers.category_controller import categories_ctrl
from controllers.subjects_controller import subjects_ctrl
from controllers.tags_controller import tags_ctrl
from controllers.documents_controller import documents_ctrl
from controllers.document_tag_controller import document_tags_ctrl

app = Bottle()

# Stockage des sessions en mémoire
sessions = {}
SESSION_TIMEOUT = 3600  # 1 heure

def get_session():
    """
    Récupère ou crée une session pour l'utilisateur courant.
    
    Returns:
        dict: Les données de session de l'utilisateur
        
    Notes:
        - Vérifie si un cookie de session existe
        - Si la session est expirée, en crée une nouvelle
        - Met à jour le timestamp de dernier accès
    """
    session_id = request.get_cookie('session_id')
    
    if session_id and session_id in sessions:
        session_data = sessions[session_id]
        if time.time() - session_data.get('last_access', 0) < SESSION_TIMEOUT:
            session_data['last_access'] = time.time()
            return session_data
        else:
            del sessions[session_id]
    
    session_id = str(uuid.uuid4())
    sessions[session_id] = {
        'id': session_id,
        'last_access': time.time()
    }
    
    response.set_cookie('session_id', session_id, max_age=SESSION_TIMEOUT, httponly=True)
    return sessions[session_id]

# Hook pour injecter la session dans request
@app.hook('before_request')
def inject_session():
    """
    Hook exécuté avant chaque requête pour injecter la session.
    Rend la session accessible via request.session dans toute l'application.
    """
    request.session = get_session()

# Enregistrement des routes principales
home_routes(app)
app.mount('/', categories_ctrl)
app.mount('/', subjects_ctrl)
app.mount('/', tags_ctrl)
app.mount('/', documents_ctrl)
app.mount('/', document_tags_ctrl)

@app.route('/login', method=['GET', 'POST'])
def login():
    """
    Gère la page de connexion et l'authentification.
    
    Returns:
        str: Template de login ou redirection vers l'accueil si connexion réussie
        
    Notes:
        - Vérifie le mot de passe en POST
        - Stocke l'état d'authentification dans la session
        - Affiche une erreur si mot de passe incorrect
    """
    session = request.session  # accès à la session
    if request.method == 'POST':
        password = request.forms.get('password')
        if password == 'motdepasseadmin':
            session['isAdmin'] = True
            return redirect('/')
        else:
            return template('login', error='Mot de passe incorrect')
    isAdmin = session.get('isAdmin', False)
    return template('login', error=None, isAdmin=isAdmin)

@app.route('/logout')
def logout():
    """
    Gère la déconnexion de l'utilisateur.
    
    Returns:
        Redirection vers la page de login
        
    Notes:
        Supprime la marque d'authentification de la session
    """
    session = request.session
    session.pop('isAdmin', None)  # supprime la clé isAdmin
    return redirect('/login')

@app.route('/')
def index():
    """
    Page d'accueil de l'application.
    
    Returns:
        str: Template de la page d'accueil avec l'état d'authentification
    """
    session = request.session
    is_admin = session.get('isAdmin', False)
    return template('home', is_admin=is_admin)

@app.route('/static/<filepath:path>')
def serve_static(filepath):
    """Sert les fichiers statiques depuis le dossier static"""
    return static_file(filepath, root='./views/static/')

if __name__ == '__main__':
    """
    Point d'entrée pour le démarrage du serveur en mode développement.
    Configure le serveur sur localhost:8081 avec le mode debug activé.
    """
    app.run(host='localhost', port=8081, debug=True)