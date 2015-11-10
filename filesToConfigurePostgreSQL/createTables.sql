-- Some informations
--    D is abbreviation of Dimension
--    F is abbreviation of Fact
--
-- To more informations search by datawarehouse structure...

CREATE TABLE IF NOT EXISTS D_Class (
  idClass serial primary key,
  class_name varchar(200) DEFAULT NULL,
  hashcode varchar(45) DEFAULT NULL
);


CREATE TABLE IF NOT EXISTS D_Configuration (
  idConfiguration serial primary key,
  configuration_name varchar(45) DEFAULT NULL,
  software_reference_name varchar(45) DEFAULT NULL,
  language_name varchar(45) DEFAULT NULL,
  software_repository_address varchar(45) DEFAULT NULL
);

--
-- Data dump to table D_Configuration
--

INSERT INTO D_Configuration (configuration_name, software_reference_name,
    language_name, software_repository_address)
VALUES
('Open JDK8 Metrics', 'Open JDK8', 'java', 'http://hg.openjdk.java.net/jdk8'),
('Tomcat Metrics', 'Tomcat', 'java', 'git://git.apache.org/tomcat70.git');


CREATE TABLE IF NOT EXISTS D_Metric (
  idMetric serial primary key,
  metric_abbreviation varchar(45) DEFAULT NULL,
  metric_name varchar(45) DEFAULT NULL,
  metric_category varchar(45) DEFAULT NULL
);

--
-- Data dump to table D_Metric
--

INSERT INTO D_Metric (metric_abbreviation,
  metric_name, metric_category)
VALUES
('LOC', 'Lines of Code', 'Source Code Metric'),
('ACCM', 'Average Cyclomatic Complexity per Method', 'Source Code Metric'),
('AMLOC', 'Average Method Lines of Code', 'Source Code Metric'),
('ACC', 'Afferent Connections per Class', 'Source Code Metric'),
('ANPM', 'Average Number of Parameters per Method', 'Source Code Metric'),
('CBO', 'Coupling Between Objects', 'Source Code Metric'),
('DIT', 'Depth of Inheritance Tree', 'Source Code Metric'),
('LCOM4', 'Lack of Cohesion in Methods', 'Source Code Metric'),
('NOC', 'Number of Children', 'Source Code Metric'),
('NOM', 'Number of Methods', 'Source Code Metric'),
('NPA', 'Number of Public Attributes', 'Source Code Metric'),
('RFC', 'Response for Class', 'Source Code Metric');


CREATE TABLE IF NOT EXISTS D_Project (
  idProject serial primary key,
  project_abbreviation varchar(45) DEFAULT NULL,
  project_name varchar(45) DEFAULT NULL,
  project_language varchar(45) DEFAULT NULL,
  organization_owner varchar(45) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS D_Quality (
  idQuality serial primary key,
  quality_index varchar(45) DEFAULT NULL
);

--
-- Data dump to table D_Quality
--

INSERT INTO D_Quality (idQuality, quality_index)
VALUES
(1, 'Great'),
(2, 'Good'),
(3, 'Regular'),
(4, 'Bad');

CREATE TABLE IF NOT EXISTS D_Release (
  idRelease serial primary key,
  release_name varchar(45) DEFAULT NULL,
  release_number int DEFAULT NULL
);


CREATE TABLE IF NOT EXISTS D_Scenario_Clean_Code (
  idScenario serial primary key,
  scenario_name varchar(255) DEFAULT NULL,
  recomendations varchar(255) DEFAULT NULL
);

--
-- Data dump to table D_Scenario_Clean_Code
--

INSERT INTO D_Scenario_Clean_Code (scenario_name, recomendations)
VALUES
  ('Classe Pouco Coesa', 'Reduzir a Subdivisão da Classe');

INSERT INTO D_Scenario_Clean_Code (scenario_name, recomendations)
VALUES
  ('Interface dos Métodos', 'Minimizar o número de parâmetros');

INSERT INTO D_Scenario_Clean_Code (scenario_name, recomendations)
VALUES
  ('Classes com muitos filhos', 'Trocar Herança por Agregação');

INSERT INTO D_Scenario_Clean_Code(scenario_name, recomendations)
VALUES
  ('Classe com métodos grandes e/ou muitos condicionais', 'Quebrar os Métodos');

INSERT INTO D_Scenario_Clean_Code(scenario_name, recomendations)
VALUES
  ('Classe com muita Exposição ', 'Reduzir o número de pârametros públicos');

INSERT INTO D_Scenario_Clean_Code(scenario_name, recomendations)
VALUES
  ('Complexidade Estrutural', 'Reduzir a quantidade de responsabilidades da Classe');

-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS D_Time (
  idTime serial primary key,
  Month smallint DEFAULT 0,
  Year smallint DEFAULT 0
);

--
-- Fact tables
--

CREATE TABLE IF NOT EXISTS F_Project_Metric (
  idQuality serial primary key,
  percentil_value decimal DEFAULT NULL,
  D_Project_idProject integer NOT NULL
    references D_Project(idProject) ON DELETE NO ACTION ON UPDATE NO ACTION,
  D_Metric_idMetric integer NOT NULL
    references D_Metric(idMetric) ON DELETE NO ACTION ON UPDATE NO ACTION,
  D_Quality_idQuality integer NOT NULL
    references D_Quality(idQuality) ON DELETE NO ACTION ON UPDATE NO ACTION,
  D_Configuration_idConfiguration integer NOT NULL
    references D_Configuration(idConfiguration) ON DELETE NO ACTION ON UPDATE NO ACTION,
  D_Release_idRelease integer NOT NULL
    references D_Release(idRelease) ON DELETE NO ACTION ON UPDATE NO ACTION,
  D_Time_idTime integer NOT NULL
    references D_Time(idTime) ON DELETE NO ACTION ON UPDATE NO ACTION
);



CREATE TABLE IF NOT EXISTS F_Rate_Scenario (
  idRateScenario serial primary key,
  RateScenario decimal DEFAULT NULL,
  numberOfClasses integer DEFAULT NULL,
  Quantiy_Scenarios decimal DEFAULT NULL,
  D_Release_idRelease integer NOT NULL UNIQUE
    references D_Release(idRelease) ON DELETE NO ACTION ON UPDATE NO ACTION,
  D_Project_idProject integer NOT NULL
    references D_Project(idProject) ON DELETE NO ACTION ON UPDATE NO ACTION
);



CREATE TABLE IF NOT EXISTS F_Scenario_Class (
  idScenarioFact serial primary key,
  quantity_Scenario integer DEFAULT NULL,
  D_Scenario_Clean_Code_idScenario integer NOT NULL
    references D_Scenario_Clean_Code(idScenario) ON DELETE NO ACTION ON UPDATE NO ACTION,
  D_Project_idProject integer NOT NULL
    references D_Project(idProject) ON DELETE NO ACTION ON UPDATE NO ACTION,
  D_Release_idRelease integer NOT NULL
    references D_Release(idRelease) ON DELETE NO ACTION ON UPDATE NO ACTION,
  D_Class_idClass integer NOT NULL
    references D_Class(idClass)  ON DELETE NO ACTION ON UPDATE NO ACTION
);



--
-- Structure of Meta_Metric_Ranges
--

CREATE TABLE IF NOT EXISTS Meta_Metric_Ranges (
  idMetricRange serial primary key,
  metric_name varchar(45) DEFAULT NULL,
  description varchar(45) DEFAULT NULL,
  min decimal DEFAULT NULL,
  max decimal DEFAULT NULL,
  language_name varchar(45) DEFAULT NULL,
  quality_index varchar(45) DEFAULT NULL,
  configuration_name varchar(45) DEFAULT NULL
);
--
-- Data dump to table Meta_Metric_Ranges
--

INSERT INTO Meta_Metric_Ranges (metric_name, description,
    min, max, language_name, quality_index, configuration_name)
VALUES
('LOC', 'Lines of Code', 0, 33, 'java', 'Excelente', 'Open JDK8 Metrics'),
('LOC', 'Lines of Code', 34, 87, 'java', 'Bom', 'Open JDK8 Metrics'),
('LOC', 'Lines of Code', 88, 200, 'java', 'Regular', 'Open JDK8 Metrics'),
('LOC', 'Lines of Code', 200, 4294967295, 'java', 'Ruim', 'Open JDK8 Metrics'),
('LOC', 'Lines of Code', 0, 33, 'java', 'Excelente', 'Tomcat Metrics'),
('LOC', 'Lines of Code', 34, 105, 'java', 'Bom', 'Tomcat Metrics'),
('LOC', 'Lines of Code', 106, 276, 'java', 'Regular', 'Tomcat Metrics'),
('LOC', 'Lines of Code', 276, 4294967295, 'java', 'Ruim', 'Tomcat Metrics'),
('ACCM', 'Average Cyclomatic Complexity per Method', 0, 2.8, 'java', 'Excelente', 'Open JDK8 Metrics'),
('ACCM', 'Average Cyclomatic Complexity per Method', 2.9, 4.4, 'java', 'Bom', 'Open JDK8 Metrics'),
('ACCM', 'Average Cyclomatic Complexity per Method', 4.5, 6, 'java', 'Regular', 'Open JDK8 Metrics'),
('ACCM', 'Average Cyclomatic Complexity per Method', 6.1, 4294967295, 'java', 'Ruim', 'Open JDK8 Metrics'),
('ACCM', 'Average Cyclomatic Complexity per Method', 0, 3.1, 'java', 'Excelente', 'Tomcat Metrics'),
('ACCM', 'Average Cyclomatic Complexity per Method', 3.1, 4, 'java', 'Bom', 'Tomcat Metrics'),
('ACCM', 'Average Cyclomatic Complexity per Method', 4.1, 6, 'java', 'Regular', 'Tomcat Metrics'),
('ACCM', 'Average Cyclomatic Complexity per Method', 6.1, 4294967295, 'java', 'Ruim', 'Tomcat Metrics'),
('AMLOC', 'Average Method Lines of Code', 0, 8.3, 'java', 'Excelente', 'Open JDK8 Metrics'),
('AMLOC', 'Average Method Lines of Code', 8.4, 18, 'java', 'Bom', 'Open JDK8 Metrics'),
('AMLOC', 'Average Method Lines of Code', 19, 34, 'java', 'Regular', 'Open JDK8 Metrics'),
('AMLOC', 'Average Method Lines of Code', 35, 4294967295, 'java', 'Ruim', 'Open JDK8 Metrics'),
('AMLOC', 'Average Method Lines of Code', 0, 8, 'java', 'Excelente', 'Tomcat Metrics'),
('AMLOC', 'Average Method Lines of Code', 8.1, 16, 'java', 'Bom', 'Tomcat Metrics'),
('AMLOC', 'Average Method Lines of Code', 16.1, 27, 'java', 'Regular', 'Tomcat Metrics'),
('AMLOC', 'Average Method Lines of Code', 27, 4294967295, 'java', 'Ruim', 'Tomcat Metrics'),
('ACC', 'Afferent Connections per Class', 0, 1, 'java', 'Excelente', 'Open JDK8 Metrics'),
('ACC', 'Afferent Connections per Class', 1.1, 5, 'java', 'Bom', 'Open JDK8 Metrics'),
('ACC', 'Afferent Connections per Class', 5.1, 12, 'java', 'Regular', 'Open JDK8 Metrics'),
('ACC', 'Afferent Connections per Class', 12.1, 4294967295, 'java', 'Ruim', 'Open JDK8 Metrics'),
('ACC', 'Afferent Connections per Class', 0, 1, 'java', 'Excelente', 'Tomcat Metrics'),
('ACC', 'Afferent Connections per Class', 1.1, 5, 'java', 'Bom', 'Tomcat Metrics'),
('ACC', 'Afferent Connections per Class', 5.1, 13, 'java', 'Regular', 'Tomcat Metrics'),
('ACC', 'Afferent Connections per Class', 13.1, 4294967295, 'java', 'Ruim', 'Tomcat Metrics'),
('ANPM', 'Average Number of Parameters per Method', 0, 1.5, 'java', 'Excelente', 'Open JDK8 Metrics'),
('ANPM', 'Average Number of Parameters per Method', 1.6, 2.3, 'java', 'Bom', 'Open JDK8 Metrics'),
('ANPM', 'Average Number of Parameters per Method', 2.4, 3, 'java', 'Regular', 'Open JDK8 Metrics'),
('ANPM', 'Average Number of Parameters per Method', 3.1, 4294967295, 'java', 'Ruim', 'Open JDK8 Metrics'),
('ANPM', 'Average Number of Parameters per Method', 0, 2, 'java', 'Excelente', 'Tomcat Metrics'),
('ANPM', 'Average Number of Parameters per Method', 2.1, 3, 'java', 'Bom', 'Tomcat Metrics'),
('ANPM', 'Average Number of Parameters per Method', 3.1, 5, 'java', 'Regular', 'Tomcat Metrics'),
('ANPM', 'Average Number of Parameters per Method', 5.1, 4294967295, 'java', 'Ruim', 'Tomcat Metrics'),
('CBO', 'Coupling Between Objects', 0, 3, 'java', 'Excelente', 'Open JDK8 Metrics'),
('CBO', 'Coupling Between Objects', 4, 6, 'java', 'Bom', 'Open JDK8 Metrics'),
('CBO', 'Coupling Between Objects', 7, 9, 'java', 'Regular', 'Open JDK8 Metrics'),
('CBO', 'Coupling Between Objects', 10, 4294967295, 'java', 'Ruim', 'Open JDK8 Metrics'),
('CBO', 'Coupling Between Objects', 0, 2, 'java', 'Excelente', 'Tomcat Metrics'),
('CBO', 'Coupling Between Objects', 3, 5, 'java', 'Bom', 'Tomcat Metrics'),
('CBO', 'Coupling Between Objects', 5, 7, 'java', 'Regular', 'Tomcat Metrics'),
('CBO', 'Coupling Between Objects', 8, 4294967295, 'java', 'Ruim', 'Tomcat Metrics'),
('DIT', 'Depth of Inheritance Tree', 0, 2, 'java', 'Excelente', 'Open JDK8 Metrics'),
('DIT', 'Depth of Inheritance Tree', 3, 4, 'java', 'Bom', 'Open JDK8 Metrics'),
('DIT', 'Depth of Inheritance Tree', 5, 6, 'java', 'Regular', 'Open JDK8 Metrics'),
('DIT', 'Depth of Inheritance Tree', 7, 4294967295, 'java', 'Ruim', 'Open JDK8 Metrics'),
('DIT', 'Depth of Inheritance Tree', 0, 1, 'java', 'Excelente', 'Tomcat Metrics'),
('DIT', 'Depth of Inheritance Tree', 2, 3, 'java', 'Bom', 'Tomcat Metrics'),
('DIT', 'Depth of Inheritance Tree', 4, 4, 'java', 'Regular', 'Tomcat Metrics'),
('DIT', 'Depth of Inheritance Tree', 5, 4294967295, 'java', 'Ruim', 'Tomcat Metrics'),
('LCOM4', 'Lack of Cohesion in Methods', 0, 3, 'java', 'Excelente', 'Open JDK8 Metrics'),
('LCOM4', 'Lack of Cohesion in Methods', 4, 7, 'java', 'Bom', 'Open JDK8 Metrics'),
('LCOM4', 'Lack of Cohesion in Methods', 8, 12, 'java', 'Regular', 'Open JDK8 Metrics'),
('LCOM4', 'Lack of Cohesion in Methods', 13, 4294967295, 'java', 'Ruim', 'Open JDK8 Metrics'),
('LCOM4', 'Lack of Cohesion in Methods', 0, 3, 'java', 'Excelente', 'Tomcat Metrics'),
('LCOM4', 'Lack of Cohesion in Methods', 4, 7, 'java', 'Bom', 'Tomcat Metrics'),
('LCOM4', 'Lack of Cohesion in Methods', 8, 11, 'java', 'Regular', 'Tomcat Metrics'),
('LCOM4', 'Lack of Cohesion in Methods', 12, 4294967295, 'java', 'Ruim', 'Tomcat Metrics'),
('NOC', 'Number of Children', 0, 0, 'java', 'Excelente', 'Open JDK8 Metrics'),
('NOC', 'Number of Children', 1, 2, 'java', 'Bom', 'Open JDK8 Metrics'),
('NOC', 'Number of Children', 3, 3, 'java', 'Regular', 'Open JDK8 Metrics'),
('NOC', 'Number of Children', 4, 4294967295, 'java', 'Ruim', 'Open JDK8 Metrics'),
('NOC', 'Number of Children', 0, 0, 'java', 'Excelente', 'Tomcat Metrics'),
('NOC', 'Number of Children', 1, 2, 'java', 'Bom', 'Tomcat Metrics'),
('NOC', 'Number of Children', 3, 3, 'java', 'Regular', 'Tomcat Metrics'),
('NOC', 'Number of Children', 4, 4294967295, 'java', 'Ruim', 'Tomcat Metrics'),
('NOM', 'Number of Methods', 0, 8, 'java', 'Excelente', 'Open JDK8 Metrics'),
('NOM', 'Number of Methods', 9, 17, 'java', 'Bom', 'Open JDK8 Metrics'),
('NOM', 'Number of Methods', 18, 27, 'java', 'Regular', 'Open JDK8 Metrics'),
('NOM', 'Number of Methods', 28, 4294967295, 'java', 'Ruim', 'Open JDK8 Metrics'),
('NOM', 'Number of Methods', 0, 10, 'java', 'Excelente', 'Tomcat Metrics'),
('NOM', 'Number of Methods', 11, 21, 'java', 'Bom', 'Tomcat Metrics'),
('NOM', 'Number of Methods', 22, 35, 'java', 'Regular', 'Tomcat Metrics'),
('NOM', 'Number of Methods', 36, 4294967295, 'java', 'Ruim', 'Tomcat Metrics'),
('NPA', 'Number of Public Attributes', 0, 0, 'java', 'Excelente', 'Open JDK8 Metrics'),
('NPA', 'Number of Public Attributes', 1, 1, 'java', 'Bom', 'Open JDK8 Metrics'),
('NPA', 'Number of Public Attributes', 2, 3, 'java', 'Regular', 'Open JDK8 Metrics'),
('NPA', 'Number of Public Attributes', 4, 4294967295, 'java', 'Ruim', 'Open JDK8 Metrics'),
('NPA', 'Number of Public Attributes', 0, 0, 'java', 'Excelente', 'Tomcat Metrics'),
('NPA', 'Number of Public Attributes', 1, 1, 'java', 'Bom', 'Tomcat Metrics'),
('NPA', 'Number of Public Attributes', 2, 3, 'java', 'Regular', 'Tomcat Metrics'),
('NPA', 'Number of Public Attributes', 4, 4294967295, 'java', 'Ruim', 'Tomcat Metrics'),
('RFC', 'Response for Class', 0, 9, 'java', 'Excelente', 'Open JDK8 Metrics'),
('RFC', 'Response for Class', 10, 26, 'java', 'Bom', 'Open JDK8 Metrics'),
('RFC', 'Response for Class', 27, 59, 'java', 'Regular', 'Open JDK8 Metrics'),
('RFC', 'Response for Class', 60, 4294967295, 'java', 'Ruim', 'Open JDK8 Metrics'),
('RFC', 'Response for Class', 0, 11, 'java', 'Excelente', 'Tomcat Metrics'),
('RFC', 'Response for Class', 12, 30, 'java', 'Bom', 'Tomcat Metrics'),
('RFC', 'Response for Class', 31, 74, 'java', 'Regular', 'Tomcat Metrics'),
('RFC', 'Response for Class', 75, 4294967295, 'java', 'Ruim', 'Tomcat Metrics');

--
-- Structure of `Meta_Scenario`
--

CREATE TABLE IF NOT EXISTS Meta_Scenario (
  idMeta_Scenario serial primary key,
  name_meta_scenario varchar(255) DEFAULT NULL
);


--
-- Fazendo dump de dados para tabela Meta_Scenario
--

INSERT INTO Meta_Scenario (name_meta_scenario) VALUES
('Classe Pouco Coesa'),
('Interface dos Métodos'),
('Classes com muitos filhos'),
('Classe com métodos grandes e/ou muitos condic'),
('Classe com muita Exposição '),
('Complexidade Estrutural');

----------------------------------------------------

CREATE TABLE IF NOT EXISTS Meta_Metric_Ranges_Meta_Scenario (
  idMeta_Scenario_Ranges serial primary key,
  Meta_Scenario_idMeta_Scenario integer DEFAULT NULL
    references Meta_Scenario(idMeta_Scenario),
  Meta_Metric_Ranges_idMetricRange1 integer DEFAULT NULL
    references Meta_Metric_Ranges (idMetricRange) ON DELETE NO ACTION ON UPDATE NO ACTION,
  Meta_Metric_Ranges_idMetricRange2 integer DEFAULT NULL
    references Meta_Metric_Ranges (idMetricRange) ON DELETE NO ACTION ON UPDATE NO ACTION
);

--
--  Data dump to Meta_Metric_Ranges_Meta_Scenario
--

INSERT INTO Meta_Metric_Ranges_Meta_Scenario (idMeta_Scenario_Ranges, Meta_Scenario_idMeta_Scenario,
   Meta_Metric_Ranges_idMetricRange1, Meta_Metric_Ranges_idMetricRange2) VALUES
(1, 1, 59, 91),
(2, 1, 59, 92),
(3, 1, 60, 91),
(4, 1, 60, 92),
(5, 2, 35, NULL),
(6, 2, 36, NULL),
(7, 3, 67, NULL),
(8, 3, 68, NULL),
(9, 4, 11, 19),
(10, 4, 11, 20),
(11, 4, 12, 19),
(12, 4, 12, 20),
(13, 5, 83, NULL),
(14, 5, 84, NULL),
(15, 6, 43, 59),
(16, 6, 43, 60),
(17, 6, 44, 59),
(18, 6, 44, 60);

-- --------------------------------------------------------
