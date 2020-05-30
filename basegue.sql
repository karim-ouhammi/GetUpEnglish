-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Sam 30 Mai 2020 à 19:03
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `basegue`
--

-- --------------------------------------------------------

--
-- Structure de la table `cours`
--

CREATE TABLE IF NOT EXISTS `cours` (
  `idCours` int(11) NOT NULL AUTO_INCREMENT,
  `categorie` varchar(30) NOT NULL,
  `titre` varchar(200) NOT NULL,
  `contenu` text NOT NULL,
  `difficulte` int(1) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`idCours`),
  KEY `fk_categorie` (`categorie`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=100 ;

--
-- Contenu de la table `cours`
--

INSERT INTO `cours` (`idCours`, `categorie`, `titre`, `contenu`, `difficulte`, `date`) VALUES
(89, 'Orthographe', 'Their -There - They''re', '<h1 style="text-align: center;"><span style="color: #e03e2d;"><strong>Their -There - They''re</strong></span></h1>\n<p style="text-align: justify;"><span style="color: #000000;">Les mots <strong>their</strong>, <strong>there </strong>et <strong>they''re </strong>sont des <strong>homophones</strong>, ils se prononcent de la meme mani&egrave;re, il est donc n&eacute;cessaire de les diff&eacute;rencier car c''est une source d''erreurs fr&eacute;quemment commises &agrave; l''&eacute;crit.</span></p>\n<h2 style="text-align: justify;"><span style="color: #e03e2d;">Their :</span></h2>\n<p style="text-align: justify;"><span style="color: #000000;"><strong>D&eacute;finition </strong>:</span></p>\n<p style="text-align: justify;"><span style="color: #000000;">Adjectif possessif = <strong>leur,</strong> <strong>leurs</strong>, (&agrave; eux).</span></p>\n<p style="text-align: justify;"><span style="color: #000000;"><strong>Exemple </strong>:&nbsp;</span></p>\n<blockquote>\n<p style="text-align: justify;"><span style="color: #000000;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Somebody left <strong><span style="color: #236fa1;">their </span></strong>rubbish in front of my door !</span></p>\n<span style="text-align: justify;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><em>Quelqu''un a laiss&eacute; <strong>ses </strong>d&eacute;tritus devant ma porte !</em></blockquote>\n<h2 style="text-align: justify;"><span style="color: #ba372a;"><span style="color: #e03e2d;">There :</span></span></h2>\n<p style="text-align: justify;"><strong>D&eacute;finition&nbsp;</strong>:</p>\n<p style="text-align: justify;">Adverbe de lieu = <strong>l&agrave; </strong>(<strong>bas </strong>/ <strong>haut</strong>).</p>\n<p style="text-align: justify;">= d&eacute;signe les autres lieux par opposition a <strong>ici </strong>= <strong>here</strong>.</p>\n<p style="text-align: justify;"><strong>Exemple&nbsp;</strong>:&nbsp;</p>\n<blockquote><span style="text-align: justify;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="text-align: justify;">I am wondering what they''re plotting </span><span style="color: #236fa1;"><strong>up there</strong></span><span style="text-align: justify;"> in the bedroom.</span><span style="text-align: justify;"><br /></span><span style="text-align: justify;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><em>Je me demande ce qu''elles complottent&nbsp;</em><strong style="text-align: justify;">l&agrave;</strong><em><strong>-haut</strong>, dans la chambre.</em></blockquote>\n<p><span style="color: #e03e2d;"><strong>Attention </strong></span>: <span style="color: #7e8c8d;"><strong>There is = il y a</strong></span></p>\n<h2 style="text-align: justify;"><span style="color: #ba372a;"><span style="color: #e03e2d;">They''re :</span></span></h2>\n<p style="text-align: justify;"><strong>D&eacute;finition&nbsp;</strong>:</p>\n<p>La contraction de <strong><span style="color: #e03e2d;">they are</span></strong> = <strong>ils </strong>- <strong>elles </strong>- <strong>ce sont</strong>.</p>\n<p>Pour parler de quelqu''un ou de quelque chose au pluriel.</p>\n<p style="text-align: justify;">= d&eacute;signe les autres lieux par opposition a&nbsp;<strong>ici&nbsp;</strong>=&nbsp;<strong>here</strong>.</p>\n<p style="text-align: justify;"><strong>Exemple&nbsp;</strong>:&nbsp;</p>\n<blockquote><span style="text-align: justify;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="text-align: justify;">I found these keys. I think </span><strong style="text-align: justify;"><span style="color: #236fa1;">they''re </span></strong><span style="text-align: justify;">yours.</span><span style="text-align: justify;"><br /></span><span style="text-align: justify;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><em>J''ai trouv&eacute; ces cl&eacute;s. Je pense que <strong>ce sont</strong> les v&ocirc;tres.</em></blockquote>\n<h1 style="text-align: center;"><span style="color: #e03e2d;">&Agrave; vous&nbsp; maintenant.</span></h1>\n<p>&nbsp;</p>', 1, '2020-05-25 00:45:48'),
(90, 'Orthographe', 'Although - in spite of - despite', '<h1 style="text-align: center;"><span style="color: #e03e2d;">Although - in spite of - despite</span></h1>\n<p><span lang="EN-US" style="font-size: 12pt; color: #000000;">After<span style="color: #e03e2d;">&nbsp;</span></span><span style="color: #e03e2d;"><strong><span lang="EN-US" style="font-size: 12pt;">although</span></strong></span><span lang="EN-US" style="font-size: 12pt; color: green;">&nbsp;</span><span lang="EN-US" style="font-size: 12pt; color: #000000;">we use a subject + verb :</span></p>\n<p><span lang="EN-US" style="font-size: 12pt; color: blue;"><span style="color: #000000;">&bull;</span> </span><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">Although it rained</span></strong></span><span lang="EN-US" style="font-size: 12pt; color: blue;">&nbsp;<span style="color: #000000;">a lot, we enjoyed our holiday.</span></span></p>\n<p><span lang="EN-US" style="font-size: 12pt; color: blue;"><span style="color: #000000;">&bull; I didn''t get the job<span style="color: #236fa1;">&nbsp;</span></span></span><span style="color: #000000;"><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">although I had</span></strong></span><span lang="EN-US" style="font-size: 12pt;">&nbsp;all the necessary qualifications.</span></span></p>\n<p><span lang="EN-US" style="font-size: 12pt; color: blue;">&nbsp;</span></p>\n<p><span lang="EN-US" style="font-size: 12pt; color: #000000;">Compare the meaning of&nbsp;</span><span style="color: #e03e2d;"><strong><span lang="EN-US" style="font-size: 12pt;">although&nbsp;</span></strong></span><span lang="EN-US" style="font-size: 12pt; color: blue;">and&nbsp;</span><strong><span lang="EN-US" style="font-size: 12pt; color: green;"><span style="color: #e03e2d;">because </span></span></strong><span lang="EN-US" style="font-size: 12pt; color: #000000;">:</span></p>\n<p><span lang="EN-US" style="font-size: 12pt; color: blue;"><span style="color: #000000;">&bull; We went out </span></span><span style="color: #000000;"><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">although</span></strong></span><span lang="EN-US" style="font-size: 12pt;"><span style="color: #236fa1;">&nbsp;</span>it was raining.</span></span></p>\n<p><span lang="EN-US" style="font-size: 12pt; color: blue;"><span style="color: #000000;">&bull; We didn''t go out </span></span><span style="color: #000000;"><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">because</span></strong></span><span lang="EN-US" style="font-size: 12pt;"><span style="color: #236fa1;">&nbsp;</span>it was raining.</span></span></p>\n<p><span lang="EN-US" style="font-size: 12pt; color: blue;">&nbsp;</span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">After<span style="color: #e03e2d;">&nbsp;</span></span><span style="color: #e03e2d;"><strong><span lang="EN-US" style="font-size: 12pt;">in spite of&nbsp;</span></strong></span><span lang="EN-US" style="font-size: 12pt;">or&nbsp;</span><strong><span lang="EN-US" style="font-size: 12pt;"><span style="color: #e03e2d;">despite</span>,</span></strong><span lang="EN-US" style="font-size: 12pt;">&nbsp;we use a noun, a pronoun (</span><strong><span lang="EN-US" style="font-size: 12pt;">this</span></strong><span lang="EN-US" style="font-size: 12pt;">, </span><strong><span lang="EN-US" style="font-size: 12pt;">that</span></strong><strong><span lang="EN-US" style="font-size: 12pt;"><span style="font-weight: 400;">, </span>what</span></strong><span lang="EN-US" style="font-size: 12pt;">&nbsp;etc.) or -</span><strong><span lang="EN-US" style="font-size: 12pt;">ing </span></strong><span lang="EN-US" style="font-size: 12pt;">:</span></span></p>\n<p><span lang="EN-US" style="font-size: 12pt; color: blue;"><span style="color: #000000;">&bull;&nbsp;</span></span><span style="color: #000000;"><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">In spite of</span></strong><span lang="EN-US" style="font-size: 12pt;">&nbsp;</span><strong><span lang="EN-US" style="font-size: 12pt;">the rain</span></strong></span><span lang="EN-US" style="font-size: 12pt;">, we enjoyed our holiday.</span></span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">&bull; I didn''t get the job&nbsp;</span><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">in spite of having</span></strong></span><span lang="EN-US" style="font-size: 12pt;">&nbsp;all the necessary qualifications.</span></span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">&bull; She wasn''t well, but&nbsp;</span><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">in spite of this</span></strong></span><span lang="EN-US" style="font-size: 12pt;">&nbsp;she went to work.</span></span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">&bull;<span style="color: #236fa1;">&nbsp;</span></span><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">In spite of what</span></strong></span><span lang="EN-US" style="font-size: 12pt;">&nbsp;I said yesterday, I still love you.</span></span></p>\n<p><span lang="EN-US" style="font-size: 12pt; color: blue;">&nbsp;</span></p>\n<p><span style="color: #000000;"><span style="color: #e03e2d;"><strong><span lang="EN-US" style="font-size: 12pt;">Despite</span></strong></span><span lang="EN-US" style="font-size: 12pt;"><span style="color: #e03e2d;">&nbsp;</span>is the same as&nbsp;</span><span style="color: #e03e2d;"><strong><span lang="EN-US" style="font-size: 12pt;">in spite of</span></strong></span><span lang="EN-US" style="font-size: 12pt;">. Note that we say ''in spite&nbsp;</span><strong><span lang="EN-US" style="font-size: 12pt;">of</span></strong><span lang="EN-US" style="font-size: 12pt;">, but despite (without ''of''):</span></span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">&bull; She wasn''t well, but&nbsp;</span><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">despite</span></strong><span lang="EN-US" style="font-size: 12pt;">&nbsp;</span><strong><span lang="EN-US" style="font-size: 12pt;">this</span></strong></span><span lang="EN-US" style="font-size: 12pt;">&nbsp;she went to work, (</span><span style="color: #e03e2d;"><strong><span lang="EN-US" style="font-size: 12pt;">not</span></strong></span><span lang="EN-US" style="font-size: 12pt;"><span style="color: #e03e2d;">&nbsp;</span>''despite of this'')</span></span></p>\n<p><span lang="EN-US" style="font-size: 12pt; color: blue;">&nbsp;</span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">You can say&nbsp;</span><span lang="EN-US" style="font-size: 12pt;">''</span><strong><span lang="EN-US" style="font-size: 12pt;"><span style="color: #e03e2d;">in spite of the fact</span></span></strong><span style="color: #e03e2d;"><span lang="EN-US" style="font-size: 12pt;">&nbsp;</span><strong><span lang="EN-US" style="font-size: 12pt;">(that)</span></strong></span><span lang="EN-US" style="font-size: 12pt;">. . .'' and </span><span lang="EN-US" style="font-size: 12pt;">''</span><strong><span lang="EN-US" style="font-size: 12pt;"><span style="color: #e03e2d;">despite the fact</span></span></strong><span lang="EN-US" style="font-size: 12pt;">&nbsp;(that)...'':</span></span></p>\n<p><span lang="EN-US" style="font-size: 12pt; color: blue;">&nbsp;</span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">&bull; I didn&rsquo;t get the job </span><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">in spite of</span></strong></span><span lang="EN-US" style="font-size: 12pt;"><span style="color: #236fa1;">&nbsp;the fact that</span> I had all the necessary qualifications</span></span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">&bull; I didn&rsquo;t get the job </span><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">despite the fact</span></strong></span><span lang="EN-US" style="font-size: 12pt;"><span style="color: #236fa1;">&nbsp;(that)</span> I had all the necessary qualifications.</span></span></p>\n<p><span lang="EN-US" style="font-size: 12pt; color: blue;">&nbsp;</span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">Compare<span style="color: #e03e2d;">&nbsp;</span></span><span style="color: #e03e2d;"><strong><span lang="EN-US" style="font-size: 12pt;">in spite of</span></strong></span><span lang="EN-US" style="font-size: 12pt;">&nbsp;and&nbsp;</span><span style="color: #e03e2d;"><strong><span lang="EN-US" style="font-size: 12pt;">because of </span></strong></span><span lang="EN-US" style="font-size: 12pt;">:</span></span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">&bull; We went out&nbsp;</span><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">in spite of the rain</span></strong></span><span lang="EN-US" style="font-size: 12pt;">, (or . . . </span><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">despite the rain</span></strong></span><span lang="EN-US" style="font-size: 12pt;">.)</span></span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">&bull; We didn''t go out&nbsp;</span><strong><span lang="EN-US" style="font-size: 12pt;"><span style="color: #236fa1;">because of the rain</span></span></strong><span lang="EN-US" style="font-size: 12pt;">.</span></span></p>\n<p><span lang="EN-US" style="font-size: 12pt; color: blue;">&nbsp;</span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">Compare&nbsp;</span><span style="color: #e03e2d;"><strong><span lang="EN-US" style="font-size: 12pt;">although&nbsp;</span></strong></span><span lang="EN-US" style="font-size: 12pt;">and<span style="color: #e03e2d;">&nbsp;</span></span><span style="color: #e03e2d;"><strong><span lang="EN-US" style="font-size: 12pt;">in spite of</span></strong></span><span lang="EN-US" style="font-size: 12pt;"><span style="color: #e03e2d;">&nbsp;</span>/&nbsp;</span><span style="color: #e03e2d;"><strong><span lang="EN-US" style="font-size: 12pt;">despite </span></strong></span><span lang="EN-US" style="font-size: 12pt;">:</span></span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">&bull;&nbsp;</span><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">Although</span></strong><span lang="EN-US" style="font-size: 12pt;">&nbsp;</span><strong><span lang="EN-US" style="font-size: 12pt;">the traffic</span></strong></span><span lang="EN-US" style="font-size: 12pt;">&nbsp;was bad. I arrived on time.&nbsp;</span><span lang="EN-US" style="font-size: 12pt;">(</span><span style="color: #236fa1;"><strong><span lang="EN-US" style="font-size: 12pt;">In spite of the traffic</span></strong></span><span lang="EN-US" style="font-size: 12pt;">, I arrived on time.&nbsp;</span><span lang="EN-US" style="font-size: 12pt;">(</span><span lang="EN-US" style="font-size: 12pt;"><span style="color: #e03e2d;"><strong><span class="Apple-style-span" style="color: #ff0000;">not&nbsp;</span></strong></span><span style="text-decoration: line-through;">in spite of the traffic was bad)</span></span></span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">&bull; I couldn&rsquo;t sleep although I was very tired (</span><span style="color: #e03e2d;"><strong><span lang="EN-US" style="font-size: 12pt;">not</span></strong></span><span lang="EN-US" style="font-size: 12pt;"><span style="color: #e03e2d;">&nbsp;</span><span style="text-decoration: line-through;">despite I was tired</span>)</span></span></p>\n<p><span style="color: #000000;"><span lang="EN-US" style="font-size: 12pt;">&bull; I couldn&rsquo;t sleep despite being very tired (</span><span style="color: #e03e2d;"><strong><span lang="EN-US" style="font-size: 12pt;">not</span></strong></span><span lang="EN-US" style="font-size: 12pt;"><span style="color: #e03e2d;">&nbsp;</span><span style="text-decoration: line-through;">despite I was tired</span>)</span></span></p>\n<h1 style="text-align: center;"><span style="color: #e03e2d;">&Agrave; vous&nbsp; maintenant.</span></h1>\n<p>&nbsp;</p>', 1, '2020-05-25 01:33:06'),
(91, 'Orthographe', 'Distinction entre Like et As - cours', '<p>bla bla bla bla bla bla</p>', 1, '2020-05-27 21:34:27'),
(92, 'Vocabulaire et Lexique', 'Dire bonjour !', '<p>bla bla bla bla bla bla</p>', 1, '2020-05-27 21:36:05'),
(93, 'Vocabulaire et Lexique', 'CV et lettre de motivation', '<p>bla bla bla bla bla bla bla bla&nbsp;</p>', 2, '2020-05-27 21:36:48'),
(94, 'Vocabulaire et Lexique', 'Au restaurant', '<p>bla bla bla bla bla bla bla bla bla</p>', 1, '2020-05-27 21:37:27'),
(95, 'Vocabulaire et Lexique', 'Au téléphone', '<p>bla bla bla bla bla bla</p>', 1, '2020-05-27 21:37:54'),
(96, 'Grammaire', 'Verbes irréguliers', '<p>bla bla bla bla bla bla bla&nbsp;</p>', 3, '2020-05-27 21:39:33'),
(97, 'Grammaire', 'Les adverbes', '<p>bla bla bla bla bla bla bla&nbsp;</p>', 2, '2020-05-27 21:40:26'),
(98, 'Grammaire', 'Le futur progressif et le "future perfect"', '<h1 style="text-align: center;"><span style="color: #e03e2d;">Test d''&eacute;diteur HTML</span></h1>\n<p><span style="color: #000000;">Test Paragraphe</span></p>\n<blockquote>\n<p><span style="color: #000000;">Test Blockquote</span></p>\n</blockquote>\n<pre><span style="color: #000000;">Test block de Pre<br /><code>Test block du Code</code><br /></span></pre>', 3, '2020-05-27 21:41:27');

-- --------------------------------------------------------

--
-- Structure de la table `coursutilisateur`
--

CREATE TABLE IF NOT EXISTS `coursutilisateur` (
  `idCours` int(11) NOT NULL,
  `email` varchar(60) NOT NULL,
  `note` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idCours`,`email`),
  KEY `fk_utilisateur` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `coursutilisateur`
--

INSERT INTO `coursutilisateur` (`idCours`, `email`, `note`) VALUES
(89, 'admin@gue.com', '16.00'),
(89, 'elfilalihamza@gmail.com', '16.00'),
(89, 'ouhammikarim@gmail.com', '18.00'),
(90, 'admin@gue.com', '17.78'),
(90, 'ouhammikarim@gmail.com', '17.78'),
(91, 'admin@gue.com', '14.55');

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `idMessage` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(60) DEFAULT NULL,
  `nomPrenom` varchar(30) NOT NULL,
  `adresseEmail` varchar(60) NOT NULL,
  `titre` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `date` datetime NOT NULL,
  `vu` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idMessage`),
  KEY `fk_email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `message`
--

INSERT INTO `message` (`idMessage`, `email`, `nomPrenom`, `adresseEmail`, `titre`, `message`, `date`, `vu`) VALUES
(4, 'elfilalihamza@gmail.com', 'El FILALI Hamza', 'elfilalihamza@gmail.com', 'J''aimerais bien savoir vos prochains cours.', 'Bonjour, d''abord je vous remercier pour vos services incroyable, bon courage pour la suite. J''aimerais bien savoir vos prochains cours? Et merci d''avance.', '2020-05-27 21:29:11', 1),
(5, NULL, 'KOKOYE Nithael', 'kokoyenithael@gue.com', 'Titre d''un message d''un utilisateur connecté', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut elit mauris. Vestibulum non fermentum est, sed mattis lacus. Morbi laoreet ut neque porttitor molestie. Praesent elit lectus, aliquet mattis pretium eget, elementum a tortor. Vestibulum feugiat dictum volutpat. Mauris fringilla est eros, sed tempus diam faucibus eu. Suspendisse ut sem euismod, cursus odio eget, dapibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut elit mauris. Vestibulum non fermentum est, sed mattis lacus. Morbi laoreet ut neque porttitor molestie. Praesent elit lectus, aliquet mattis pretium eget, elementum a tortor. Vestibulum feugiat dictum volutpat. Mauris fringilla est eros, sed tempus diam faucibus eu. Suspendisse ut sem euismod, cursus odio eget, dapibus ex.', '2020-05-27 21:29:40', 0),
(6, NULL, 'OUHAMMI Karim', 'ouhammik@gmail.com', 'Titre d''un message d''un visiteur', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut elit mauris. Vestibulum non fermentum est, sed mattis lacus. Morbi laoreet ut neque porttitor molestie. Praesent elit lectus, aliquet mattis pretium eget, elementum a tortor. Vestibulum feugiat dictum volutpat. Mauris fringilla est eros, sed tempus diam faucibus eu. Suspendisse ut sem euismod, cursus odio eget, dapibus ex.\r\n\r\n', '2020-05-27 21:30:06', 0);

-- --------------------------------------------------------

--
-- Structure de la table `question`
--

CREATE TABLE IF NOT EXISTS `question` (
  `idQuestion` int(11) NOT NULL AUTO_INCREMENT,
  `idCours` int(11) NOT NULL,
  `question` text NOT NULL,
  `reponse` varchar(200) NOT NULL,
  `image` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`idQuestion`),
  KEY `fk_cours_question` (`idCours`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=81 ;

--
-- Contenu de la table `question`
--

INSERT INTO `question` (`idQuestion`, `idCours`, `question`, `reponse`, `image`) VALUES
(40, 89, 'I like these flowers because ; colourful.', 'they''re', 'https://www.anglaisfacile.com/cgi2/myexam/images/25394.jpg'),
(41, 89, 'I have to help my children so that they make ; bed.', 'their', 'https://www.anglaisfacile.com/cgi2/myexam/images/25225.jpg'),
(42, 89, 'They won the race. ;opponents fell down before the last obstacle.', 'their', 'https://www.anglaisfacile.com/cgi2/myexam/images2/27849.gif'),
(43, 89, 'Watch!;is a worm in the bunch.', 'there', 'https://www.anglaisfacile.com/cgi2/myexam/images/10082.gif'),
(44, 89, 'You don''t know?;married.', 'they''re', 'https://www.anglaisfacile.com/cgi2/myexam/images/24975.jpg'),
(45, 89, 'Without explanation, how can I understand ;game?', 'their', 'https://www.anglaisfacile.com/cgi2/myexam/images2/27183.jpg'),
(46, 89, 'Santa Claus lives far away. I''d like to go with him over ;.', 'there', 'https://www.anglaisfacile.com/cgi2/myexam/images/21850.gif'),
(47, 89, ' ; late for dinner but they don''t mind.', 'they''re', 'https://www.anglaisfacile.com/cgi2/myexam/images2/27802.jpg'),
(48, 89, 'I hope they didn''t forget ;picnic!', 'their', 'https://www.anglaisfacile.com/cgi2/myexam/images/11523.jpg'),
(49, 89, 'Hello ! Is Peter ;please?', 'there', 'https://www.anglaisfacile.com/cgi2/myexam/images/10598.jpg'),
(50, 90, ' ; it rained a lot, we enjoyed our holiday.', 'although', NULL),
(51, 90, ' ; all our careful plans, a lot of things went wrong.', 'in spite of', NULL),
(52, 90, ' ; we had planned everything carefully, a lot of things went wrong.', 'although', NULL),
(53, 90, 'I went home early ; I was feeling unwell.', 'because', NULL),
(54, 90, 'I went to work the next day ; I was still feeling unwell.', 'although', NULL),
(55, 90, 'She only accepted the job ; the salary, which was very high.', 'because of', NULL),
(56, 90, 'She accepted the job ; the salary, which was rather low.', 'in spite of', NULL),
(57, 90, 'I managed to get to sleep ; there was a lot of noise.', 'although', NULL),
(58, 90, 'I couldn''t get to sleep ; the noise.', 'because of', NULL),
(59, 91, 'asdasdas ; asdasdasd', 'as', NULL),
(60, 91, 'asd asdasd ; asd asdasdasd', 'as', NULL),
(61, 91, 'asd asdasd; asd asdasdasd', 'as', NULL),
(62, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(63, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(64, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(65, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(66, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(67, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(68, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(69, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(70, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(71, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(72, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(73, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(74, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(75, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(76, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(77, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(78, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(79, 91, 'asd asdasdads; asd asdasd', 'as', NULL),
(80, 91, 'asd asdasdads; asd asdasd', 'as', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `reponse`
--

CREATE TABLE IF NOT EXISTS `reponse` (
  `idReponse` int(11) NOT NULL AUTO_INCREMENT,
  `idCours` int(11) NOT NULL,
  `reponse` varchar(200) NOT NULL,
  PRIMARY KEY (`idReponse`),
  KEY `fk_cours_reponse` (`idCours`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=121 ;

--
-- Contenu de la table `reponse`
--

INSERT INTO `reponse` (`idReponse`, `idCours`, `reponse`) VALUES
(109, 89, 'their'),
(110, 89, 'there'),
(111, 89, 'they''re'),
(112, 90, 'because'),
(113, 90, 'because of'),
(114, 90, 'although'),
(115, 90, 'in spite of'),
(116, 91, 'as'),
(117, 91, 'as if'),
(118, 91, 'like');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE IF NOT EXISTS `utilisateur` (
  `email` varchar(60) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `prenom` varchar(20) NOT NULL,
  `motDePasse` char(56) NOT NULL,
  `age` int(3) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `dateInscription` datetime NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `utilisateur`
--

INSERT INTO `utilisateur` (`email`, `nom`, `prenom`, `motDePasse`, `age`, `telephone`, `dateInscription`, `isAdmin`) VALUES
('admin@gue.com', 'GUE', 'ADMIN', '3QxQHyEfj/wXC02ekS6qd0/EURMbC0nEXbfkcCckLTZysckeQnj7cA==', 27, '0642176568', '2020-05-16 17:24:16', 1),
('elfilalihamza@gmail.com', 'El FILALI', 'Hamza', 'udSs3h4U/SplbOwU2vezNThxGCqXO9pnBjudm74WZZP7qC5zrUUilA==', 25, '0619430944', '2020-05-27 21:25:48', 0),
('kokoyenithael@gmail.com', 'KOKOYE', 'Nithael', 'Jdu7BTkt5GmlipNvZfGCy/GisPRcj3BTOM2xTVlxFc3Ujii1Y70mpQ==', 25, '0605151463', '2020-05-28 23:27:15', 0),
('ouhammik@gmail.com', 'asdasd', 'dasdsad', '/Z1o5aF/4h67/Lui4900PDiyzDBQxl8DgelmvgLwy9hSXV/6UTfEIw==', 12, '54646', '2020-05-27 23:26:39', 0),
('ouhammikarim@gmail.com', 'OUHAMMI', 'Karim', '4vc2UpMMmGuwHFXIZhtKWGKWE/YhgIqfLzi2LlPFesQyF5Ek7rJPnQ==', 27, '0642176568', '2020-05-17 01:54:13', 0);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `coursutilisateur`
--
ALTER TABLE `coursutilisateur`
  ADD CONSTRAINT `fk_idCours` FOREIGN KEY (`idCours`) REFERENCES `cours` (`idCours`),
  ADD CONSTRAINT `fk_utilisateur` FOREIGN KEY (`email`) REFERENCES `utilisateur` (`email`);

--
-- Contraintes pour la table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `fk_email` FOREIGN KEY (`email`) REFERENCES `utilisateur` (`email`) ON DELETE SET NULL;

--
-- Contraintes pour la table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `fk_cours_question` FOREIGN KEY (`idCours`) REFERENCES `cours` (`idCours`);

--
-- Contraintes pour la table `reponse`
--
ALTER TABLE `reponse`
  ADD CONSTRAINT `fk_cours_reponse` FOREIGN KEY (`idCours`) REFERENCES `cours` (`idCours`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
