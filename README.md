# Projet Bottle MVC avec connexion PDO (WAMP)

Ce projet est une application web Python utilisant le framework Bottle, organisée selon le modèle MVC, avec une connexion à une base de données MySQL (WAMP) via PDO (utilisation de la bibliothèque `pymysql` pour simuler PDO en Python).

## Structure du projet
- `app.py` : Point d'entrée, configuration Bottle.
- `controllers/` : Contrôleurs (logique métier).
- `models/` : Modèles (accès base de données).
- `views/` : Templates HTML.
- `requirements.txt` : Dépendances Python.

## Installation
1. Installez les dépendances :
   ```bash
   pip install -r requirements.txt
   ```
2. Configurez votre base de données dans `models/db.py`.
3. Lancez l'application :
   ```bash
   python app.py
   ```

## Dépendances
- Bottle
- PyMySQL

---

Pour toute modification, suivez l'architecture MVC et adaptez la configuration de la base selon votre environnement WAMP.
