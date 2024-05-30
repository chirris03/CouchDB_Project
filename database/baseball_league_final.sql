-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 30, 2024 at 02:33 AM
-- Server version: 10.4.32-MariaDB-log
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `baseball_league`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarFechaPartido` (IN `partidoID` INT, IN `nuevaFecha` DATE)   BEGIN
    DECLARE rollbackFlag BOOLEAN DEFAULT 0;

    -- Inicio de la transacción
    START TRANSACTION;

    -- Actualización de la fecha del partido
    UPDATE partido SET fecha = nuevaFecha WHERE id_partido = partidoID;

    -- Verificar si la actualización se realizó correctamente
    SELECT COUNT(*) INTO rollbackFlag FROM partido WHERE id_partido = partidoID AND fecha = nuevaFecha;

    -- Si se actualizó correctamente, confirmar la transacción
    IF rollbackFlag THEN
        COMMIT;
    ELSE
        -- Si algo salió mal, revertir los cambios
        ROLLBACK;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarNombreEquipo` (IN `equipoID` INT, IN `nuevoNombre` VARCHAR(255))   BEGIN
    DECLARE rollbackFlag BOOLEAN DEFAULT 0;

    -- Inicio de la transacción
    START TRANSACTION;

    -- Actualización del nombre del equipo
    UPDATE equipo SET nombre = nuevoNombre WHERE id_equipo = equipoID;

    -- Verificar si la actualización se realizó correctamente
    SELECT COUNT(*) INTO rollbackFlag FROM equipo WHERE id_equipo = equipoID AND nombre = nuevoNombre;

    -- Si se actualizó correctamente, confirmar la transacción
    IF rollbackFlag THEN
        COMMIT;
    ELSE
        -- Si algo salió mal, revertir los cambios
        ROLLBACK;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarPosicionJugador` (IN `jugadorID` INT, IN `nuevaPosicion` VARCHAR(50))   BEGIN
    DECLARE rollbackFlag BOOLEAN DEFAULT 0;

    -- Inicio de la transacción
    START TRANSACTION;

    -- Actualización de la posición del jugador
    UPDATE jugador SET posición = nuevaPosicion WHERE id_jugador = jugadorID;

    -- Verificar si la actualización se realizó correctamente
    SELECT COUNT(*) INTO rollbackFlag FROM jugador WHERE id_jugador = jugadorID AND posición = nuevaPosicion;

    -- Si se actualizó correctamente, confirmar la transacción
    IF rollbackFlag THEN
        COMMIT;
    ELSE
        -- Si algo salió mal, revertir los cambios
        ROLLBACK;
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_promedio_bateo` (`hits` INT, `turnos_al_bate` INT) RETURNS DECIMAL(5,3)  BEGIN
    DECLARE promedio DECIMAL(5, 3);
    IF turnos_al_bate = 0 THEN
        RETURN 0;
    ELSE
        SET promedio = hits / turnos_al_bate;
        RETURN promedio;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_sbp` (`bases_robadas` INT, `turnos_al_bate` INT) RETURNS DECIMAL(5,3)  BEGIN
    DECLARE sbp DECIMAL(5, 3);
    
    IF turnos_al_bate = 0 THEN
        RETURN 0;
    ELSE
        SET sbp = bases_robadas / turnos_al_bate;
        RETURN sbp;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `encontrar_menor_era` (`innings_lanzados` INT, `carreras` INT) RETURNS DECIMAL(5,2)  BEGIN
    DECLARE era DECIMAL(5, 2);
    IF innings_lanzados = 0 THEN
        RETURN 0;
    ELSE
        SET era = (carreras / innings_lanzados) * 9;
        RETURN era;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add equipo', 7, 'add_equipo'),
(26, 'Can change equipo', 7, 'change_equipo'),
(27, 'Can delete equipo', 7, 'delete_equipo'),
(28, 'Can view equipo', 7, 'view_equipo'),
(29, 'Can add jugador', 8, 'add_jugador'),
(30, 'Can change jugador', 8, 'change_jugador'),
(31, 'Can delete jugador', 8, 'delete_jugador'),
(32, 'Can view jugador', 8, 'view_jugador'),
(33, 'Can add jugador partido', 9, 'add_jugadorpartido'),
(34, 'Can change jugador partido', 9, 'change_jugadorpartido'),
(35, 'Can delete jugador partido', 9, 'delete_jugadorpartido'),
(36, 'Can view jugador partido', 9, 'view_jugadorpartido'),
(37, 'Can add jugador partido pitcher', 10, 'add_jugadorpartidopitcher'),
(38, 'Can change jugador partido pitcher', 10, 'change_jugadorpartidopitcher'),
(39, 'Can delete jugador partido pitcher', 10, 'delete_jugadorpartidopitcher'),
(40, 'Can view jugador partido pitcher', 10, 'view_jugadorpartidopitcher'),
(41, 'Can add partido', 11, 'add_partido'),
(42, 'Can change partido', 11, 'change_partido'),
(43, 'Can delete partido', 11, 'delete_partido'),
(44, 'Can view partido', 11, 'view_partido'),
(45, 'Can add estadisticas lideres', 12, 'add_estadisticaslideres'),
(46, 'Can change estadisticas lideres', 12, 'change_estadisticaslideres'),
(47, 'Can delete estadisticas lideres', 12, 'delete_estadisticaslideres'),
(48, 'Can view estadisticas lideres', 12, 'view_estadisticaslideres');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$720000$ttTy5OylsTlywbrWAx5Jj0$N5ajtKTp5ibld2mTi/EKzd7GsaTZ78e7nTNZ4MoWE1U=', '2024-05-29 21:32:22.674920', 1, 'chirrisAdmin', '', '', '', 1, 1, '2024-05-29 21:12:27.538723');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bitacora_actualizacion_equipo`
--

CREATE TABLE `bitacora_actualizacion_equipo` (
  `id_bitacora` int(11) NOT NULL,
  `id_equipo` int(11) DEFAULT NULL,
  `nombre_anterior` varchar(255) DEFAULT NULL,
  `nombre_nuevo` varchar(255) DEFAULT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `usuario_actualizacion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bitacora_actualizacion_jugador`
--

CREATE TABLE `bitacora_actualizacion_jugador` (
  `id_bitacora` int(11) NOT NULL,
  `id_jugador` int(11) DEFAULT NULL,
  `posicion_anterior` varchar(50) DEFAULT NULL,
  `posicion_nueva` varchar(50) DEFAULT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `usuario_actualizacion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bitacora_actualizacion_partido`
--

CREATE TABLE `bitacora_actualizacion_partido` (
  `id_bitacora` int(11) NOT NULL,
  `id_partido` int(11) DEFAULT NULL,
  `fecha_anterior` date DEFAULT NULL,
  `fecha_nueva` date DEFAULT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `usuario_actualizacion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(7, 'api', 'equipo'),
(12, 'api', 'estadisticaslideres'),
(8, 'api', 'jugador'),
(9, 'api', 'jugadorpartido'),
(10, 'api', 'jugadorpartidopitcher'),
(11, 'api', 'partido'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-05-29 21:11:04.440587'),
(2, 'auth', '0001_initial', '2024-05-29 21:11:05.077121'),
(3, 'admin', '0001_initial', '2024-05-29 21:11:05.261584'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-05-29 21:11:05.275575'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-05-29 21:11:05.290188'),
(6, 'api', '0001_initial', '2024-05-29 21:11:05.302098'),
(7, 'contenttypes', '0002_remove_content_type_name', '2024-05-29 21:11:05.402686'),
(8, 'auth', '0002_alter_permission_name_max_length', '2024-05-29 21:11:05.483609'),
(9, 'auth', '0003_alter_user_email_max_length', '2024-05-29 21:11:05.516684'),
(10, 'auth', '0004_alter_user_username_opts', '2024-05-29 21:11:05.535381'),
(11, 'auth', '0005_alter_user_last_login_null', '2024-05-29 21:11:05.604799'),
(12, 'auth', '0006_require_contenttypes_0002', '2024-05-29 21:11:05.608132'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2024-05-29 21:11:05.620603'),
(14, 'auth', '0008_alter_user_username_max_length', '2024-05-29 21:11:05.639983'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2024-05-29 21:11:05.664662'),
(16, 'auth', '0010_alter_group_name_max_length', '2024-05-29 21:11:05.692560'),
(17, 'auth', '0011_update_proxy_permissions', '2024-05-29 21:11:05.716668'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2024-05-29 21:11:05.738190'),
(19, 'sessions', '0001_initial', '2024-05-29 21:11:05.788875'),
(20, 'api', '0002_estadisticaslideres', '2024-05-30 00:02:20.550066');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('o66i7msdqah47mw3bbmz0dsls2w77p2g', '.eJxVjM0OwiAQhN-FsyGFFVg8evcZyC4_UjU0Ke3J-O62SQ96nPm-mbcItC41rD3PYUziIpQ4_XZM8ZnbDtKD2n2ScWrLPLLcFXnQLm9Tyq_r4f4dVOp1W2dKioekHWQ01gwlQWSDCp0y4NAhccxgEc7Gky6gC3rLtMWivLYgPl_Zyjcj:1sCQuE:U7WeKcWjw1d1EG_2MJNJmWuVxj510hwN8qAPspp5YZQ', '2024-06-12 21:32:22.687151');

-- --------------------------------------------------------

--
-- Table structure for table `equipo`
--

CREATE TABLE `equipo` (
  `id_equipo` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `ciudad` varchar(255) DEFAULT NULL,
  `fundación` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `equipo`
--

INSERT INTO `equipo` (`id_equipo`, `nombre`, `ciudad`, `fundación`) VALUES
(1, 'Yankees', 'New York', '1901-01-01'),
(2, 'Red Sox', 'Boston', '1901-01-01'),
(3, 'Dodgers', 'Los Angeles', '1883-01-01'),
(4, 'Padres', 'San Diego', '2024-05-14');

-- --------------------------------------------------------

--
-- Stand-in structure for view `estadisticas_lideres`
-- (See below for the actual view)
--
CREATE TABLE `estadisticas_lideres` (
`id` bigint(21)
,`mejor_promedio_bateo` varchar(511)
,`mejor_sbp` varchar(511)
,`menor_era` varchar(511)
);

-- --------------------------------------------------------

--
-- Table structure for table `jugador`
--

CREATE TABLE `jugador` (
  `id_jugador` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `posición` varchar(50) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `equipo_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jugador`
--

INSERT INTO `jugador` (`id_jugador`, `nombre`, `apellido`, `posición`, `edad`, `equipo_id`) VALUES
(1, 'Aaron', 'Judge', 'Outfielder', 29, 1),
(2, 'Mookie', 'Betts', 'Outfielder', 29, 2),
(3, 'Clayton', 'Kershaw', 'Pitcher', 34, 3),
(4, 'Manny', 'Ramirez', 'Pitcher', 22, 4),
(5, 'Mike', 'Trout', 'Outfielder', 30, 1),
(6, 'Jacob', 'deGrom', 'Pitcher', 33, 3);

-- --------------------------------------------------------

--
-- Table structure for table `jugador_partido`
--

CREATE TABLE `jugador_partido` (
  `id_jugador_partido` int(11) NOT NULL,
  `jugador_id` int(11) DEFAULT NULL,
  `partido_id` int(11) DEFAULT NULL,
  `hits` int(11) DEFAULT NULL,
  `carreras_anotadas` int(11) DEFAULT NULL,
  `carreras_impulsadas` int(11) DEFAULT NULL,
  `bases_por_bolas` int(11) DEFAULT NULL,
  `ponches` int(11) DEFAULT NULL,
  `bases_robadas` int(11) DEFAULT NULL,
  `bases_defendidas` int(11) DEFAULT NULL,
  `turnos_al_bate` int(11) DEFAULT NULL,
  `home_runs_impulsados` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jugador_partido`
--

INSERT INTO `jugador_partido` (`id_jugador_partido`, `jugador_id`, `partido_id`, `hits`, `carreras_anotadas`, `carreras_impulsadas`, `bases_por_bolas`, `ponches`, `bases_robadas`, `bases_defendidas`, `turnos_al_bate`, `home_runs_impulsados`) VALUES
(1, 1, 1, 3, 2, 1, 1, 0, 0, 0, 4, NULL),
(2, 2, 1, 2, 1, 2, 0, 0, 1, 0, 4, NULL),
(3, 3, 1, 0, 0, 0, 0, 5, 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jugador_partido_pitcher`
--

CREATE TABLE `jugador_partido_pitcher` (
  `id_pitcher_stats` int(11) NOT NULL,
  `jugador_id` int(11) DEFAULT NULL,
  `partido_id` int(11) DEFAULT NULL,
  `innings_lanzado` int(11) DEFAULT NULL,
  `hits_permitidos` int(11) DEFAULT NULL,
  `carreras` int(11) DEFAULT NULL,
  `bases_por_bola` int(11) DEFAULT NULL,
  `ponches` int(11) DEFAULT NULL,
  `home_runs` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jugador_partido_pitcher`
--

INSERT INTO `jugador_partido_pitcher` (`id_pitcher_stats`, `jugador_id`, `partido_id`, `innings_lanzado`, `hits_permitidos`, `carreras`, `bases_por_bola`, `ponches`, `home_runs`) VALUES
(1, 5, 1, 7, 4, 2, 1, 10, 1),
(2, 5, 2, 8, 3, 1, 2, 12, 0),
(3, 6, 1, 8, 5, 3, 2, 8, 0),
(4, 6, 2, 7, 2, 1, 1, 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `partido`
--

CREATE TABLE `partido` (
  `id_partido` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `lugar` varchar(255) DEFAULT NULL,
  `equipo_local_id` int(11) DEFAULT NULL,
  `equipo_visitante_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `partido`
--

INSERT INTO `partido` (`id_partido`, `fecha`, `lugar`, `equipo_local_id`, `equipo_visitante_id`) VALUES
(1, '2024-05-01', 'Yankee Stadium', 1, 2),
(2, '2024-05-02', 'Fenway Park', 2, 3),
(3, '2024-05-03', 'Dodger Stadium', 3, 1);

-- --------------------------------------------------------

--
-- Structure for view `estadisticas_lideres`
--
DROP TABLE IF EXISTS `estadisticas_lideres`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `estadisticas_lideres`  AS SELECT row_number() over () AS `id`, (select concat(`j`.`nombre`,' ',`j`.`apellido`) from (`jugador` `j` left join `jugador_partido` `jp` on(`j`.`id_jugador` = `jp`.`jugador_id`)) group by `j`.`id_jugador` order by `calcular_promedio_bateo`(`jp`.`hits`,`jp`.`turnos_al_bate`) desc limit 1) AS `mejor_promedio_bateo`, (select concat(`j`.`nombre`,' ',`j`.`apellido`) from (`jugador` `j` left join `jugador_partido` `jp` on(`j`.`id_jugador` = `jp`.`jugador_id`)) group by `j`.`id_jugador` order by `calcular_sbp`(`jp`.`bases_robadas`,`jp`.`turnos_al_bate`) desc limit 1) AS `mejor_sbp`, (select concat(`j`.`nombre`,' ',`j`.`apellido`) from (`jugador` `j` left join `jugador_partido_pitcher` `jpp` on(`j`.`id_jugador` = `jpp`.`jugador_id`)) group by `j`.`id_jugador` order by `encontrar_menor_era`(`jpp`.`innings_lanzado`,`jpp`.`carreras`) limit 1) AS `menor_era` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `bitacora_actualizacion_equipo`
--
ALTER TABLE `bitacora_actualizacion_equipo`
  ADD PRIMARY KEY (`id_bitacora`);

--
-- Indexes for table `bitacora_actualizacion_jugador`
--
ALTER TABLE `bitacora_actualizacion_jugador`
  ADD PRIMARY KEY (`id_bitacora`);

--
-- Indexes for table `bitacora_actualizacion_partido`
--
ALTER TABLE `bitacora_actualizacion_partido`
  ADD PRIMARY KEY (`id_bitacora`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `equipo`
--
ALTER TABLE `equipo`
  ADD PRIMARY KEY (`id_equipo`);

--
-- Indexes for table `jugador`
--
ALTER TABLE `jugador`
  ADD PRIMARY KEY (`id_jugador`),
  ADD KEY `equipo_id` (`equipo_id`);

--
-- Indexes for table `jugador_partido`
--
ALTER TABLE `jugador_partido`
  ADD PRIMARY KEY (`id_jugador_partido`),
  ADD KEY `jugador_id` (`jugador_id`),
  ADD KEY `partido_id` (`partido_id`);

--
-- Indexes for table `jugador_partido_pitcher`
--
ALTER TABLE `jugador_partido_pitcher`
  ADD PRIMARY KEY (`id_pitcher_stats`),
  ADD KEY `fk_jugador_partido_pitcher_jugador` (`jugador_id`),
  ADD KEY `fk_jugador_partido_pitcher_partido` (`partido_id`);

--
-- Indexes for table `partido`
--
ALTER TABLE `partido`
  ADD PRIMARY KEY (`id_partido`),
  ADD KEY `equipo_local_id` (`equipo_local_id`),
  ADD KEY `equipo_visitante_id` (`equipo_visitante_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bitacora_actualizacion_equipo`
--
ALTER TABLE `bitacora_actualizacion_equipo`
  MODIFY `id_bitacora` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bitacora_actualizacion_jugador`
--
ALTER TABLE `bitacora_actualizacion_jugador`
  MODIFY `id_bitacora` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bitacora_actualizacion_partido`
--
ALTER TABLE `bitacora_actualizacion_partido`
  MODIFY `id_bitacora` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `equipo`
--
ALTER TABLE `equipo`
  MODIFY `id_equipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `jugador`
--
ALTER TABLE `jugador`
  MODIFY `id_jugador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `jugador_partido`
--
ALTER TABLE `jugador_partido`
  MODIFY `id_jugador_partido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `jugador_partido_pitcher`
--
ALTER TABLE `jugador_partido_pitcher`
  MODIFY `id_pitcher_stats` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `partido`
--
ALTER TABLE `partido`
  MODIFY `id_partido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `jugador`
--
ALTER TABLE `jugador`
  ADD CONSTRAINT `fk_jugador_equipo` FOREIGN KEY (`equipo_id`) REFERENCES `equipo` (`id_equipo`);

--
-- Constraints for table `jugador_partido`
--
ALTER TABLE `jugador_partido`
  ADD CONSTRAINT `fk_jugador_partido_jugador` FOREIGN KEY (`jugador_id`) REFERENCES `jugador` (`id_jugador`),
  ADD CONSTRAINT `fk_jugador_partido_partido` FOREIGN KEY (`partido_id`) REFERENCES `partido` (`id_partido`);

--
-- Constraints for table `jugador_partido_pitcher`
--
ALTER TABLE `jugador_partido_pitcher`
  ADD CONSTRAINT `fk_jugador_partido_pitcher_jugador` FOREIGN KEY (`jugador_id`) REFERENCES `jugador` (`id_jugador`),
  ADD CONSTRAINT `fk_jugador_partido_pitcher_partido` FOREIGN KEY (`partido_id`) REFERENCES `partido` (`id_partido`);

--
-- Constraints for table `partido`
--
ALTER TABLE `partido`
  ADD CONSTRAINT `fk_partido_equipo_local` FOREIGN KEY (`equipo_local_id`) REFERENCES `equipo` (`id_equipo`),
  ADD CONSTRAINT `fk_partido_equipo_visitante` FOREIGN KEY (`equipo_visitante_id`) REFERENCES `equipo` (`id_equipo`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `actualizar_estadisticas` ON SCHEDULE EVERY 1 DAY STARTS '2024-05-29 18:09:05' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
        DECLARE v INTEGER;
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;

        SET v = 0;

        WHILE v < 1 DO
          -- Eliminar la vista si existe
          DROP VIEW IF EXISTS estadisticas_lideres;
          
          -- Crear la vista nuevamente con un id primary key
          CREATE VIEW estadisticas_lideres AS
          SELECT 
              ROW_NUMBER() OVER () AS id,
              (
                SELECT CONCAT(j.nombre, ' ', j.apellido)
                FROM jugador j
                LEFT JOIN jugador_partido jp ON j.id_jugador = jp.jugador_id
                GROUP BY j.id_jugador
                ORDER BY calcular_promedio_bateo(jp.hits, jp.turnos_al_bate) DESC
                LIMIT 1
              ) AS mejor_promedio_bateo,
              (
                SELECT CONCAT(j.nombre, ' ', j.apellido)
                FROM jugador j
                LEFT JOIN jugador_partido jp ON j.id_jugador = jp.jugador_id
                GROUP BY j.id_jugador
                ORDER BY calcular_sbp(jp.bases_robadas, jp.turnos_al_bate) DESC
                LIMIT 1
              ) AS mejor_sbp,
              (
                SELECT CONCAT(j.nombre, ' ', j.apellido)
                FROM jugador j
                LEFT JOIN jugador_partido_pitcher jpp ON j.id_jugador = jpp.jugador_id
                GROUP BY j.id_jugador
                ORDER BY encontrar_menor_era(jpp.innings_lanzado, jpp.carreras) ASC
                LIMIT 1
              ) AS menor_era;

          SET v = v + 1;
        END WHILE;
    END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
