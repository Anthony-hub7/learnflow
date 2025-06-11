from bottle import Bottle, request, response, template, redirect, json_dumps
from models.subjects_model import subjectsModel
from models.category_model import categoriesModel
from controllers.base_controller import BaseController

class subjectsController(BaseController):
    def __init__(self):
        self.app = Bottle()
        self.register_routes()

    def register_routes(self):
        self.app.route('/subjects', callback=self.list_subjects)
        self.app.route('/subjects/<id:int>', callback=self.show_subject)
        self.app.route('/subjects/create', method=['GET', 'POST'], callback=self.create_subject)
        self.app.route('/subjects/<id:int>/edit', method=['GET', 'POST'], callback=self.edit_subject)
        self.app.route('/subjects/<id:int>/delete', method=['POST'], callback=self.delete_subject)

        # Route supplémentaire : liste des noms de catégories
        self.app.route('/subjects/categories/names', callback=self.get_category_names)

    def list_subjects(self):
        isAdmin = request.session.get('isAdmin', False)
        return self.list(subjectsModel, 'subjects/index', context_name='subjects', template=template, isAdmin=isAdmin)

    def show_subject(self, id):
        isAdmin = request.session.get('isAdmin', False)
        instance = subjectsModel()
        subject = instance.get(id)
        if not subject:
            instance.close()
            response.status = 404
            return 'Matière non trouvée'
        
        # Récupérer les documents associés
        documents = instance.get_documents(id)
        instance.close()
        
        return template('subjects/show', subject=subject, documents=documents, isAdmin=isAdmin)

    def create_subject(self):
        isAdmin = request.session.get('isAdmin', False)
        categories = categoriesModel().all()
        return self.create(subjectsModel, 'subjects/create', request, '/subjects', template=template, categories=categories, isAdmin=isAdmin)

    def edit_subject(self, id):
        isAdmin = request.session.get('isAdmin', False)
        categories = categoriesModel().all()
        return self.edit(subjectsModel, 'subjects/edit', id, request, '/subjects', template=template, categories=categories, isAdmin=isAdmin)

    def delete_subject(self, id):
        isAdmin = request.session.get('isAdmin', False)
        return self.delete(subjectsModel, id, '/subjects')

    def get_category_names(self):
        model = categoriesModel()
        categories = model.all()
        # Retourne uniquement les noms et ids en JSON
        result = [{'id': c['id'], 'name': c['name']} for c in categories]
        response.content_type = 'application/json'
        return json_dumps(result)

subjects_ctrl = subjectsController().app
