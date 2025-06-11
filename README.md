# LearnFlow - Gestionnaire de Documents Pédagogiques

LearnFlow est une application web Python développée avec le framework Bottle, suivant l'architecture MVC. Elle permet de gérer des documents pédagogiques avec un système de catégorisation, de tags et de sujets.

## Fonctionnalités

- 📚 Gestion des documents avec upload de fichiers
- 🏷️ Système de tags pour une meilleure organisation
- 📁 Catégorisation des documents
- 📌 Gestion des sujets d'étude
- 🔒 Système d'authentification administrateur
- 📊 Interface utilisateur intuitive

## Prérequis

- Python 3.8 ou supérieur
- MySQL Server (WAMP, XAMPP ou installation standalone)
- pip (gestionnaire de paquets Python)

## Structure du projet

```
learnflow/
├── app.py                  # Point d'entrée de l'application
├── controllers/            # Logique métier
├── models/                # Accès à la base de données
├── views/                 # Templates HTML
├── requirements.txt       # Dépendances Python
└── learnflow.sql         # Script de création de la base de données
```

## Installation

1. Clonez le dépôt :
   ```bash
   git clone [url-du-depot]
   cd learnflow
   ```

2. Créez un environnement virtuel (recommandé) :
   ```bash
   python -m venv venv
   source venv/bin/activate  # Pour Linux/Mac
   # ou
   venv\Scripts\activate     # Pour Windows
   ```

3. Installez les dépendances :
   ```bash
   pip install -r requirements.txt
   ```

4. Configuration de la base de données :

   a. Connectez-vous à MySQL :
   ```bash
   mysql -u root -p
   ```
   
   b. Créez la base de données :
   ```sql
   CREATE DATABASE learnflow;
   ```
   
   c. Importez le schéma de la base de données :
   ```bash
   mysql -u root -p learnflow < learnflow.sql
   ```

5. Configurez la connexion à la base de données :
   - Ouvrez `models/db.py`
   - Modifiez les paramètres de connexion selon votre configuration :
     ```python
     DB_HOST = 'localhost'
     DB_USER = 'votre_utilisateur'
     DB_PASS = 'votre_mot_de_passe'
     DB_NAME = 'learnflow'
     ```

## Lancement de l'application

1. Activez l'environnement virtuel si ce n'est pas déjà fait :
   ```bash
   source venv/bin/activate  # Pour Linux/Mac
   # ou
   venv\Scripts\activate     # Pour Windows
   ```

2. Démarrez l'application :
   ```bash
   python app.py
   ```

3. Accédez à l'application :
   - Ouvrez votre navigateur
   - Visitez `http://localhost:8081`

## Authentification

- URL de connexion : `http://localhost:8081/login`
- Mot de passe par défaut : `motdepasseadmin`
- Il est recommandé de changer le mot de passe dans le code source pour la production

## Structure de la base de données

- `categories` : Stockage des catégories de documents
- `subjects` : Gestion des sujets d'étude
- `documents` : Informations sur les documents uploadés
- `tags` : Système de tags
- `document_tags` : Relations entre documents et tags

## Dépendances principales

- Bottle : Framework web léger
- PyMySQL : Pilote MySQL pour Python
- autres dépendances listées dans requirements.txt

## Développement

Pour contribuer au projet :
1. Suivez l'architecture MVC
2. Respectez la structure des contrôleurs existants
3. Documentez votre code en français
4. Testez vos modifications avant de les soumettre

## Problèmes courants

1. Erreur de connexion à la base de données :
   - Vérifiez les paramètres dans `models/db.py`
   - Assurez-vous que MySQL est en cours d'exécution
   - Vérifiez les permissions de l'utilisateur MySQL

2. Erreur d'upload de fichiers :
   - Vérifiez les permissions du dossier d'upload
   - Assurez-vous que le dossier existe

## Support

Pour toute question ou problème :
1. Consultez la documentation des modèles et contrôleurs
2. Vérifiez les logs de l'application
3. Contactez l'équipe de développement

---

© 2025 LearnFlow - Développé avec ❤️ pour l'éducation
