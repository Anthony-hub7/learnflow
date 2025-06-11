from bottle import Bottle, request, response, template, redirect, json_dumps
from models.tag_model import TagModel
from controllers.base_controller import BaseController

class TagsController(BaseController):
    """
    Contrôleur pour la gestion des tags.
    Hérite du contrôleur de base pour les opérations CRUD standards.
    Gère l'organisation et la catégorisation des documents via les tags.
    """

    def __init__(self):
        self.app = Bottle()
        self.register_routes()

    def register_routes(self):
        self.app.route('/tags', callback=self.list_tags)
        self.app.route('/tags/<id:int>', callback=self.show_tag)
        self.app.route('/tags/create', method=['GET', 'POST'], callback=self.create_tag)
        self.app.route('/tags/<id:int>/edit', method=['GET', 'POST'], callback=self.edit_tag)
        self.app.route('/tags/<id:int>/delete', method=['POST'], callback=self.delete_tag)

    def list_tags(self):
        """
        Affiche la liste de tous les tags.
        
        Returns:
            Le template 'tags/index.html' avec la liste des tags
        """
        isAdmin = request.session.get('isAdmin', False)
        return self.list(TagModel, 'tags/index', context_name='tags', template=template, isAdmin=isAdmin)
    def show_tag(self, id):
        """
        Affiche les détails d'un tag spécifique.
        
        Args:
            id: L'identifiant du tag à afficher
            
        Returns:
            Le template 'tags/show.html' avec les détails du tag et les documents associés
        """
        isAdmin = request.session.get('isAdmin', False)
        return self.show(TagModel, 'tags/show', id, context_name='tag', template=template)

    def create_tag(self):
        """
        Gère la création d'un nouveau tag.
        
        Args:
            request: L'objet requête contenant les données du formulaire
            
        Returns:
            Redirige vers la liste des tags après la création
        """
        isAdmin = request.session.get('isAdmin', False)
        return self.create(TagModel, 'tags/create', request, '/tags', template=template, tag=None, isAdmin = isAdmin)

    def edit_tag(self, id):
        """
        Gère la modification d'un tag existant.
        
        Args:
            id: L'identifiant du tag à modifier
            request: L'objet requête contenant les données du formulaire
            
        Returns:
            Redirige vers la liste des tags après la modification
        """
        isAdmin = request.session.get('isAdmin', False)
        return self.edit(TagModel, 'tags/edit', id, request, '/tags', template=template, isAdmin = isAdmin)

    def delete_tag(self, id):
        """
        Supprime un tag spécifique.
        
        Args:
            id: L'identifiant du tag à supprimer
            
        Returns:
            Redirige vers la liste des tags après la suppression
            
        Notes:
            Supprime également toutes les relations avec les documents
        """
        return self.delete(TagModel, id, '/tags')

tags_ctrl = TagsController().app
