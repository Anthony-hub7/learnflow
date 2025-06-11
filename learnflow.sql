-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 09 juin 2025 à 19:02
-- Version du serveur : 8.0.31
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `learnflow`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `created_at`) VALUES
(4, 'Lycée', 'Parcours secondaire pour préparer le baccalauréat', '2025-06-09 18:54:48'),
(5, 'Licence', 'Parcours universitaire de premier cycle', '2025-06-09 18:54:48'),
(6, 'Master', 'Parcours universitaire de deuxième cycle', '2025-06-09 18:54:48'),
(7, 'Doctorat', 'Parcours universitaire de troisième cycle pour la recherche avancée', '2025-06-09 18:54:48'),
(8, 'Formation Professionnelle', 'Parcours technique et professionnel spécialisé', '2025-06-09 18:54:48'),
(9, 'Prépa', 'Classes préparatoires aux grandes écoles', '2025-06-09 18:54:48'),
(10, 'Formation Continue', 'Parcours pour adultes en reprise d’études ou formation complémentaire', '2025-06-09 18:54:48'),
(11, 'MOOC', 'Cours en ligne ouverts à tous pour autoformation', '2025-06-09 18:54:48'),
(12, 'Certifications', 'Parcours de certifications professionnelles reconnues', '2025-06-09 18:54:48');

-- --------------------------------------------------------

--
-- Structure de la table `documents`
--

DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` enum('lesson','exercise','exam','solution') NOT NULL,
  `description` text,
  `file_content` longblob NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_subject` (`subject_id`),
  KEY `idx_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `document_tags`
--

DROP TABLE IF EXISTS `document_tags`;
CREATE TABLE IF NOT EXISTS `document_tags` (
  `document_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`document_id`,`tag_id`),
  KEY `tag_id` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
CREATE TABLE IF NOT EXISTS `subjects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `subjects`
--

INSERT INTO `subjects` (`id`, `category_id`, `name`, `description`, `created_at`) VALUES
(29, 4, 'Mathématiques', 'Cours de mathématiques pour le lycée, incluant algèbre, géométrie, trigonométrie et analyse.', '2025-06-09 18:58:42'),
(30, 4, 'Physique', 'Notions de base en mécanique, électricité, et optique.', '2025-06-09 18:58:42'),
(31, 4, 'Chimie', 'Principes fondamentaux de chimie générale.', '2025-06-09 18:58:42'),
(32, 4, 'Biologie', 'Bases de la biologie cellulaire et la génétique.', '2025-06-09 18:58:42'),
(33, 4, 'Français', 'Langue et littérature française, expression écrite et orale.', '2025-06-09 18:58:42'),
(34, 4, 'Histoire-Géographie', 'Cours d’histoire mondiale et géographie physique.', '2025-06-09 18:58:42'),
(35, 4, 'Langues Vivantes', 'Apprentissage des langues étrangères.', '2025-06-09 18:58:42'),
(36, 5, 'Mathématiques générales', 'Cours fondamentaux de mathématiques pour le premier cycle universitaire.', '2025-06-09 18:58:42'),
(37, 5, 'Physique générale', 'Physique couvrant la mécanique, thermodynamique, et électromagnétisme.', '2025-06-09 18:58:42'),
(38, 5, 'Informatique', 'Introduction à la programmation, algorithmes, et bases de données.', '2025-06-09 18:58:42'),
(39, 5, 'Chimie organique', 'Étude des composés organiques et leurs réactions.', '2025-06-09 18:58:42'),
(40, 5, 'Économie', 'Principes économiques et introduction à la micro/macroéconomie.', '2025-06-09 18:58:42'),
(41, 5, 'Psychologie', 'Bases de la psychologie générale.', '2025-06-09 18:58:42'),
(42, 5, 'Philosophie', 'Introduction à la philosophie et à la pensée critique.', '2025-06-09 18:58:42'),
(43, 6, 'Mathématiques avancées', 'Analyse complexe, algèbre abstraite, topologie.', '2025-06-09 18:58:42'),
(44, 6, 'Intelligence Artificielle', 'Apprentissage automatique, réseaux neuronaux, traitement du langage naturel.', '2025-06-09 18:58:42'),
(45, 6, 'Physique quantique', 'Mécanique quantique et applications.', '2025-06-09 18:58:42'),
(46, 6, 'Chimie analytique', 'Techniques modernes d’analyse chimique.', '2025-06-09 18:58:42'),
(47, 6, 'Statistiques avancées', 'Modèles statistiques et inférence bayésienne.', '2025-06-09 18:58:42'),
(48, 6, 'Gestion de projet', 'Planification et gestion de projets complexes.', '2025-06-09 18:58:42'),
(49, 6, 'Sciences de l’environnement', 'Études avancées en écologie et environnement.', '2025-06-09 18:58:42'),
(50, 7, 'Recherche mathématique', 'Théories et problématiques de recherche en mathématiques pures.', '2025-06-09 18:58:42'),
(51, 7, 'Physique théorique', 'Approfondissement en relativité, physique des particules.', '2025-06-09 18:58:42'),
(52, 7, 'Informatique théorique', 'Complexité algorithmique, logique et systèmes formels.', '2025-06-09 18:58:42'),
(53, 7, 'Biochimie avancée', 'Mécanismes biochimiques complexes.', '2025-06-09 18:58:42'),
(54, 7, 'Philosophie des sciences', 'Études critiques et épistémologiques.', '2025-06-09 18:58:42'),
(55, 7, 'Sciences cognitives', 'Interdisciplinarité entre psychologie, neuroscience et informatique.', '2025-06-09 18:58:42'),
(56, 8, 'Techniques de maintenance industrielle', 'Maintenance préventive et corrective.', '2025-06-09 18:58:42'),
(57, 8, 'Gestion de projet agile', 'Méthodes agiles et scrum.', '2025-06-09 18:58:42'),
(58, 8, 'Marketing digital', 'SEO, réseaux sociaux, campagnes publicitaires.', '2025-06-09 18:58:42'),
(59, 8, 'Comptabilité de gestion', 'Contrôle de gestion et analyse financière.', '2025-06-09 18:58:42'),
(60, 8, 'Communication professionnelle', 'Techniques de communication en entreprise.', '2025-06-09 18:58:42'),
(61, 8, 'Sécurité au travail', 'Normes et pratiques de sécurité.', '2025-06-09 18:58:42'),
(62, 8, 'Informatique bureautique', 'Maîtrise des outils de bureautique courants.', '2025-06-09 18:58:42'),
(63, 9, 'Mathématiques pour prépa scientifique', 'Calcul intégral, suites, fonctions.', '2025-06-09 18:58:42'),
(64, 9, 'Physique pour prépa scientifique', 'Mécanique, électricité, thermodynamique.', '2025-06-09 18:58:42'),
(65, 9, 'Chimie pour prépa scientifique', 'Chimie générale et organique.', '2025-06-09 18:58:42'),
(66, 9, 'Français pour prépa', 'Analyse de textes, dissertation.', '2025-06-09 18:58:42'),
(67, 9, 'Langues vivantes', 'Anglais scientifique et techniques de traduction.', '2025-06-09 18:58:42'),
(68, 10, 'Gestion financière', 'Comptabilité, budgets et contrôle financier.', '2025-06-09 18:58:42'),
(69, 10, 'Développement web', 'HTML, CSS, JavaScript, frameworks modernes.', '2025-06-09 18:58:42'),
(70, 10, 'Management des ressources humaines', 'Recrutement, formation, évaluation.', '2025-06-09 18:58:42'),
(71, 10, 'Techniques de vente', 'Stratégies commerciales et négociation.', '2025-06-09 18:58:42'),
(72, 10, 'Initiation à la data science', 'Bases en analyse de données et visualisation.', '2025-06-09 18:58:42'),
(73, 11, 'Programmation Python', 'Introduction complète au langage Python.', '2025-06-09 18:58:42'),
(74, 11, 'Bases de données relationnelles', 'Modélisation et interrogation SQL.', '2025-06-09 18:58:42'),
(75, 11, 'Cyber sécurité', 'Principes fondamentaux et bonnes pratiques.', '2025-06-09 18:58:42'),
(76, 11, 'Introduction au Machine Learning', 'Concepts de base et algorithmes.', '2025-06-09 18:58:42'),
(77, 11, 'Développement mobile', 'Création d’applications Android et iOS.', '2025-06-09 18:58:42'),
(78, 12, 'Certificat en sécurité informatique', 'Préparation à la certification CISSP.', '2025-06-09 18:58:42'),
(79, 12, 'Certificat en gestion de projet', 'Préparation à la certification PMP.', '2025-06-09 18:58:42'),
(80, 12, 'Certificat en cloud computing', 'Introduction aux services cloud AWS, Azure.', '2025-06-09 18:58:42'),
(81, 12, 'Certificat en data science', 'Techniques avancées d’analyse de données.', '2025-06-09 18:58:42'),
(82, 12, 'Certificat en marketing digital', 'Stratégies et outils avancés du marketing en ligne.', '2025-06-09 18:58:42');

-- --------------------------------------------------------

--
-- Structure de la table `tags`
--

DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `tags`
--

INSERT INTO `tags` (`id`, `name`, `created_at`) VALUES
(1, 'mathématiques', '2025-06-09 18:59:47'),
(2, 'physique', '2025-06-09 18:59:47'),
(3, 'chimie', '2025-06-09 18:59:47'),
(4, 'biologie', '2025-06-09 18:59:47'),
(5, 'français', '2025-06-09 18:59:47'),
(6, 'histoire', '2025-06-09 18:59:47'),
(7, 'géographie', '2025-06-09 18:59:47'),
(8, 'langues', '2025-06-09 18:59:47'),
(9, 'informatique', '2025-06-09 18:59:47'),
(10, 'économie', '2025-06-09 18:59:47'),
(11, 'psychologie', '2025-06-09 18:59:47'),
(12, 'philosophie', '2025-06-09 18:59:47'),
(13, 'statistiques', '2025-06-09 18:59:47'),
(14, 'gestion', '2025-06-09 18:59:47'),
(15, 'marketing', '2025-06-09 18:59:47'),
(16, 'communication', '2025-06-09 18:59:47'),
(17, 'intelligence_artificielle', '2025-06-09 18:59:47'),
(18, 'machine_learning', '2025-06-09 18:59:47'),
(19, 'cybersécurité', '2025-06-09 18:59:47'),
(20, 'cloud_computing', '2025-06-09 18:59:47'),
(21, 'programmation', '2025-06-09 18:59:47'),
(22, 'bases_de_données', '2025-06-09 18:59:47'),
(23, 'développement_web', '2025-06-09 18:59:47'),
(24, 'développement_mobile', '2025-06-09 18:59:47'),
(25, 'maintenance', '2025-06-09 18:59:47'),
(26, 'sécurité_au_travail', '2025-06-09 18:59:47'),
(27, 'management', '2025-06-09 18:59:47'),
(28, 'vente', '2025-06-09 18:59:47'),
(29, 'projet', '2025-06-09 18:59:47'),
(30, 'analyse_de_données', '2025-06-09 18:59:47'),
(31, 'science_des_données', '2025-06-09 18:59:47'),
(32, 'recherche', '2025-06-09 18:59:47'),
(33, 'thèse', '2025-06-09 18:59:47'),
(34, 'autodidacte', '2025-06-09 18:59:47'),
(35, 'e_learning', '2025-06-09 18:59:47'),
(36, 'certification', '2025-06-09 18:59:47'),
(37, 'cours_en_ligne', '2025-06-09 18:59:47');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`);

--
-- Contraintes pour la table `document_tags`
--
ALTER TABLE `document_tags`
  ADD CONSTRAINT `document_tags_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`),
  ADD CONSTRAINT `document_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`);

--
-- Contraintes pour la table `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `subjects_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;