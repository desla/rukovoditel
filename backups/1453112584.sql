DROP TABLE IF EXISTS app_access_groups;
DROP TABLE IF EXISTS app_attachments;
DROP TABLE IF EXISTS app_comments;
DROP TABLE IF EXISTS app_comments_access;
DROP TABLE IF EXISTS app_comments_history;
DROP TABLE IF EXISTS app_configuration;
DROP TABLE IF EXISTS app_entities;
DROP TABLE IF EXISTS app_entities_access;
DROP TABLE IF EXISTS app_entities_configuration;
DROP TABLE IF EXISTS app_entity_1;
DROP TABLE IF EXISTS app_entity_21;
DROP TABLE IF EXISTS app_entity_22;
DROP TABLE IF EXISTS app_entity_24;
DROP TABLE IF EXISTS app_entity_31;
DROP TABLE IF EXISTS app_entity_32;
DROP TABLE IF EXISTS app_entity_33;
DROP TABLE IF EXISTS app_fields;
DROP TABLE IF EXISTS app_fields_access;
DROP TABLE IF EXISTS app_fields_choices;
DROP TABLE IF EXISTS app_forms_tabs;
DROP TABLE IF EXISTS app_related_items;
DROP TABLE IF EXISTS app_reports;
DROP TABLE IF EXISTS app_reports_filters;
DROP TABLE IF EXISTS app_sessions;
DROP TABLE IF EXISTS app_users_configuration;


CREATE TABLE `app_access_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `is_ldap_default` tinyint(1) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

INSERT INTO app_access_groups VALUES
('4','Менеджер','1','0','2'),
('12','Подрядчик','0','0','0');

CREATE TABLE `app_attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_token` varchar(64) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `date_added` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

INSERT INTO app_attachments VALUES
('48','bc0461ef3d9b976ce56a59143075f1b3','1453110773_IMG-20160118-WA0000.jpg','2016-01-18'),
('47','2f96ff789be6145b72aa1db4089a59a7','1453109784_ВОР-СС-ЛС-02-02-08_связь.xlsx','2016-01-18'),
('46','2f96ff789be6145b72aa1db4089a59a7','1453109784_9118-91-0215-1030_от_21.12.15.pdf','2016-01-18'),
('45','2f96ff789be6145b72aa1db4089a59a7','1453109784_ВОР-СС-ЛС-06-01-06.01_связь.xlsx','2016-01-18'),
('44','97f63baa08e42e9c2b7e598eec2f21d9','1453102726_Alvasoft_Logos-Colors.pdf','2016-01-18'),
('43','7d3f809ebab774e90a68e36c7a942a23','1453101674_Альвасофт_Лого-и-Цвета.pdf','2016-01-18'),
('42','9cd46bae877cb49ecd01c21d72124dfd','1453101442_Альвасофт_Лого-и-Цвета.pdf','2016-01-18'),
('41','9cd46bae877cb49ecd01c21d72124dfd','1453101030_Альвасофт_Лого-и-Цвета.pdf','2016-01-18');

CREATE TABLE `app_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `items_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `description` text,
  `attachments` text NOT NULL,
  `date_added` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_items_id` (`items_id`),
  KEY `idx_created_by` (`created_by`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

INSERT INTO app_comments VALUES
('4','22','1','23','Напоминаю, 18 нужно ТЗ на стенд, хотя бы в тезисах, остальное будет по ходу создания.','','1452662028'),
('12','22','13','27','Задача 1. Редизайн существующего логотипа.\r\n\r\nЗадача 2. Создание элементов фирменного стиля для дальнейшего использования при продвижении компании на рынке: увеличение степени узнаваемости компании, облегчения разработки полиграфической и POS-продукции, при разработке сайта...','','1452752936'),
('17','22','13','27','<p>Повторная отправка</p>\r\n','1453102726_Alvasoft_Logos-Colors.pdf','1453102734'),
('18','21','11','22','<p>По согласованию с Е.Кондратьевым мы выставляем предложение выше указанной ниже суммы.</p>\r\n','1453110773_IMG-20160118-WA0000.jpg','1453110790');

CREATE TABLE `app_comments_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `access_groups_id` int(11) NOT NULL,
  `access_schema` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_access_groups_id` (`access_groups_id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

INSERT INTO app_comments_access VALUES
('4','21','6','view,create'),
('5','21','5','view,create'),
('6','21','4','view,create,update,delete'),
('7','22','5','view,create'),
('8','22','4','view,create,update,delete'),
('9','23','6','view,create'),
('10','23','4','view,create'),
('11','24','5','view,create'),
('12','24','4','view,create,update,delete'),
('13','22','12','view,create,update,delete'),
('14','21','12','view,create'),
('15','24','12','view,create'),
('16','31','12','view,create,update,delete'),
('17','31','4','view,create,update,delete'),
('18','32','4','view,create,update,delete'),
('19','33','4','view,create,update,delete');

CREATE TABLE `app_comments_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comments_id` int(11) NOT NULL,
  `fields_id` int(11) NOT NULL,
  `fields_value` text,
  PRIMARY KEY (`id`),
  KEY `idx_comments_id` (`comments_id`),
  KEY `idx_fields_id` (`fields_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE `app_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `configuration_name` varchar(255) NOT NULL DEFAULT '',
  `configuration_value` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

INSERT INTO app_configuration VALUES
('11','CFG_APP_LOGO','alvasoft_logo.png'),
('10','CFG_APP_SHORT_NAME','АльваСофт'),
('9','CFG_APP_NAME','Управление проектами'),
('12','CFG_EMAIL_USE_NOTIFICATION','1'),
('13','CFG_EMAIL_SUBJECT_LABEL',NULL),
('14','CFG_EMAIL_AMOUNT_PREVIOUS_COMMENTS','2'),
('15','CFG_EMAIL_COPY_SENDER','0'),
('16','CFG_EMAIL_SEND_FROM_SINGLE','1'),
('17','CFG_EMAIL_ADDRESS_FROM','info@alvasoft.ru'),
('18','CFG_EMAIL_NAME_FROM','АльваСофт'),
('19','CFG_EMAIL_USE_SMTP','0'),
('20','CFG_EMAIL_SMTP_SERVER',NULL),
('21','CFG_EMAIL_SMTP_PORT',NULL),
('22','CFG_EMAIL_SMTP_ENCRYPTION',NULL),
('23','CFG_EMAIL_SMTP_LOGIN',NULL),
('24','CFG_EMAIL_SMTP_PASSWORD',NULL),
('25','CFG_LDAP_USE','0'),
('26','CFG_LDAP_SERVER_NAME',NULL),
('27','CFG_LDAP_SERVER_PORT',NULL),
('28','CFG_LDAP_BASE_DN',NULL),
('29','CFG_LDAP_UID',NULL),
('30','CFG_LDAP_USER',NULL),
('31','CFG_LDAP_EMAIL_ATTRIBUTE',NULL),
('32','CFG_LDAP_USER_DN',NULL),
('33','CFG_LDAP_PASSWORD',NULL),
('34','CFG_LOGIN_PAGE_HEADING',NULL),
('35','CFG_LOGIN_PAGE_CONTENT',NULL),
('36','CFG_APP_TIMEZONE','Asia/Krasnoyarsk'),
('37','CFG_APP_DATE_FORMAT','d/m/Y'),
('38','CFG_APP_DATETIME_FORMAT','d/m/Y H:i'),
('39','CFG_APP_ROWS_PER_PAGE','10'),
('40','CFG_REGISTRATION_EMAIL_SUBJECT',NULL),
('41','CFG_REGISTRATION_EMAIL_BODY',NULL),
('42','CFG_PASSWORD_MIN_LENGTH','4'),
('43','CFG_APP_LANGUAGE','russian.php'),
('44','CFG_APP_SKIN','light'),
('45','CFG_PUBLIC_USER_PROFILE_FIELDS',NULL),
('46','CFG_APP_FIRST_DAY_OF_WEEK','1');

CREATE TABLE `app_entities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `display_in_menu` tinyint(1) DEFAULT '0',
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

INSERT INTO app_entities VALUES
('1','0','Пользователи','0','10'),
('22','21','Задачи','1','2'),
('24','21','Обсуждения','0','6'),
('21','0','Проекты','0','1'),
('31','21','Документы','1','3'),
('32','21','Входящие письма','1','4'),
('33','21','Исходящие письма','1','5');

CREATE TABLE `app_entities_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `access_groups_id` int(11) NOT NULL,
  `access_schema` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_access_groups_id` (`access_groups_id`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

INSERT INTO app_entities_access VALUES
('28','21','6','view_assigned'),
('29','21','5','view_assigned,reports'),
('30','21','4','view,create,update,delete,reports'),
('31','22','6',''),
('32','22','5','view,create,update,reports'),
('33','22','4','view,create,update,delete,reports'),
('34','23','6','view_assigned,create,update,reports'),
('35','23','5',''),
('36','23','4','view,create,update,delete,reports'),
('37','24','6',''),
('38','24','5','view_assigned,create,update,delete,reports'),
('39','24','4','view,create,update,delete,reports'),
('40','21','12','view_assigned,reports'),
('41','22','12','view_assigned,create,reports'),
('42','24','12','view_assigned,create,update,reports'),
('43','23','12',''),
('44','1','12',''),
('45','1','4','view'),
('46','31','12','view,create,update,reports'),
('47','31','4','view,create,update,delete,reports'),
('48','32','12',''),
('49','32','4','view,create,update,delete,reports'),
('50','33','12',''),
('51','33','4','view,create,update,delete,reports');

CREATE TABLE `app_entities_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `configuration_name` varchar(255) NOT NULL DEFAULT '',
  `configuration_value` text,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`)
) ENGINE=MyISAM AUTO_INCREMENT=151 DEFAULT CHARSET=utf8;

INSERT INTO app_entities_configuration VALUES
('30','21','use_comments','1'),
('29','21','email_subject_new_item','Новый проект:'),
('28','21','insert_button','Добавить проект'),
('11','1','menu_title','Пользователи'),
('12','1','listing_heading','Пользователи'),
('13','1','window_heading','Информация о пользователе'),
('14','1','insert_button','Добавить пользователя'),
('15','1','use_comments','0'),
('27','21','window_heading','Информация о проекте'),
('25','21','menu_title',' Проекты'),
('26','21','listing_heading',' Проекты'),
('32','22','menu_title','Задачи'),
('31','21','email_subject_new_comment','Новый комментарий к проекту:'),
('33','22','listing_heading','Задачи'),
('34','22','window_heading','Информация о задаче'),
('35','22','insert_button','Добавить задачу'),
('36','22','email_subject_new_item','Новая задача'),
('37','22','use_comments','1'),
('38','22','email_subject_new_comment','Новый комментарий к задаче:'),
('138','33','email_subject_new_item','Новое исходящее письмо'),
('136','33','window_heading','Исходящее письмо'),
('137','33','insert_button','Добавить исходящее письмо'),
('134','33','menu_icon','fa-envelope'),
('135','33','listing_heading','Исходящие письма'),
('46','24','menu_title','Обсуждения'),
('47','24','listing_heading','Обсуждения'),
('48','24','window_heading','Информация об обсуждении'),
('49','24','insert_button','Добавить обсуждение'),
('50','24','email_subject_new_item','Новое обсуждение:'),
('51','24','use_comments','1'),
('52','24','email_subject_new_comment','Новый комментраий к обсуждению:'),
('53','21','use_editor_in_comments','1'),
('54','22','use_editor_in_comments','1'),
('133','33','menu_title','Исходящие письма'),
('56','24','use_editor_in_comments','1'),
('126','32','listing_heading','Входящие письма'),
('125','32','menu_icon','fa-envelope-o'),
('123','31','email_subject_new_comment',NULL),
('124','32','menu_title','Входящие письма'),
('122','31','use_editor_in_comments','1'),
('66','21','menu_icon',NULL),
('67','22','menu_icon','fa-tasks'),
('69','24','menu_icon',NULL),
('121','31','use_comments','1'),
('120','31','email_subject_new_item','Новый документы'),
('117','31','listing_heading','Документы'),
('118','31','window_heading','Документ'),
('119','31','insert_button','Добавить документы'),
('132','32','email_subject_new_comment',NULL),
('131','32','use_editor_in_comments','1'),
('130','32','use_comments','1'),
('129','32','email_subject_new_item','Новое входящее письмо'),
('128','32','insert_button','Добавить входящее письмо'),
('127','32','window_heading','Входящее письмо'),
('116','31','menu_icon','fa-book'),
('115','31','menu_title','Документы'),
('139','33','use_comments','1'),
('140','33','use_editor_in_comments','1'),
('141','33','email_subject_new_comment',NULL);

CREATE TABLE `app_entity_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `parent_item_id` int(11) NOT NULL DEFAULT '0',
  `linked_id` int(11) NOT NULL DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL,
  `field_5` text,
  `field_6` text,
  `field_7` text,
  `field_8` text,
  `field_9` text,
  `field_10` text,
  `field_12` text,
  `field_13` text,
  `field_14` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

INSERT INTO app_entity_1 VALUES
('19','0','0','0','0',NULL,'0','$P$EjWx/8DNkvAtjTeRiL3G8O7DJRtL7L/','1','0','Админ','Альвасофт','info@alvasoft.ru',NULL,'desla','russian.php','blue'),
('20','0','0','0','1452656757','19','0','$P$E3qITK1HVg6iKehRY7z7QLep1GQC5i.','1','4','Денис','Зинченко','denis.zinchenko@alvasoft.ru','1452657603_276ecce.jpg','dzinchenko','russian.php','light'),
('21','0','0','0','1452661473','19','0','$P$EjbO1YNTolYDbFmWJSdNQU4UmB6n6p0','1','4','Аркадий','Зелютков','arkadij@alvasoft.ru',NULL,'azelytkov','russian.php','light'),
('22','0','0','0','1452661478','19','0','$P$E84fmqxgQA7pEJJ.gLxp7ybNVVi8M01','1','4','Вячеслав','Прокопьев','slavage@alvasoft.ru','1453035826_20160109_220957.jpg','vprokopiev','russian.php','light'),
('23','0','0','0','1452661482','19','0','$P$ELcmNG4gFJQU4InixR57YsRMfPPVc10','1','4','Павел','Кочкин','pavel_k@alvasoft.ru',NULL,'pkochkin','russian.php','light'),
('24','0','0','0','1452661485','19','0','$P$EeWz7AawuMV2umkJA1sO1a6S.TcHXg.','1','4','Сергей','Колчанов','kolchanov_s@alvasoft.ru',NULL,'skolchanov','russian.php','light'),
('25','0','0','0','1452661489','19','0','$P$EnFt3YouLbbwU8KA9TELei.TKgdKGF/','1','4','Василий','Панько','vpanko@alvasoft.ru',NULL,'vpanko','russian.php','light'),
('27','0','0','0','1452749259','19','0','$P$EihYdtPHcPzDYR27znfv1pP3bdiALX/','1','12','Наталья','Корнюш','malvasia@yandex.ru',NULL,'nkornysh','russian.php','light');

CREATE TABLE `app_entity_21` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_156` text NOT NULL,
  `field_157` text NOT NULL,
  `field_158` text NOT NULL,
  `field_159` text NOT NULL,
  `field_160` text NOT NULL,
  `field_161` text NOT NULL,
  `field_196` text NOT NULL,
  `field_198` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

INSERT INTO app_entity_21 VALUES
('1','0','0','0','1452657098','20','0','68','38','Контроль геометрии слитков','','<p>Система автоматического контроля&nbsp;геометрии и отбраковки&nbsp;алюминиевых слитков.</p>\r\n','21,20,24,23,25,22','14014','73'),
('2','0','0','0','1452661624','20','0','68','38','Ребрендинг фирмы','','<p>Создать новый шаблон сайта, логотип и фирменный стиль.</p>\r\n','20,22,27','14015','75'),
('3','0','0','0','1452667866','20','0','68','38','Экспертная система','','<p>Реализация проекта &quot;Экспертная система&quot;.</p>\r\n','20,22','','72'),
('6','0','0','0','1452691475','20','0','68','38','Графики для Русала','','<p>Необходимо исправить графики, чтобы эта задача не висела мертвым грузом.</p>\r\n','22','','72'),
('5','0','0','0','1452676423','24','0','68','38','Замена контроллера Антресоль','1445533200','<p>Замена контроллера на участке Антресоль и модификация Lacta 15</p>\r\n','21,24,23,22','15008','71'),
('7','0','0','0','1452693292','19','0','68','39','Аудио-сервер ЧАСТЬ 2','','<p>Выполнение 2 части проекта &quot;Аудио-сервер&quot;</p>\r\n','20,22','','72'),
('10','0','0','0','1453036432','22','0','68','37','Офис АльваСофт','','<p>В данном проекте будут представлены <strong>задачи, связанные с жизнью в офисе</strong>. Например надо метелку купить, чтобы мести крыльцо.</p>\r\n','21,20,24,23,25,22','1','75'),
('9','0','0','0','1453035700','22','0','68','41','--- Нет проекта ---','','','','0','75'),
('11','0','0','0','1453109692','22','0','68','37','Устройство сетей связи \"Установка 4-го ЛК Properzi в ЛО №2\"','','<p>Выполнение работ по поставке оборудования и материалов, выполнению СМР и ПНР по устройству сетей связи в рамках реализации инвестиционного мероприятия &quot;Установка 4-го литейного комплекса горизонтального литья Properzi в ЛО №2&quot;</p>\r\n','20,25','16001','71');

CREATE TABLE `app_entity_22` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_167` text NOT NULL,
  `field_168` text NOT NULL,
  `field_169` text NOT NULL,
  `field_170` text NOT NULL,
  `field_171` text NOT NULL,
  `field_172` text NOT NULL,
  `field_173` text NOT NULL,
  `field_175` text NOT NULL,
  `field_176` text NOT NULL,
  `field_177` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

INSERT INTO app_entity_22 VALUES
('1','0','1','0','1452657308','20','0','42','Требования к макету круглых слитков','50','55','20,22','<p>Составить требования к макету круглых слитков для Паши.</p>\r\n','','','1453050000',''),
('18','0','1','0','1453091824','20','0','42','Написать статью для Васи','70','55','20','<p>Подготовить статью для конференции.</p>\r\n','','','1454173200',''),
('13','0','2','0','1452750116','20','0','42','Создать логотип Alvasoft','47','55','20,27','<p>Необходимо создать логотип фирмы.</p>\r\n','','','1454173200',''),
('6','0','5','0','1452676593','24','0','42','Отправка оборудования','47','55','24','','','1448470800','1458493200',''),
('7','0','5','0','1452676671','24','0','42','Получение оборудования','47','55','24','','','1453050000','1453395600',''),
('8','0','5','0','1452676764','24','0','42','Сборка шкафов','69','55','24','','','1456074000','1457888400',''),
('11','0','3','0','1452682803','20','0','42','Проектирование оставшейся части ЭС','70','55','20,22','<p>Надо спроектировать остальную часть ЭС.</p>\r\n','','','1454173200',''),
('12','0','6','0','1452691545','20','0','42','Доделать графики','47','54','22','<p>Необходимо доделать график и отдать Вове.</p>\r\n','','','1454173200',''),
('10','0','5','0','1452680782','24','0','42','Получение оборудования','69','55','24','<p>SMC и Овен</p>\r\n','','1455469200','1455814800',''),
('14','0','2','0','1452750161','20','0','42','Создать дизайн сайта','47','55','20,27','<p>Необходимо создать дизайн сайта</p>\r\n','','','1454173200','');

CREATE TABLE `app_entity_24` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_191` text NOT NULL,
  `field_192` text NOT NULL,
  `field_193` text NOT NULL,
  `field_195` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `app_entity_31` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_250` text NOT NULL,
  `field_251` text NOT NULL,
  `field_252` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE `app_entity_32` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_257` text NOT NULL,
  `field_258` text NOT NULL,
  `field_259` text NOT NULL,
  `field_260` text NOT NULL,
  `field_261` text NOT NULL,
  `field_271` text NOT NULL,
  `field_280` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

INSERT INTO app_entity_32 VALUES
('6','0','11','0','1453110474','22','0','Запрос на предоставление ТКП','Е.Кондратьев','1450630800','<p>К участию в отборе подрядной организации на выполнение работ по поставке оборудования и материалов, выполнению СМР и ПНР по устройству сетей связи в рамках реализации инвестиционного мероприятия &quot;Установка 4-го литейного комплекса горизонтального литья Properzi в ЛО №2&quot;</p>\r\n','1453109784_ВОР-СС-ЛС-02-02-08_связь.xlsx,1453109784_9118-91-0215-1030_от_21.12.15.pdf,1453109784_ВОР-СС-ЛС-06-01-06.01_связь.xlsx','','9119-91-0215-1030'),
('5','0','3','0','1453035543','22','0','павапвапва','','1452963600','','','1','');

CREATE TABLE `app_entity_33` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_266` text NOT NULL,
  `field_267` text NOT NULL,
  `field_268` text NOT NULL,
  `field_269` text NOT NULL,
  `field_270` text NOT NULL,
  `field_272` text NOT NULL,
  `field_281` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

INSERT INTO app_entity_33 VALUES
('5','0','3','0','1453035519','22','0','ТКП','1452963600','Кол','','','1','');

CREATE TABLE `app_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `forms_tabs_id` int(11) NOT NULL,
  `type` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `short_name` varchar(64) DEFAULT NULL,
  `is_heading` tinyint(1) DEFAULT '0',
  `tooltip` text,
  `is_required` tinyint(1) DEFAULT '0',
  `required_message` text,
  `configuration` text,
  `sort_order` int(11) DEFAULT '0',
  `listing_status` tinyint(4) NOT NULL DEFAULT '0',
  `listing_sort_order` int(11) NOT NULL DEFAULT '0',
  `comments_status` tinyint(1) NOT NULL DEFAULT '0',
  `comments_sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_form_tabs_id` (`forms_tabs_id`)
) ENGINE=MyISAM AUTO_INCREMENT=282 DEFAULT CHARSET=utf8;

INSERT INTO app_fields VALUES
('1','1','1','fieldtype_action','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','5','0','0'),
('2','1','1','fieldtype_id','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0'),
('3','1','1','fieldtype_date_added','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0'),
('4','1','1','fieldtype_created_by','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0'),
('5','1','1','fieldtype_user_status','',NULL,NULL,NULL,NULL,NULL,NULL,'0','1','4','0','0'),
('6','1','1','fieldtype_user_accessgroups','',NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0','0','0'),
('7','1','1','fieldtype_user_firstname','',NULL,NULL,NULL,NULL,NULL,'{\"allow_search\":\"1\"}','3','1','1','0','0'),
('8','1','1','fieldtype_user_lastname','',NULL,NULL,NULL,NULL,NULL,'{\"allow_search\":\"1\"}','4','1','2','0','0'),
('9','1','1','fieldtype_user_email','',NULL,NULL,NULL,NULL,NULL,'{\"allow_search\":\"1\"}','6','1','3','0','0'),
('10','1','1','fieldtype_user_photo','',NULL,NULL,NULL,NULL,NULL,NULL,'5','0','0','0','0'),
('12','1','1','fieldtype_user_username','',NULL,'1',NULL,NULL,NULL,'{\"allow_search\":\"1\"}','2','1','0','0','0'),
('177','22','26','fieldtype_attachments','Вложения',NULL,'0',NULL,'0',NULL,NULL,'6','0','0','0','0'),
('176','22','27','fieldtype_input_date','Дата окончания',NULL,'0',NULL,'0',NULL,NULL,'2','1','4','0','0'),
('171','22','26','fieldtype_users','Назначен на',NULL,'0',NULL,'1',NULL,'{\"display_as\":\"dropdown_muliple\"}','4','0','0','0','0'),
('196','21','24','fieldtype_input_numeric','Номер проекта','Номер','0',NULL,'0',NULL,NULL,'1','1','0','0','0'),
('173','22','27','fieldtype_input_numeric','Расчетное время',NULL,'0',NULL,'0',NULL,NULL,'0','0','0','0','0'),
('172','22','26','fieldtype_textarea_wysiwyg','Описание',NULL,'0',NULL,'0',NULL,'{\"allow_search\":\"1\"}','5','0','0','0','0'),
('14','1','1','fieldtype_user_skin','',NULL,'0',NULL,'0',NULL,NULL,'0','0','0','0','0'),
('13','1','1','fieldtype_user_language','',NULL,'0',NULL,'0',NULL,NULL,'7','0','0','0','0'),
('170','22','26','fieldtype_dropdown','Приоритет',NULL,'0',NULL,'1',NULL,'{\"width\":\"input-medium\"}','3','1','0','0','0'),
('169','22','26','fieldtype_dropdown','Статус',NULL,'0',NULL,'1',NULL,'{\"width\":\"input-large\"}','2','1','1','0','0'),
('164','22','26','fieldtype_id','',NULL,'0',NULL,'0',NULL,NULL,'0','0','0','0','0'),
('165','22','26','fieldtype_date_added','',NULL,'0',NULL,'0',NULL,NULL,'0','0','0','0','0'),
('166','22','26','fieldtype_created_by','',NULL,'0',NULL,'0',NULL,NULL,'0','0','0','0','0'),
('167','22','26','fieldtype_dropdown','Тип',NULL,'0',NULL,'1',NULL,'{\"width\":\"input-medium\"}','0','0','0','0','0'),
('168','22','26','fieldtype_input','Название',NULL,'1',NULL,'1',NULL,'{\"allow_search\":\"1\",\"width\":\"input-xlarge\"}','1','1','2','0','0'),
('258','32','37','fieldtype_input','Отправитель','Отправитель','0',NULL,'0',NULL,'{\"width\":\"input-large\"}','3','1','3','0','0'),
('163','22','26','fieldtype_action','',NULL,'0',NULL,'0',NULL,NULL,'0','1','5','0','0'),
('280','32','37','fieldtype_input_numeric','Номер','Номер','0',NULL,'0',NULL,NULL,'0','1','0','0','0'),
('161','21','25','fieldtype_users','Команда',NULL,'0',NULL,'0',NULL,'{\"display_as\":\"checkboxes\"}','0','0','0','0','0'),
('159','21','24','fieldtype_input_date','Дата начала проекта',NULL,'0',NULL,'0',NULL,NULL,'5','0','0','0','0'),
('160','21','24','fieldtype_textarea_wysiwyg','Описание',NULL,'0',NULL,'0',NULL,'{\"allow_search\":\"1\"}','6','0','0','0','0'),
('158','21','24','fieldtype_input','Название',NULL,'1',NULL,'1',NULL,'{\"allow_search\":\"1\",\"width\":\"input-xlarge\"}','4','1','4','0','0'),
('257','32','37','fieldtype_input','Тема','Тема','1',NULL,'1',NULL,'{\"width\":\"input-large\"}','2','1','2','0','0'),
('175','22','27','fieldtype_input_date','Дата начала',NULL,'0',NULL,'0',NULL,NULL,'1','1','3','0','0'),
('157','21','24','fieldtype_dropdown','Статус',NULL,'0',NULL,'1',NULL,'{\"width\":\"input-medium\"}','3','1','3','0','0'),
('156','21','24','fieldtype_dropdown','Приоритет',NULL,'0',NULL,'1',NULL,'{\"width\":\"input-medium\"}','2','1','2','0','0'),
('155','21','24','fieldtype_created_by','',NULL,'0',NULL,'0',NULL,NULL,'0','0','0','0','0'),
('154','21','24','fieldtype_date_added','',NULL,'0',NULL,'0',NULL,NULL,'0','0','0','0','0'),
('153','21','24','fieldtype_id','',NULL,'0',NULL,'0',NULL,NULL,'0','0','0','0','0'),
('152','21','24','fieldtype_action','',NULL,'0',NULL,'0',NULL,NULL,'0','1','5','0','0'),
('267','33','38','fieldtype_input_date','Дата отправления','Дата отправления','0',NULL,'0',NULL,'{\"background\":\"#b4a6a6\"}','1','1','1','0','0'),
('256','32','37','fieldtype_created_by','',NULL,'0',NULL,'0',NULL,NULL,'3','1','4','0','0'),
('251','31','36','fieldtype_textarea_wysiwyg','Описание','Описание','0',NULL,'0',NULL,NULL,'5','0','0','0','0'),
('187','24','29','fieldtype_action','',NULL,'0',NULL,'0',NULL,NULL,'0','1','0','0','0'),
('188','24','29','fieldtype_id','',NULL,'0',NULL,'0',NULL,NULL,'0','1','1','0','0'),
('189','24','29','fieldtype_date_added','',NULL,'0',NULL,'0',NULL,NULL,'0','1','4','0','0'),
('190','24','29','fieldtype_created_by','',NULL,'0',NULL,'0',NULL,NULL,'0','1','5','0','0'),
('191','24','29','fieldtype_input','Название',NULL,'1',NULL,'1',NULL,'{\"allow_search\":\"1\",\"width\":\"input-xlarge\"}','1','1','3','0','0'),
('192','24','29','fieldtype_textarea_wysiwyg','Описание',NULL,'0',NULL,'0',NULL,'{\"allow_search\":\"1\"}','2','0','0','0','0'),
('193','24','29','fieldtype_dropdown','Статус',NULL,'0',NULL,'0',NULL,'{\"width\":\"input-medium\"}','0','1','2','0','0'),
('195','24','29','fieldtype_attachments','Вложения',NULL,'0',NULL,'0',NULL,NULL,'3','0','0','0','0'),
('198','21','24','fieldtype_dropdown','Тип проекта',NULL,'0',NULL,'1',NULL,'{\"width\":\"input-medium\",\"use_search\":\"1\"}','0','1','1','0','0'),
('252','31','36','fieldtype_attachments','Вложения','Вложения','0',NULL,'1',NULL,NULL,'6','1','1','0','0'),
('253','32','37','fieldtype_action','',NULL,'0',NULL,'0',NULL,NULL,'0','1','5','0','0'),
('254','32','37','fieldtype_id','',NULL,'0',NULL,'0',NULL,NULL,'1','0','0','0','0'),
('255','32','37','fieldtype_date_added','',NULL,'0',NULL,'0',NULL,NULL,'2','0','0','0','0'),
('264','33','38','fieldtype_date_added','',NULL,'0',NULL,'0',NULL,NULL,'2','0','0','0','0'),
('265','33','38','fieldtype_created_by','',NULL,'0',NULL,'0',NULL,NULL,'3','1','4','0','0'),
('246','31','36','fieldtype_action','',NULL,'0',NULL,'0',NULL,NULL,'0','1','4','0','0'),
('247','31','36','fieldtype_id','',NULL,'0',NULL,'0',NULL,NULL,'1','0','0','0','0'),
('248','31','36','fieldtype_date_added','',NULL,'0',NULL,'0',NULL,NULL,'2','1','2','0','0'),
('249','31','36','fieldtype_created_by','',NULL,'0',NULL,'0',NULL,NULL,'3','1','3','0','0'),
('266','33','38','fieldtype_input','Тема','Тема','1',NULL,'1',NULL,'{\"width\":\"input-large\"}','2','1','2','0','0'),
('261','32','37','fieldtype_attachments','Вложения','Вложения','0',NULL,'0',NULL,NULL,'5','0','0','0','0'),
('260','32','37','fieldtype_textarea_wysiwyg','Описание','Описание','0',NULL,'0',NULL,NULL,'4','0','0','0','0'),
('259','32','37','fieldtype_input_date','Дата получения','Дата получения','0',NULL,'0',NULL,'{\"background\":\"#b4a6a6\"}','1','1','1','0','0'),
('250','31','36','fieldtype_input','Название','Название','1',NULL,'1',NULL,'{\"width\":\"input-large\"}','4','1','0','0','0'),
('262','33','38','fieldtype_action','',NULL,'0',NULL,'0',NULL,NULL,'0','1','5','0','0'),
('263','33','38','fieldtype_id','',NULL,'0',NULL,'0',NULL,NULL,'1','0','0','0','0'),
('268','33','38','fieldtype_input','Получатель','Получатель','0',NULL,'0',NULL,'{\"width\":\"input-large\"}','3','1','3','0','0'),
('269','33','38','fieldtype_textarea_wysiwyg','Описание','Описание','0',NULL,'0',NULL,NULL,'4','0','0','0','0'),
('270','33','38','fieldtype_attachments','Вложения','Вложения','0',NULL,'0',NULL,NULL,'5','0','0','0','0'),
('271','32','37','fieldtype_related_records','Исходящие письма','Исходящие письма','0',NULL,'0',NULL,'{\"entity_id\":\"33\"}','5','0','0','0','0'),
('272','33','38','fieldtype_related_records','Входящие письма','Входящие письма','0',NULL,'0',NULL,'{\"entity_id\":\"32\"}','9','0','0','0','0'),
('281','33','38','fieldtype_input_numeric','Номер','Номер','0',NULL,'0',NULL,NULL,'0','1','0','0','0');

CREATE TABLE `app_fields_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `access_groups_id` int(11) NOT NULL,
  `entities_id` int(11) NOT NULL,
  `fields_id` int(11) NOT NULL,
  `access_schema` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_fields_id` (`fields_id`),
  KEY `idx_access_groups_id` (`access_groups_id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

INSERT INTO app_fields_access VALUES
('24','4','1','14','hide'),
('25','4','1','12','hide'),
('26','4','1','13','hide');

CREATE TABLE `app_fields_choices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `fields_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `bg_color` varchar(16) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `users` text,
  PRIMARY KEY (`id`),
  KEY `idx_fields_id` (`fields_id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;

INSERT INTO app_fields_choices VALUES
('35','0','156','Высокий','0','#9ea10c','2',NULL),
('34','0','156','Срочный','0','#ff0000','1',NULL),
('37','0','157','Новый','0',NULL,'1',NULL),
('38','0','157','Открытый','0',NULL,'2',NULL),
('39','0','157','В ожидании','0',NULL,'3',NULL),
('40','0','157','Закрытый','0',NULL,'4',NULL),
('41','0','157','Отменён','0',NULL,'5',NULL),
('42','0','167','Задача','1',NULL,'1',NULL),
('43','0','167','Изменение','0',NULL,'2',NULL),
('44','0','167','Ошибка','0','#ff7a00','3',NULL),
('45','0','167','Идея','0',NULL,'0',NULL),
('69','0','169','В ожидании','0',NULL,'0',NULL),
('47','0','169','В работе','0',NULL,'2',NULL),
('50','0','169','Завершена','0',NULL,'5',NULL),
('51','0','169','Ожидает оплаты','0',NULL,'6',NULL),
('52','0','169','Отменена','0',NULL,'7',NULL),
('53','0','170','Срочный','0','#ff0000','1',NULL),
('54','0','170','Высокий','0','#9ea10c','2',NULL),
('55','0','170','Средний','1',NULL,'3',NULL),
('65','0','193','Открыт','0',NULL,'1',NULL),
('66','0','193','Закрыт','0',NULL,'2',NULL),
('67','0','193','Новый','1',NULL,'0',NULL),
('68','0','156','Обычный','1','#bdbdbd','1',NULL),
('70','0','169','Новая','1',NULL,'1',NULL),
('71','0','198','АСУТП','1',NULL,'0',NULL),
('72','0','198','Программный','0',NULL,'1',NULL),
('73','0','198','Программно-аппаратный','0',NULL,'2',NULL),
('74','0','198','Проектирование','0',NULL,'3',NULL),
('75','0','198','Организационный','0',NULL,'4',NULL);

CREATE TABLE `app_forms_tabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` text NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

INSERT INTO app_forms_tabs VALUES
('1','1','Информация','','0'),
('25','21','Команда','','1'),
('26','22','Информация','','0'),
('27','22','Время','','1'),
('37','32','Информация','','0'),
('29','24','Информация','','0'),
('24','21','Информация','','0'),
('36','31','Информация','','0'),
('38','33','Информация','','0');

CREATE TABLE `app_related_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `items_id` int(11) NOT NULL,
  `related_entities_id` int(11) NOT NULL,
  `related_items_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_items_id` (`items_id`),
  KEY `idx_related_entities_id` (`related_entities_id`),
  KEY `idx_related_items_id` (`related_items_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

INSERT INTO app_related_items VALUES
('2','21','8','29','2'),
('4','21','8','29','3'),
('5','21','8','30','1'),
('6','32','1','33','2'),
('7','32','2','33','3'),
('8','32','2','33','1'),
('9','21','8','34','2'),
('10','32','3','33','4'),
('12','33','5','32','5');

CREATE TABLE `app_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `entities_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `reports_type` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `in_menu` tinyint(1) NOT NULL DEFAULT '0',
  `in_dashboard` tinyint(4) NOT NULL DEFAULT '0',
  `dashboard_sort_order` int(11) DEFAULT NULL,
  `listing_order_fields` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_created_by` (`created_by`)
) ENGINE=MyISAM AUTO_INCREMENT=186 DEFAULT CHARSET=utf8;

INSERT INTO app_reports VALUES
('59','0','21','0','default','','0','0',NULL,'196_asc'),
('61','0','22','0','default','','0','0',NULL,''),
('152','0','21','19','parent','','0','0',NULL,''),
('66','0','21','19','entity','','0','0',NULL,'196_asc'),
('67','0','1','19','entity','','0','0',NULL,''),
('68','0','21','20','entity','','0','0',NULL,''),
('69','0','22','20','entity','','0','0',NULL,''),
('70','71','22','19','entity_menu','','0','0',NULL,''),
('71','0','21','19','parent','','0','0',NULL,''),
('72','73','22','20','entity_menu','','0','0',NULL,''),
('73','0','21','20','parent','','0','0',NULL,''),
('74','0','21','19','standard','Мои проекты','1','0',NULL,''),
('75','0','21','19','standard','Текущие проекты','0','1',NULL,''),
('76','0','1','0','default','','0','0',NULL,''),
('77','0','21','20','standard','Текущие проекты','0','1','1',''),
('78','79','22','20','standard','Мои задачи','0','1','0',''),
('79','0','21','20','parent','','0','0',NULL,''),
('80','0','22','19','entity','','0','0',NULL,''),
('81','82','22','24','entity_menu','','0','0',NULL,''),
('82','0','21','24','parent','','0','0',NULL,''),
('83','0','21','24','entity','','0','0',NULL,''),
('84','0','22','24','entity','','0','0',NULL,''),
('85','0','24','24','entity','','0','0',NULL,''),
('89','0','21','23','entity','','0','0',NULL,''),
('87','88','22','23','entity_menu','','0','0',NULL,''),
('88','0','21','23','parent','','0','0',NULL,''),
('90','0','22','23','entity','','0','0',NULL,''),
('94','95','22','22','entity_menu','','0','0',NULL,''),
('95','0','21','22','parent','','0','0',NULL,''),
('96','0','21','22','entity','','0','0',NULL,'196_asc'),
('97','0','22','22','entity','','0','0',NULL,''),
('101','0','21','22','standard','Текущие проекты','0','1',NULL,''),
('99','100','22','22','standard','Мои задачи','0','1',NULL,''),
('100','0','21','22','parent','','0','0',NULL,''),
('102','103','22','26','entity_menu','','0','0',NULL,''),
('103','0','21','26','parent','','0','0',NULL,''),
('104','0','21','26','entity','','0','0',NULL,'196_asc'),
('105','106','22','25','entity_menu','','0','0',NULL,''),
('106','0','21','25','parent','','0','0',NULL,''),
('107','0','21','26','standard','Мои проекты','0','1',NULL,''),
('108','0','22','25','entity','','0','0',NULL,''),
('109','0','21','25','entity','','0','0',NULL,'196_asc'),
('110','0','22','26','entity','','0','0',NULL,''),
('111','0','21','25','standard','Текущие проекты','0','1',NULL,''),
('113','114','22','25','standard','Мои задачи','0','1',NULL,''),
('114','0','21','25','parent','','0','0',NULL,''),
('115','0','21','24','standard','Мои','0','1','0',''),
('116','0','21','24','standard','Задействован','0','1','1',''),
('117','118','22','24','standard','Активные задачи','0','1','2',''),
('118','0','21','24','parent','','0','0',NULL,''),
('119','0','24','20','entity','','0','0',NULL,''),
('124','125','22','24','standard','Мои задачи','0','1','3',''),
('158','159','32','19','entity_menu','','0','0',NULL,''),
('125','0','21','24','parent','','0','0',NULL,''),
('127','128','22','21','entity_menu','','0','0',NULL,''),
('128','0','21','21','parent','','0','0',NULL,''),
('129','0','21','21','standard','Текущие проекты','0','1',NULL,''),
('130','131','22','21','standard','Мои задачи','0','1',NULL,''),
('131','0','21','21','parent','','0','0',NULL,''),
('132','0','1','20','entity','','0','0',NULL,''),
('133','134','22','20','standard','Новые задачи','0','1','2',''),
('134','0','21','20','parent','','0','0',NULL,''),
('135','136','22','27','entity_menu','','0','0',NULL,''),
('136','0','21','27','parent','','0','0',NULL,''),
('137','0','21','27','standard','Проекты','0','1',NULL,''),
('138','139','22','27','standard','Мои задачи','0','1',NULL,''),
('139','0','21','27','parent','','0','0',NULL,''),
('140','0','22','27','entity','','0','0',NULL,''),
('141','0','21','27','entity','','0','0',NULL,'196_asc'),
('142','0','24','0','default','','0','0',NULL,''),
('143','0','1','24','entity','','0','0',NULL,''),
('156','157','31','19','entity_menu','','0','0',NULL,''),
('150','0','21','19','parent','','0','0',NULL,''),
('157','0','21','19','parent','','0','0',NULL,''),
('159','0','21','19','parent','','0','0',NULL,''),
('160','0','31','19','entity','','0','0',NULL,''),
('161','162','33','19','entity_menu','','0','0',NULL,''),
('162','0','21','19','parent','','0','0',NULL,''),
('164','165','31','20','entity_menu','','0','0',NULL,''),
('165','0','21','20','parent','','0','0',NULL,''),
('166','0','31','20','entity','','0','0',NULL,''),
('167','168','32','20','entity_menu','','0','0',NULL,''),
('168','0','21','20','parent','','0','0',NULL,''),
('169','170','33','20','entity_menu','','0','0',NULL,''),
('170','0','21','20','parent','','0','0',NULL,''),
('171','0','32','20','entity','','0','0',NULL,''),
('172','0','32','19','entity','','0','0',NULL,''),
('173','0','33','19','entity','','0','0',NULL,''),
('174','175','31','27','entity_menu','','0','0',NULL,''),
('175','0','21','27','parent','','0','0',NULL,''),
('176','0','33','20','entity','','0','0',NULL,''),
('177','178','31','22','entity_menu','','0','0',NULL,''),
('178','0','21','22','parent','','0','0',NULL,''),
('179','180','32','22','entity_menu','','0','0',NULL,''),
('180','0','21','22','parent','','0','0',NULL,''),
('181','182','33','22','entity_menu','','0','0',NULL,''),
('182','0','21','22','parent','','0','0',NULL,''),
('183','0','33','22','entity','','0','0',NULL,''),
('184','0','32','22','entity','','0','0',NULL,''),
('185','0','31','22','entity','','0','0',NULL,'');

CREATE TABLE `app_reports_filters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reports_id` int(11) NOT NULL,
  `fields_id` int(11) NOT NULL,
  `filters_values` text NOT NULL,
  `filters_condition` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_reports_id` (`reports_id`),
  KEY `idx_fields_id` (`fields_id`)
) ENGINE=MyISAM AUTO_INCREMENT=142 DEFAULT CHARSET=utf8;

INSERT INTO app_reports_filters VALUES
('140','77','157','41','exclude'),
('74','68','157','37,38,39','include'),
('122','127','169','46,47,48','include'),
('76','70','169','46,47,48','include'),
('77','72','169','46,47,48','include'),
('78','75','157','37,38,39','include'),
('79','78','171','20','include'),
('80','79','157','37,38,39','include'),
('141','78','169','50,52','exclude'),
('83','83','157','37,38,39','include'),
('84','84','169','46,47,48','include'),
('85','87','169','46,47,48','include'),
('86','89','157','37,38,39','include'),
('87','90','169','46,47,48','include'),
('88','94','169','46,47,48','include'),
('89','96','157','37,38,39','include'),
('90','97','169','46,47,48','include'),
('95','102','169','46,47,48','include'),
('94','99','171','22','include'),
('96','104','157','37,38,39','include'),
('97','104','196','','include'),
('98','105','169','46,47,48','include'),
('99','108','169','46,47,48','include'),
('100','109','157','37,38,39','include'),
('101','109','196','','include'),
('102','110','169','46,47,48','include'),
('103','113','171','25','include'),
('120','125','155','24','include'),
('106','115','155','24','include'),
('107','116','161','24','include'),
('108','116','155','24','exclude'),
('109','117','169','47','include'),
('110','117','171','24','include'),
('139','59','157','41','exclude'),
('119','124','169','69,70','include'),
('123','130','171','21','include'),
('124','133','165','0,,','include'),
('126','140','169','46,47,48','include');

CREATE TABLE `app_sessions` (
  `sesskey` varchar(32) NOT NULL,
  `expiry` int(11) unsigned NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`sesskey`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO app_sessions VALUES
('e72b142649baaf4d05acb3e3447465d9','1453113600','uploadify_attachments|a:1:{i:261;a:0:{}}alerts|O:6:\"alerts\":1:{s:8:\"messages\";a:0:{}}app_send_to|N;app_current_version|s:3:\"1.6\";app_selected_items|a:1:{i:75;a:0:{}}app_logged_users_id|s:2:\"19\";'),
('ae040c13d8a3cb575e21bcc747546184','1453113963','uploadify_attachments|a:0:{}alerts|O:6:\"alerts\":1:{s:8:\"messages\";a:0:{}}app_send_to|N;app_selected_items|a:1:{i:75;a:0:{}}app_current_version|s:3:\"1.6\";app_logged_users_id|s:2:\"19\";'),
('f0deefb713b560df386d541934cdbef6','1453113668','uploadify_attachments|a:2:{i:261;a:3:{i:0;s:52:\"1453109784_ВОР-СС-ЛС-02-02-08_связь.xlsx\";i:1;s:46:\"1453109784_9118-91-0215-1030_от_21.12.15.pdf\";i:2;s:55:\"1453109784_ВОР-СС-ЛС-06-01-06.01_связь.xlsx\";}s:11:\"attachments\";a:0:{}}alerts|O:6:\"alerts\":1:{s:8:\"messages\";a:0:{}}app_send_to|a:0:{}app_logged_users_id|s:2:\"22\";app_current_version|s:3:\"1.6\";app_selected_items|a:1:{i:179;a:0:{}}');

CREATE TABLE `app_users_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) NOT NULL,
  `configuration_name` varchar(255) NOT NULL DEFAULT '',
  `configuration_value` text,
  PRIMARY KEY (`id`),
  KEY `idx_users_id` (`users_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO app_users_configuration VALUES
('1','20','sidebar-pos-option',NULL),
('2','20','sidebar-option',NULL),
('3','20','page-scale-option','page-scale-reduced');

