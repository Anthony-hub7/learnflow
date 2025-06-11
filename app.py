from bottle import Bottle, request, redirect, template, response
import uuid
import time
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
    """Récupère ou crée une session"""
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
    session = request.session
    session.pop('isAdmin', None)  # supprime la clé isAdmin
    return redirect('/login')

@app.route('/')
def index():
    session = request.session
    is_admin = session.get('isAdmin', False)
    return template('home', is_admin=is_admin)

if __name__ == '__main__':
    app.run(host='localhost', port=8081, debug=True)