from bottle import Bottle, request, response, template, redirect
from models.category_model import categoriesModel
from controllers.base_controller import BaseController

class categoriesController(BaseController):
    """
    Contrôleur pour la gestion des catégories.
    Hérite du contrôleur de base pour les opérations CRUD standards.
    """

    def __init__(self):
        self.app = Bottle()
        self.register_routes()

    def register_routes(self):
        self.app.route('/categories', callback=self.list_categories)
        self.app.route('/categories/<id:int>', callback=self.show_category)
        self.app.route('/categories/create', method=['GET', 'POST'], callback=self.create_category)
        self.app.route('/categories/<id:int>/edit', method=['GET', 'POST'], callback=self.edit_category)
        self.app.route('/categories/<id:int>/delete', method=['POST'], callback=self.delete_category)

    def list_categories(self):
        """
        Affiche la liste de toutes les catégories.
        
        Returns:
            Le template 'categories/index.html' avec la liste des catégories
        """
        isAdmin = request.session.get('isAdmin', False)
        return self.list(categoriesModel, 'categories/index', context_name='categories', template=template, isAdmin=isAdmin)

    def show_category(self, id):
        """
        Affiche les détails d'une catégorie spécifique.
        
        Args:
            id: L'identifiant de la catégorie à afficher
            
        Returns:
            Le template 'categories/show.html' avec les détails de la catégorie
        """
        isAdmin = request.session.get('isAdmin', False)
        model = categoriesModel()
        category = model.get(id)
        if not category:
            from bottle import response
            response.status = 404
            return 'Non trouvé'
        from models.subjects_model import subjectsModel
        subjects = subjectsModel().subjects_by_category(id)
        return template('categories/show', category=category, subjects=subjects, isAdmin=isAdmin)

    def create_category(self):
        """
        Gère la création d'une nouvelle catégorie.
        
        Args:
            request: L'objet requête contenant les données du formulaire
            
        Returns:
            Redirige vers la liste des catégories après la création
        """
        isAdmin = request.session.get('isAdmin', True)
        return self.create(categoriesModel, 'categories/create', request, '/categories', template=template, isAdmin=isAdmin)

    def edit_category(self, id):
        """
        Gère la modification d'une catégorie existante.
        
        Args:
            id: L'identifiant de la catégorie à modifier
            request: L'objet requête contenant les données du formulaire
            
        Returns:
            Redirige vers la liste des catégories après la modification
        """
        isAdmin = request.session.get('isAdmin', False)
        return self.edit(categoriesModel, 'categories/edit', id, request, '/categories', template=template, isAdmin=isAdmin)

    def delete_category(self, id):
        """
        Supprime une catégorie spécifique.
        
        Args:
            id: L'identifiant de la catégorie à supprimer
            
        Returns:
            Redirige vers la liste des catégories après la suppression
        """
        isAdmin = request.session.get('isAdmin', False)
        return self.delete(categoriesModel, id, '/categories', isAdmin=isAdmin)

categories_ctrl = categoriesController().app
