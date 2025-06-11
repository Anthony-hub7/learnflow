from bottle import Bottle, request, response, template, redirect
from models.document_tag_model import DocumentTagModel
from models.document_model import DocumentModel
from models.tag_model import TagModel
from controllers.base_controller import BaseController

class DocumentTagsController(BaseController):
    def __init__(self):
        self.app = Bottle()
        self.register_routes()

    def register_routes(self):
        self.app.route('/documents/<document_id:int>/tags', method='GET', callback=self.list_tags_for_document)
        self.app.route('/documents/<document_id:int>/tags', method='POST', callback=self.add_tag_to_document)
        self.app.route('/documents/<document_id:int>/tags/<tag_id:int>', method=['POST'], callback=self.remove_tag_from_document)

        self.app.route('/tags/<tag_id:int>/documents', method='GET', callback=self.list_documents_for_tag)
        self.app.route('/tags/<tag_id:int>/documents', method='POST', callback=self.add_documents_to_tag)
        self.app.route('/tags/summary', method='GET', callback=self.tag_summary)

    def list_tags_for_document(self, document_id):
        isAdmin = request.session.get('isAdmin', False)
        try:
            doc_model = DocumentModel()
            document = doc_model.get(document_id)
            if not document:
                response.status = 404
                return 'Document non trouvé'

            tag_model = TagModel()
            all_tags = tag_model.all()

            dtag_model = DocumentTagModel()
            current_tags = dtag_model.get_by_document(document_id)

            return template('documents_tag/list',
                            document_id=document_id,
                            document_title=document['title'],
                            tags=current_tags,
                            all_tags=all_tags,
                            isAdmin=isAdmin)
        finally:
            try: doc_model.close()
            except: pass
            try: tag_model.close()
            except: pass
            try: dtag_model.close()
            except: pass

    def add_tag_to_document(self, document_id):
        tag_ids = request.forms.getall('tag_ids[]')
        if not tag_ids:
            response.status = 400
            return 'Aucun tag sélectionné'

        try:
            model = DocumentTagModel()
            model.add_multiple(document_id, [int(tid) for tid in tag_ids])
        except Exception as e:
            response.status = 500
            return f'Erreur lors de l\'ajout des tags: {str(e)}'
        finally:
            try: model.close()
            except: pass

        return redirect(f'/documents/{document_id}/tags')

    def remove_tag_from_document(self, document_id, tag_id):
        if request.forms.get('_method') != 'DELETE':
            response.status = 405
            return 'Méthode non autorisée'

        try:
            model = DocumentTagModel()
            result = model.remove(document_id, int(tag_id))
        except Exception as e:
            response.status = 500
            return f'Erreur lors de la suppression: {str(e)}'
        finally:
            try: model.close()
            except: pass

        if result:
            return redirect(f'/documents/{document_id}/tags')
        else:
            response.status = 400
            return 'Erreur lors de la suppression du tag'

    def list_documents_for_tag(self, tag_id):
        isAdmin = request.session.get('isAdmin', False)
        try:
            tag_model = TagModel()
            tag = tag_model.get(tag_id)
            if not tag:
                response.status = 404
                return 'Tag non trouvé'

            doc_model = DocumentModel()
            all_documents = doc_model.all()

            dtag_model = DocumentTagModel()
            current_documents = dtag_model.get_by_tag(tag_id)

            return template('documents_tag/documents_by_tag',
                            tag_id=tag_id,
                            tag_name=tag['name'],
                            documents=current_documents,
                            all_documents=all_documents,
                            isAdmin=isAdmin)
        finally:
            try: tag_model.close()
            except: pass
            try: doc_model.close()
            except: pass
            try: dtag_model.close()
            except: pass

    def add_documents_to_tag(self, tag_id):
        doc_ids = request.forms.getall('document_ids[]')
        if not doc_ids:
            response.status = 400
            return 'Aucun document sélectionné'

        try:
            model = DocumentTagModel()
            model.add_to_multiple([int(did) for did in doc_ids], tag_id)
        except Exception as e:
            response.status = 500
            return f'Erreur lors de l\'ajout des documents: {str(e)}'
        finally:
            try: model.close()
            except: pass

        return redirect(f'/tags/{tag_id}/documents')

    def tag_summary(self):
        isAdmin = request.session.get('isAdmin', False)
        try:
            model = DocumentTagModel()
            summary = model.get_document_count_by_tag()
            return template('documents_tag/summary', tags=summary, isAdmin=isAdmin)
        finally:
            try: model.close()
            except: pass


document_tags_ctrl = DocumentTagsController().app
