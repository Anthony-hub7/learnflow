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
