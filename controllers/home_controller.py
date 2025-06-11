import os
import sys
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from models.db import test_db_connection
from bottle import route, template
from controllers.base_controller import BaseController

def home_routes(app):
    base_ctrl = BaseController()
    @app.route('/')
    def home():
        return base_ctrl.home('home', template=template, db_status=None)

class HomeController(BaseController):
    """
    Contrôleur pour la gestion de la page d'accueil.
    Hérite du contrôleur de base et fournit les fonctionnalités de la page d'accueil.
    """

    def index(self):
        """
        Affiche la page d'accueil avec un résumé des données.
        
        Returns:
            Le template 'home/index.html' avec les statistiques et informations récentes
        """
        # ...existing code...

    def about(self):
        """
        Affiche la page À propos.
        
        Returns:
            Le template 'home/about.html' avec les informations sur l'application
        """
        # ...existing code...

    def dashboard(self):
        """
        Affiche le tableau de bord avec les statistiques.
        
        Returns:
            Le template 'home/dashboard.html' avec les statistiques de l'application
            
        Notes:
            Inclut des statistiques sur les documents, catégories et tags
        """
        # ...existing code...
