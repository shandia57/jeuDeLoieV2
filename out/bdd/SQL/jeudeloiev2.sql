-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 02 déc. 2021 à 18:08
-- Version du serveur :  10.4.19-MariaDB
-- Version de PHP : 8.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `jeudeloiev2`
--

-- --------------------------------------------------------

--
-- Structure de la table `answer`
--

CREATE TABLE `answer` (
  `id_answer` int(11) NOT NULL,
  `answer` varchar(50) DEFAULT NULL,
  `valid` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `answer`
--

INSERT INTO `answer` (`id_answer`, `answer`, `valid`) VALUES
(46, 'Paris', 1),
(48, 'Marseille', 1),
(49, 'Forback', 0),
(51, 'Paris', 0),
(52, 'Arles', 1),
(53, 'Nice', 0),
(54, 'Marseille', 0),
(56, 'Nice', 0);

-- --------------------------------------------------------

--
-- Structure de la table `questions`
--

CREATE TABLE `questions` (
  `id_question` int(11) NOT NULL,
  `label` varchar(100) DEFAULT NULL,
  `level` varchar(50) DEFAULT NULL,
  `question` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `questions`
--

INSERT INTO `questions` (`id_question`, `label`, `level`, `question`) VALUES
(1, 'Pays / ville', 'Vert', 'Quelle est la capitale de la France ?'),
(2, 'Pays / ville', 'Jaune', 'Quelle est la plus grande ville de france  ?');

--
-- Déclencheurs `questions`
--
DELIMITER $$
CREATE TRIGGER `delete all questions` BEFORE DELETE ON `questions` FOR EACH ROW DELETE 
FROM questions_answers
WHERE id_question = OLD.id_question
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `questions_answers`
--

CREATE TABLE `questions_answers` (
  `id_question` int(11) NOT NULL,
  `id_answer` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `questions_answers`
--

INSERT INTO `questions_answers` (`id_question`, `id_answer`) VALUES
(1, 46),
(1, 48),
(1, 49),
(1, 56),
(2, 51),
(2, 52),
(2, 53),
(2, 54);

--
-- Déclencheurs `questions_answers`
--
DELIMITER $$
CREATE TRIGGER `delete answers` AFTER DELETE ON `questions_answers` FOR EACH ROW DELETE 
FROM answer
WHERE id_answer = OLD.id_answer
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `mail` varchar(100) DEFAULT NULL,
  `roles` varchar(50) DEFAULT NULL,
  `createAt` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_user`, `username`, `password`, `firstName`, `lastName`, `mail`, `roles`, `createAt`) VALUES
(6, 'Toranus', 'test', 'Nodeshita', 'Tora', 'toran@test.fr', 'ROLES_USER', '2021-11-24'),
(7, 'Kenito', 'test', 'Wakarimashita', 'Deshita', 'kenito@test.fr', 'ROLES_USER', '2021-11-24'),
(16, 'admin', 'test', 'test', 'test', 'test@hotmail.fr', 'ROLES_ADMIN', '2021-11-24');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`id_answer`);

--
-- Index pour la table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id_question`);

--
-- Index pour la table `questions_answers`
--
ALTER TABLE `questions_answers`
  ADD PRIMARY KEY (`id_question`,`id_answer`),
  ADD KEY `id_answer` (`id_answer`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `answer`
--
ALTER TABLE `answer`
  MODIFY `id_answer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `questions_answers`
--
ALTER TABLE `questions_answers`
  ADD CONSTRAINT `questions_answers_ibfk_1` FOREIGN KEY (`id_question`) REFERENCES `questions` (`id_question`),
  ADD CONSTRAINT `questions_answers_ibfk_2` FOREIGN KEY (`id_answer`) REFERENCES `answer` (`id_answer`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;