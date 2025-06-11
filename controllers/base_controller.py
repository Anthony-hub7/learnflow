class BaseController:
    def list(self, model, template_name, context_name=None, **kwargs):
        instance = model()
        items = instance.all()
        instance.close()
        key = context_name or model.__name__.replace('Model','').lower()
        return kwargs.get('template', template_name)(template_name, **{key: items, **kwargs})

    def show(self, model, template_name, id, context_name=None, **kwargs):
        instance = model()
        item = instance.get(id)
        instance.close()
        if not item:
            from bottle import response
            response.status = 404
            return 'Non trouvé'
        key = context_name or model.__name__.replace('Model','').lower()
        return kwargs.get('template', template_name)(template_name, **{key: item, **kwargs})

    def create(self, model, template_name, request, redirect_url, **kwargs):
        if request.method == 'POST':
            data = {k: request.forms.get(k) for k in request.forms}
            instance = model()
            instance.create(**data)
            instance.close()
            from bottle import redirect
            redirect(redirect_url)
        return kwargs.get('template', template_name)(template_name, **kwargs)

    def edit(self, model, template_name, id, request, redirect_url, **kwargs):
        instance = model()
        item = instance.get(id)
        if not item:
            instance.close()
            from bottle import response
            response.status = 404
            return 'Non trouvé'
        if request.method == 'POST':
            data = {k: request.forms.get(k) for k in request.forms}
            instance.update(id, **data)
            instance.close()
            from bottle import redirect
            redirect(redirect_url)
        instance.close()
        return kwargs.get('template', template_name)(template_name, **{model.__name__.replace('Model','').lower(): item, **kwargs})

    def delete(self, model, id, redirect_url):
        instance = model()
        instance.delete(id)
        instance.close()
        from bottle import redirect
        redirect(redirect_url)

    def home(self, template_name, **kwargs):
        return kwargs.get('template', template_name)(template_name, **kwargs)
