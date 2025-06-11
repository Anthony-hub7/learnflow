from bottle import Bottle, request, response, template, redirect, json_dumps
from models.document_model import DocumentModel
from models.subjects_model import subjectsModel
from models.document_tag_model import DocumentTagModel
from controllers.base_controller import BaseController

class DocumentsController(BaseController):
    """
    Contrôleur pour la gestion des documents.
    Hérite du contrôleur de base pour les opérations CRUD standards.
    Gère l'upload, le stockage et la récupération des documents.
    """

    def __init__(self):
        self.app = Bottle()
        self.register_routes()

    def register_routes(self):
        self.app.route('/documents', callback=self.list_documents)
        self.app.route('/documents/<id:int>', callback=self.show_document)
        self.app.route('/documents/create', method=['GET', 'POST'], callback=self.create_document)
        self.app.route('/documents/<id:int>/edit', method=['GET', 'POST'], callback=self.edit_document)
        self.app.route('/documents/<id:int>/delete', method=['POST'], callback=self.delete_document)
        self.app.route('/documents/<id:int>/download', callback=self.download_document)

    def list_documents(self):
        """
        Affiche la liste de tous les documents.
        
        Returns:
            Le template 'documents/index.html' avec la liste des documents
        """
        isAdmin = request.session.get('isAdmin', False)
        return self.list(DocumentModel, 'documents/index', context_name='documents', template=template, isAdmin=isAdmin)

    def show_document(self, id):
        """
        Affiche les détails d'un document spécifique.
        
        Args:
            id: L'identifiant du document à afficher
            
        Returns:
            Le template 'documents/show.html' avec les détails du document
        """
        isAdmin = request.session.get('isAdmin', False)
        document_model = DocumentModel()
        document = document_model.get(id)
        
        if not document:
            document_model.close()
            response.status = 404
            return 'Document non trouvé'

        # Récupérer les tags du document
        tag_model = DocumentTagModel()
        document['tags'] = tag_model.get_by_document(id)
        tag_model.close()
        
        document_model.close()
        return template('documents/show', document=document, isAdmin=isAdmin)

    def create_document(self):
        """
        Gère la création d'un nouveau document avec upload de fichier.
        
        Args:
            request: L'objet requête contenant les données du formulaire et le fichier
            
        Returns:
            Redirige vers la liste des documents après la création
            
        Notes:
            Gère l'upload du fichier et sa sauvegarde sur le serveur
        """
        isAdmin = request.session.get('isAdmin', False)
        subjects = subjectsModel().all()

        if request.method == 'POST':
            data = {k: request.forms.get(k) for k in request.forms}

            upload = request.files.get('file')
            if upload:
                data['file_name'] = upload.filename
                data['mime_type'] = upload.content_type
                data['file_content'] = upload.file.read()
            else:
                data['file_name'] = None
                data['mime_type'] = None
                data['file_content'] = None

            instance = DocumentModel()
            instance.create(**data)
            instance.close()
            from bottle import redirect
            redirect('/documents')

        return template('documents/create', subjects=subjects, document=None, isAdmin=isAdmin)


    def edit_document(self, id):
        """
        Gère la modification d'un document existant.
        
        Args:
            id: L'identifiant du document à modifier
            request: L'objet requête contenant les données du formulaire
            
        Returns:
            Redirige vers la liste des documents après la modification
        """
        isAdmin = request.session.get('isAdmin', False)
        subjects = subjectsModel().all()
        instance = DocumentModel()
        document = instance.get(id)
        if not document:
            instance.close()
            response.status = 404
            return 'Document non trouvé'

        if request.method == 'POST':
            data = {k: request.forms.get(k) for k in request.forms if k!= 'file'}

            upload = request.files.get('file')
            if upload and upload.filename:
                # Nouveau fichier uploadé -> on met à jour les infos
                data['file_name'] = upload.filename
                data['mime_type'] = upload.content_type
                data['file_content'] = upload.file.read()
            else:
                # Pas de nouveau fichier -> on garde les anciennes valeurs
                data['file_name'] = document['file_name']
                data['mime_type'] = document['mime_type']
                data['file_content'] = document['file_content']

            instance.update(id, **data)
            instance.close()
            redirect('/documents')

        instance.close()
        return template('documents/edit', document=document, subjects=subjects, isAdmin=isAdmin)


    def delete_document(self, id):
        """
        Supprime un document spécifique et son fichier associé.
        
        Args:
            id: L'identifiant du document à supprimer
            
        Returns:
            Redirige vers la liste des documents après la suppression
            
        Notes:
            Supprime également le fichier physique du serveur
        """
        return self.delete(DocumentModel, id, '/documents')
    def download_document(self, id):
        """
        Permet le téléchargement d'un document.
        
        Args:
            id: L'identifiant du document à télécharger
            
        Returns:
            Le fichier en téléchargement avec les en-têtes appropriés
        """
        instance = DocumentModel()
        document = instance.get(id)
        instance.close()

        if not document:
            response.status = 404
            return 'Document non trouvé'

        # Renvoie le contenu du fichier avec les headers pour téléchargement
        response.content_type = document['mime_type'] or 'application/octet-stream'
        response.headers['Content-Disposition'] = f'attachment; filename="{document["file_name"]}"'
        return document['file_content']

documents_ctrl = DocumentsController().app
