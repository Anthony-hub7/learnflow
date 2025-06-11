class BaseController:
    """
    Contrôleur de base fournissant les opérations CRUD communes pour tous les modèles.
    Cette classe sert de base pour tous les autres contrôleurs de l'application.
    """

    def list(self, model, template_name, context_name=None, **kwargs):
        """
        Récupère et affiche la liste de tous les éléments d'un modèle.
        
        Args:
            model: Le modèle de données à utiliser
            template_name: Le nom du template à utiliser pour l'affichage
            context_name: Le nom de la variable de contexte (optionnel)
            **kwargs: Arguments additionnels pour le template
        
        Returns:
            Le template rendu avec la liste des éléments
        """
        instance = model()
        items = instance.all()
        instance.close()
        key = context_name or model.__name__.replace('Model','').lower()
        return kwargs.get('template', template_name)(template_name, **{key: items, **kwargs})

    def show(self, model, template_name, id, context_name=None, **kwargs):
        """
        Affiche les détails d'un élément spécifique.
        
        Args:
            model: Le modèle de données à utiliser
            template_name: Le nom du template à utiliser
            id: L'identifiant de l'élément à afficher
            context_name: Le nom de la variable de contexte (optionnel)
            **kwargs: Arguments additionnels pour le template
        
        Returns:
            Le template rendu avec les détails de l'élément ou une page 404
        """
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
        """
        Gère la création d'un nouvel élément.
        
        Args:
            model: Le modèle de données à utiliser
            template_name: Le nom du template pour le formulaire
            request: L'objet requête contenant les données du formulaire
            redirect_url: L'URL de redirection après la création
            **kwargs: Arguments additionnels pour le template
        
        Returns:
            Redirige vers redirect_url après la création ou affiche le formulaire
        """
        if request.method == 'POST':
            data = {k: request.forms.get(k) for k in request.forms}
            instance = model()
            instance.create(**data)
            instance.close()
            from bottle import redirect
            redirect(redirect_url)
        return kwargs.get('template', template_name)(template_name, **kwargs)

    def edit(self, model, template_name, id, request, redirect_url, **kwargs):
        """
        Gère la modification d'un élément existant.
        
        Args:
            model: Le modèle de données à utiliser
            template_name: Le nom du template pour le formulaire
            id: L'identifiant de l'élément à modifier
            request: L'objet requête contenant les données du formulaire
            redirect_url: L'URL de redirection après la modification
            **kwargs: Arguments additionnels pour le template
        
        Returns:
            Redirige vers redirect_url après la modification ou affiche le formulaire
        """
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
        """
        Supprime un élément spécifique.
        
        Args:
            model: Le modèle de données à utiliser
            id: L'identifiant de l'élément à supprimer
            redirect_url: L'URL de redirection après la suppression
        
        Returns:
            Redirige vers redirect_url après la suppression
        """
        instance = model()
        instance.delete(id)
        instance.close()
        from bottle import redirect
        redirect(redirect_url)

    def home(self, template_name, **kwargs):
        """
        Affiche la page d'accueil.
        
        Args:
            template_name: Le nom du template à utiliser
            **kwargs: Arguments additionnels pour le template
        
        Returns:
            Le template de la page d'accueil rendu
        """
        return kwargs.get('template', template_name)(template_name, **kwargs)
