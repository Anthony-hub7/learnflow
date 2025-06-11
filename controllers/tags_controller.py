from bottle import Bottle, request, response, template, redirect, json_dumps
from models.tag_model import TagModel
from controllers.base_controller import BaseController

class TagsController(BaseController):
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
        isAdmin = request.session.get('isAdmin', False)
        return self.list(TagModel, 'tags/index', context_name='tags', template=template, isAdmin=isAdmin)
    def show_tag(self, id):
        isAdmin = request.session.get('isAdmin', False)
        return self.show(TagModel, 'tags/show', id, context_name='tag', template=template)

    def create_tag(self):
        isAdmin = request.session.get('isAdmin', False)
        return self.create(TagModel, 'tags/create', request, '/tags', template=template, tag=None)

    def edit_tag(self, id):
        isAdmin = request.session.get('isAdmin', False)
        return self.edit(TagModel, 'tags/edit', id, request, '/tags', template=template)

    def delete_tag(self, id):
        return self.delete(TagModel, id, '/tags')

tags_ctrl = TagsController().app
