--PRY2205_S7 
--PRY2205.semana_7


-- CON USUARIO ADMIN
GRANT CREATE SYNONYM TO PRY2205_S7;
GRANT CREATE VIEW TO PRY2205_S7;

SELECT * FROM NLS_SESSION_PARAMETERS;
--NLS_DATE_FORMAT = DD-MON-RR

ALTER SESSION SET NLS_TERRITORY = 'CHILE';
ALTER SESSION SET NLS_LANGUAGE = 'SPANISH';
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/RRRR';


CREATE SEQUENCE seq_cat;
CREATE SEQUENCE seq_com START WITH 80;
CREATE SEQUENCE seq_porc_com_annos;
CREATE SEQUENCE SEQ_DET_BONIF START WITH 100  INCREMENT BY 10;


CREATE TABLE AFP
(cod_afp NUMBER(2) CONSTRAINT PK_AFP PRIMARY KEY,
 nombre_afp  VARCHAR2(30) NOT NULL,
 porc_descto_afp NUMBER(2) NOT NULL);

CREATE TABLE isapre
(cod_ISAPRE NUMBER(2) CONSTRAINT PK_ISAPRE PRIMARY KEY,
 nombre_ISAPRE  VARCHAR2(30) NOT NULL,
 porc_descto_ISAPRE NUMBER(2) NOT NULL);


CREATE TABLE COMUNA_CIUDAD
(id_CIUDAD NUMBER(3) NOT NULL,
 nombre_CIUDAD VARCHAR2(30) NOT NULL,
 CONSTRAINT pk_CIUDAD PRIMARY KEY (id_CIUDAD));

CREATE TABLE TIPO_TRABAJADOR 
(id_categoria    NUMBER(1) NOT NULL,
 desc_categoria  VARCHAR2(30) NOT NULL,
 CONSTRAINT pk_TIPO_TRAB  PRIMARY KEY (id_categoria ));

CREATE TABLE estado_civil
(id_estcivil      NUMBER(1) NOT NULL,
 desc_Estcivil    Varchar2(25) Not Null,
 CONSTRAINT pk_estado_civil_ PRIMARY KEY(id_estcivil));

CREATE TABLE BONO_ESCOLAR
(id_escolar  NUMBER(2) NOT NULL,
 sigla   VARCHAR2(6) NOT NULL,
 descrip VARCHAR2(50) NOT NULL,
 porc_bono NUMBER(2),
 CONSTRAINT pk_escolaridad PRIMARY KEY (id_escolar));
 
CREATE TABLE TRABAJADOR 
(numrut      NUMBER(10) NOT NULL,
 dvrut       VARCHAR2(1) NOT NULL,
 appaterno   VARCHAR2(20) NOT NULL,
 apmaterno   VARCHAR2(20) NOT NULL,
 nombre      VARCHAR2(25) NOT NULL,
 direccion   varchar2(35) not null,
 fonofijo    VARCHAR2(15) NOT NULL,
 fecnac DATE,
 fecing DATE  NOT NULL,
 sueldo_base  NUMBER(7) NOT NULL,
 id_ciudad NUMBER(3),
 id_categoria_t  NUMBER(1),
 id_escolaridad_t  NUMBER(2) NOT NULL,
 cod_afp  NUMBER(2) NOT NULL,
 cod_ISAPRE NUMBER(2) NOT NULL,
 CONSTRAINT PK_TRABAJADOR  PRIMARY KEY (numrut ),
 CONSTRAINT FK_trabajador_CIUDAD FOREIGN KEY (id_CIUDAD) REFERENCES COMUNA_CIUDAD (id_CIUDAD),
 CONSTRAINT  FK_trabajador_AFP FOREIGN KEY (cod_afp) REFERENCES afp (cod_afp),
 CONSTRAINT FK_trabajador_ISAPRE FOREIGN KEY (cod_isapre) REFERENCES ISAPRE (cod_isapre),
 CONSTRAINT FK_trabajador_ESCOLARIDAD FOREIGN KEY(id_escolaridad_t) REFERENCES BONO_ESCOLAR(id_escolar),
 CONSTRAINT FK_trabajador_TIPO_T FOREIGN KEY (id_categoria_t) REFERENCES TIPO_TRABAJADOR  (id_categoria));

CREATE TABLE ASIGNACION_FAMILIAR 
(numrut_carga  NUMBER(10) NOT NULL CONSTRAINT PK_ASG_FAMILIAR PRIMARY KEY,
 dvrut_carga  VARCHAR2(1) NOT NULL,
 appaterno_carga VARCHAR2(15) NOT NULL,
 apmaterno_carga VARCHAR2(15) NOT NULL,
 nombre_carga VARCHAR2(25) NOT NULL,
 numrut_t NUMBER(10) NOT NULL,
 CONSTRAINT FK_ASGN_FAMILIAR_T FOREIGN KEY(numrut_t) REFERENCES  TRABAJADOR ( numrut )); 

CREATE TABLE  DETALLE_BONIFICACIONES_TRABAJADOR (
    NUM NUMBER(10) CONSTRAINT PK_DET_BONT PRIMARY KEY,
    RUT VARCHAR2(20 BYTE), 
	 NOMBRE_TRABAJADOR     VARCHAR2(70 BYTE), 
	 SUELDO_BASE  NUMBER(7) NOT NULL  , 
	 NUM_TICKET             VARCHAR2(12) NOT NULL , 
	 DIRECCION              VARCHAR2(50)  NOT NULL,
	 SISTEMA_SALUD          VARCHAR2(30) NOT NULL,
	 MONTO                  NUMBER(8) NOT NULL, 
	 BONIF_X_TICKET         NUMBER(8) NOT NULL, 
	 SIMULACION_X_TICKET    NUMBER(8) NOT NULL, 
	 SIMULACION_ANTIGUEDAD  NUMBER(8) NOT NULL
);

CREATE TABLE  TICKETS_CONCIERTO
(nro_ticket NUMBER(10)  PRIMARY KEY , 
 fecha_ticket DATE  NOT NULL , 
 monto_ticket NUMBER(15)  NOT NULL , 
 id_cliente NUMBER(10) NOT NULL,
 numrut_t NUMBER(10) NOT NULL,
 CONSTRAINT FK_FTRABAJADOR  FOREIGN KEY(numrut_t) REFERENCES  TRABAJADOR( numrut )); 

CREATE TABLE BONO_ANTIGUEDAD
(id NUMBER(2) CONSTRAINT PK_ANNOS_TRABAJADOS PRIMARY KEY,
 limite_inferior     NUMBER(2) NOT NULL,
 limite_superior     NUMBER(2) NOT NULL,
 porcentaje         NUMBER(3,2) NOT NULL);

CREATE TABLE  COMISIONES_TICKET  
(nro_ticket NUMBER(10) NOT NULL   PRIMARY KEY ,
 valor_comision  NUMBER(10) NOT NULL,
 CONSTRAINT FK_VTA_ticket FOREIGN KEY(nro_ticket) REFERENCES TICKETS_CONCIERTO (nro_ticket));

CREATE TABLE EST_CIVIL
(numrut_t NUMBER(10) NOT NULL,
 id_estcivil_est NUMBER(1) NOT NULL,
 fecini_estcivil DATE NOT NULL,
 fecter_estcivil DATE,
 CONSTRAINT PK_EST_CIVIL PRIMARY KEY(numrut_t, id_estcivil_est  ),
 CONSTRAINT FK_EST_CIVIL_TRAB    FOREIGN KEY(numrut_t) REFERENCES   TRABAJADOR( numrut ),
 CONSTRAINT FK_CIVIL_ESTCIV    FOREIGN KEY   ( id_estcivil_est ) REFERENCES   ESTADO_CIVIL ( id_estcivil )
); 



-- insercion de datos
INSERT INTO AFP VALUES(1,'MODELO',9);
INSERT INTO AFP VALUES(2,'PLANVITAL',15);
INSERT INTO AFP VALUES(3,'CAPITAL',11);
INSERT INTO AFP VALUES(4,'CUPRUM',12);
INSERT INTO AFP VALUES(5,'PROVIDA',11);
INSERT INTO AFP VALUES(6,'HABITAT',15);

-- insercion de datos
INSERT INTO ISAPRE VALUES(1,'FONASA',5);
INSERT INTO ISAPRE VALUES(2,'BAN MEDICA',10);
INSERT INTO ISAPRE VALUES(3,'COLMENA',8);
INSERT INTO ISAPRE VALUES(4,'Fundacion',12);
INSERT INTO ISAPRE VALUES(5,'CRUZ BLANCA',12);
INSERT INTO ISAPRE VALUES(6,'MAS VIDA',6);
INSERT INTO ISAPRE VALUES(7,'VIDA TRES',11);

INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Las Condes');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Providencia');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Santiago');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'nunoa');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Vitacura');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'La Reina');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'La Florida');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Maipu');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Lo Barnechea');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Macul');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'San Miguel');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Penalolen');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Puente Alto');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Recoleta');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Estacion Central');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'San Bernardo');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Independencia');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'La Cisterna');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Quilicura');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Quinta Normal');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Conchali');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'San Joaquin');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Huechuraba');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'El Bosque');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Cerrillos');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Cerro Navia');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'La Granja');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'La Pintana');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Lo Espejo');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Lo Prado');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Pedro Aguirre Cerda');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Pudahuel');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Renca');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'San Ramon');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Melipilla');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'San Pedro');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Alhue');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Maria Pinto');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Curacavi');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Talagante');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'El Monte');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Buin');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Paine');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Penaflor');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Isla de Maipo');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Colina');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Pirque');

INSERT INTO TIPO_TRABAJADOR VALUES (seq_cat.NEXTVAL,'VENDEDOR HONORARIOS');
INSERT INTO TIPO_TRABAJADOR VALUES (seq_cat.NEXTVAL,'PLANTA');
INSERT INTO TIPO_TRABAJADOR VALUES (seq_cat.NEXTVAL,'CAJERO');
INSERT INTO TIPO_TRABAJADOR VALUES (seq_cat.NEXTVAL,'CONTRATO PLAZO FIJO');

INSERT INTO estado_civil VALUES(1,'Soltero');
INSERT INTO estado_civil VALUES(2,'Casado');
INSERT INTO estado_civil VALUES(3,'Separado');
INSERT INTO estado_civil VALUES(4,'Divorciado');
INSERT INTO estado_civil VALUES(5,'Viudo');

INSERT INTO BONO_ESCOLAR VALUES(10,'BA','BaSICA',1);
INSERT INTO BONO_ESCOLAR VALUES(20,'MCH','MEDIA CIENTiFICA HUMANISTA',2);
INSERT INTO BONO_ESCOLAR VALUES(30,'MTP','MEDIA TeCNICO PROFESIONAL',3);
INSERT INTO BONO_ESCOLAR VALUES(40,'SCFT','SUPERIOR CENTRO DE FORMACIoN TeCNICA',4);
INSERT INTO BONO_ESCOLAR VALUES(50,'SIP','SUPERIOR INSTITUTO PROFESIONAL',5);
INSERT INTO BONO_ESCOLAR VALUES(60,'SUO','SUPERIOR UNIVERSIDAD',6);

INSERT INTO TRABAJADOR VALUES (11649964,'0','GALVEZ','CASTRO','MARTA','CLOVIS MONTERO 0260 D/202','23417556','20121971','01071996',1515239,80,1,10,1,1);
INSERT INTO TRABAJADOR VALUES (12113369,'4','ROMERO','DIAZ','NANCY','TENIENTE RAMON JIMENEZ 4753','25631567','09011968','01081991',2710153,81,3,20,2,1);
INSERT INTO TRABAJADOR VALUES (12456905,'1','CANALES','BASTIAS','JORGE','GENERAL CONCHA PEDREGAL #885','27413395','21121957','01091983',2945675,81,3,20,2,1);
INSERT INTO TRABAJADOR VALUES (12466553,'2','VIDAL','PEREZ','TERESA','FCO. DE CAMARGO 14515 D/14','28122603','01081996','01081994',1202614,82,3,10,3,7);
INSERT INTO TRABAJADOR VALUES (11745244,'3','VENEGAS','SOTO','KARINA','ARICA 3850','27494190','01081988','01081994',1439042,83,3,60,4,7);
INSERT INTO TRABAJADOR VALUES (11999100,'4','CONTRERAS','CASTILLO','CLAUDIO','ISABEL RIQUELME 6075','27764142','24121966','01081994',364163,84,4,30,6,6);
INSERT INTO TRABAJADOR VALUES (12888868,'5','PAEZ','MACMILLAN','JOSE','FERNANDEZ CONCHA 500','22399493','25121964','01031991',1896155,85,3,30,5,7);
INSERT INTO TRABAJADOR VALUES (12811094,'6','MOLINA','GONZALEZ','PAULA','PJE.TIMBAL 1095 V/POMAIRE','25313830','26121978','01042017',1757577,86,3,60,3,5);
INSERT INTO TRABAJADOR VALUES (14255602,'7','MUnOZ','ROJAS','CARLOTA','TERCEIRA 7426 V/LIBERTAD','26490093','01052006','01081994',2658577,87,2,50,4,4);
INSERT INTO TRABAJADOR VALUES (11630572,'8','ARAVENA','HERBAGE','GUSTAVO','FERNANDO DE ARAGON 8420','25588481',NULL,'01072001',1957095,88,3,40,1,1);
INSERT INTO TRABAJADOR VALUES (11636534,'9','ADASME','ZUnIGA','LUIS','LITTLE ROCK 117 V/PDTE.KENNEDY','26483081','29121973','01061996',1614934,89,3,50,6,7);
INSERT INTO TRABAJADOR VALUES (12272880,'K','LAPAZ','SEPULVEDA','MARCO','GUARDIA MARINA. RIQUELME 561','26038967','30121989','01072016',1352596,92,3,40,5,1);
INSERT INTO TRABAJADOR VALUES (11846972,'5','OGAZ','VARAS','MARCO','OVALLE N5798 V/ OHIGGINS','27763209','31121959','01022017',253590,94,4,50,6,4);
INSERT INTO TRABAJADOR VALUES (14283083,'6','MONDACA','COLLAO','AUGUSTO','NUEVA COLON N1152','27357104','01011989','01092013',1144245,95,2,50,3,6);
INSERT INTO TRABAJADOR VALUES (14541837,'7','ALVAREZ','RIVERA','MARCO','HONDURAS B/8908 D/102 L.BRISAS','22875902','02011977','01101996',1541418,97,3,20,4,7);
INSERT INTO TRABAJADOR VALUES (12482036,'8','OLAVE','CASTILLO','ADRIAN','ELISA CORREA 188','22888897','03011956','01111986',1068086,98,3,20,1,1);
INSERT INTO TRABAJADOR VALUES (12468081,'9','SANCHEZ','GONZALEZ','PAOLA','AV.OSSA 01240 V/MI VInITA','25273328','04011987','01082012',1330355,99,3,60,4,1);
INSERT INTO TRABAJADOR VALUES (12260812,'0','RIOS','ZUnIGA','RAFAEL','LOS CASTAnOS 1427 VILLA C.C.U.','26410462','05011991','01032013',367056,106,4,50,4,3);
INSERT INTO TRABAJADOR VALUES (12899759,'1','CACERES','JIMENEZ','ERIKA','PJE.NAVARINO 15758 V/P.DE OnA','28593881','06011974','01121994',2281415,107,3,40,4,5);
INSERT INTO TRABAJADOR VALUES (12868553,'2','CHACON','AMAYA','PATRICIA','LO ERRAZURIZ 530 V/EL SENDERO','25577963','07011985','01012006',1723055,108,3,10,1,2);
INSERT INTO TRABAJADOR VALUES (12648200,'3','NARVAEZ','MUnOZ','LUIS','AMBRIOSO OHIGGINS  2010','27742268','08011993','01032017',1966613,80,3,60,2,1);
INSERT INTO TRABAJADOR VALUES (11670042,'5','GONGORA','DEVIA','VALESKA','PASAJE VENUS 2765','23244270','10011975','01091998',1635086,82,3,30,1,1);
INSERT INTO TRABAJADOR VALUES (12642309,'K','NAVARRO','SANTIBAnEZ','JUAN','SANTA ELENA 300 V/LOS ALAMOS','25342599','11011986','02092011',1659230,83,3,30,6,7);

INSERT INTO EST_CIVIL VALUES (11649964,1,'01071996','31052016');
INSERT INTO EST_CIVIL VALUES (11649964,2,'01062016',NULL);
INSERT INTO EST_CIVIL VALUES (12113369,4,'01081991','05062018');
INSERT INTO EST_CIVIL VALUES (12113369,2,'06062018',NULL);
INSERT INTO EST_CIVIL VALUES (12456905,2,'01091983',NULL);
INSERT INTO EST_CIVIL VALUES (12466553,3,'01081996',NULL);
INSERT INTO EST_CIVIL VALUES (11745244,1,'01081988',NULL);
INSERT INTO EST_CIVIL VALUES (11999100,2,'01081994',NULL);
INSERT INTO EST_CIVIL VALUES (12888868,3,'01031991',NULL);
INSERT INTO EST_CIVIL VALUES (12811094,4,'01042018',NULL);
INSERT INTO EST_CIVIL VALUES (14255602,1,'01052006',NULL);
INSERT INTO EST_CIVIL VALUES (11630572,3,'01072001',NULL);
INSERT INTO EST_CIVIL VALUES (11636534,1,'01061996','02062018');
INSERT INTO EST_CIVIL VALUES (11636534,2,'03062018',NULL);
INSERT INTO EST_CIVIL VALUES (12272880,2,'01072016',NULL);
INSERT INTO EST_CIVIL VALUES (11846972,3,'01042018',NULL);
INSERT INTO EST_CIVIL VALUES (14283083,4,'01092013',NULL);
INSERT INTO EST_CIVIL VALUES (14541837,1,'01101996','15062018');
INSERT INTO EST_CIVIL VALUES (14541837,2,'16062018',NULL);
INSERT INTO EST_CIVIL VALUES (12482036,2,'01111986',NULL);
INSERT INTO EST_CIVIL VALUES (12468081,3,'01082012',NULL);
INSERT INTO EST_CIVIL VALUES (12260812,4,'01032013',NULL);
INSERT INTO EST_CIVIL VALUES (12899759,1,'01121994',NULL);
INSERT INTO EST_CIVIL VALUES (12868553,2,'01012006',NULL);
INSERT INTO EST_CIVIL VALUES (12648200,3,'01032017',NULL);
INSERT INTO EST_CIVIL VALUES (11670042,1,'01091998','06062018');
INSERT INTO EST_CIVIL VALUES (11670042,2,'07062018',NULL);
INSERT INTO EST_CIVIL VALUES (12642309,2,'02092011',NULL);

INSERT INTO ASIGNACION_FAMILIAR VALUES(20639521,'0','ARAVENA','RIQUELME','Jorge',11630572);
INSERT INTO ASIGNACION_FAMILIAR VALUES(19074837,'1','ARAVENA','RIQUELME','CESAR',11630572);
INSERT INTO ASIGNACION_FAMILIAR VALUES(22251882,'2','ARAVENA','DONOSO','CLAUDIO',11630572);
INSERT INTO ASIGNACION_FAMILIAR VALUES(17238830,'3','RIOS','CAVERO','Pedro',12260812);
INSERT INTO ASIGNACION_FAMILIAR VALUES(18777063,'4','RIOS','CAVERO','PABLO',12260812);
INSERT INTO ASIGNACION_FAMILIAR VALUES(22467572,'5','TRONCOSO','ROMERO','CLAUDIO',12113369);
INSERT INTO ASIGNACION_FAMILIAR VALUES(20487147,'9','SOTO','MUnOZ','MARTINA',14255602);

INSERT INTO BONO_ANTIGUEDAD VALUES(seq_porc_com_annos.NEXTVAL,2,8,0.05);
INSERT INTO BONO_ANTIGUEDAD VALUES(seq_porc_com_annos.NEXTVAL,10,15,0.06);
INSERT INTO BONO_ANTIGUEDAD VALUES(seq_porc_com_annos.NEXTVAL,16,19,0.08);
INSERT INTO BONO_ANTIGUEDAD VALUES(seq_porc_com_annos.NEXTVAL,20,30,0.10);


INSERT INTO TICKETS_CONCIERTO  VALUES(1,'21/04' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE))   ,134560,1000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(2,'13/04' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,125000,2000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(3,'21/04' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,138560,1000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(4,'21/04' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,157893,2000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(5,'05/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,160000,3000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(6,'16/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,1258000,3000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(7,'16/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,158000,3000, 12642309);
INSERT INTO TICKETS_CONCIERTO  VALUES(8,'16/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,18000,3000, 11670042);
INSERT INTO TICKETS_CONCIERTO  VALUES(9,'17/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,28000,3000, 12648200);
INSERT INTO TICKETS_CONCIERTO  VALUES(10,'25/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,234560,1000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(11,'26/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,257893,2000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(12,'01/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,14560,1000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(13,'01/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,257893,2000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(14,'05/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,260000,3000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(15,'16/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,358000,3000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(16,'16/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,155000,3000, 12642309);
INSERT INTO TICKETS_CONCIERTO  VALUES(17,'16/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,125800,3000, 11670042);
INSERT INTO TICKETS_CONCIERTO  VALUES(18,'17/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,155800,3000, 12648200);
INSERT INTO TICKETS_CONCIERTO  VALUES(19,'21/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,234560,1000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(20,'21/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,145793,2000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(21,'21/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,34560,1000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(22,'22/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,45793,2000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(23,'22/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,160000,3000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(24,'23/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,75800,3000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(25,'23/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,35800,3000, 12642309);
INSERT INTO TICKETS_CONCIERTO  VALUES(26,'16/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,55800,3000, 11670042);
INSERT INTO TICKETS_CONCIERTO  VALUES(27,'23/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,55800,3000, 12648200); 


INSERT INTO  COMISIONES_TICKET   VALUES(1, 540);
INSERT INTO  COMISIONES_TICKET   VALUES(2,786);
INSERT INTO  COMISIONES_TICKET   VALUES(3,618);
INSERT INTO  COMISIONES_TICKET   VALUES(4,7868);
INSERT INTO  COMISIONES_TICKET   VALUES(5,8500);
INSERT INTO  COMISIONES_TICKET   VALUES(6,9370);
INSERT INTO  COMISIONES_TICKET   VALUES(7,8370);
INSERT INTO  COMISIONES_TICKET   VALUES(8,3700);
INSERT INTO  COMISIONES_TICKET   VALUES(9,8700);
INSERT INTO  COMISIONES_TICKET   VALUES(10, 184);
INSERT INTO  COMISIONES_TICKET   VALUES(11,6868);
INSERT INTO  COMISIONES_TICKET   VALUES(12,514);
INSERT INTO  COMISIONES_TICKET   VALUES(13,6864);
INSERT INTO  COMISIONES_TICKET   VALUES(14,9000);
INSERT INTO  COMISIONES_TICKET   VALUES(15,730);
INSERT INTO  COMISIONES_TICKET   VALUES(16,9300);
INSERT INTO  COMISIONES_TICKET   VALUES(17,430);
INSERT INTO  COMISIONES_TICKET   VALUES(18,7300);
INSERT INTO  COMISIONES_TICKET   VALUES(19, 1514);
INSERT INTO  COMISIONES_TICKET   VALUES(20,6464);
INSERT INTO  COMISIONES_TICKET   VALUES(21,514);
INSERT INTO  COMISIONES_TICKET   VALUES(22,6864);
INSERT INTO  COMISIONES_TICKET   VALUES(23,9000);
INSERT INTO  COMISIONES_TICKET   VALUES(24,6370);
INSERT INTO  COMISIONES_TICKET   VALUES(25,9970);
INSERT INTO  COMISIONES_TICKET   VALUES(26,18370);
INSERT INTO  COMISIONES_TICKET   VALUES(27,4370);

COMMIT;

CREATE SYNONYM SYN_TRABAJADOR FOR TRABAJADOR;
CREATE SYNONYM SYN_BONO FOR BONO_ANTIGUEDAD;
CREATE SYNONYM SYN_TICKETS FOR TICKETS_CONCIERTO;



-- Simular las mejoras en las remuneraciones, para poder proyectar los presupuestos necesarios para cubrir los aumentos, 
-- antes de aplicarlos realmente.

-- El objetivo de este primer proceso de cálculo es determinar los montos simulados 
-- por concepto de tickets vendidos y compararlos con la bonificación por antigüedad, según los requisitos detallados por el área de Finanzas.

-- Reglas para la simulación de la bonificación por ticket (bonif_x_ticket):
        -- Si el monto del ticket es inferior o igual a $50.000, no se aplica bonificación.
        -- Si el monto del ticket es mayor a $50.000 y hasta $100.000, se aplica una bonificación simulada del 5% sobre el monto.
        -- Si el monto del ticket es mayor a $100.000, se aplica una bonificación del 7%.
-- La simulación del sueldo por venta ticket se obtiene sumando el sueldo base más la bonificación por ticket.


-- La simulación por antigüedad laboral se obtendrá: 
        -- Incrementando el sueldo base, es decir, el sueldo multiplicado 
        -- por el porcentaje obtenido desde la tabla BONO_ANTIGUEDAD (ver Figura 2), comparando los años laborales de cada trabajador 
        -- con el límite inferior y superior.
        
        -- (Se sugiere calcular la antigüedad laboral del empleado comparando fecha actual y la fecha
        -- de ingreso (fecing), usando la función: MONTHS_BETWEEN).

        -- Por ejemplo, si el trabajador Luis Narváez ha permanecido por 8 años en “SpaceLive”, según
        --la tabla de parámetros le corresponderá un aumento del 5% aplicable a su sueldo base.
        --(Por ej. 1966613 * 1.05 = 2064944). En este caso, no usar CASE con datos fijos, sino que un NonEquiJoin

        -- Filtros: 
        -- Se deberá considerar en esta simulación a todos los trabajadores, aunque no hayan vendido tickets, 
        -- pero que sí tengan un descuento asociado a su plan de salud superior al 4% y que tengan menos de 50 años. 
        
-- Para mejorar el acceso y la seguridad de las tablas debes utilizar sinónimos privados de las siguientes tablas: 
-- TRABAJADOR, BONO_ANTIGUEDAD, TICKETS_CONCIERTO.

-- El informe final deberá presentarse en el formato mostrado en la Imagen 2, y posteriormente
-- debes insertar esa información en la tabla DETALLE_BONIFICACIONES_TRABAJADOR (INSERT usando secuencia) 
-- incluyendo la información de los trabajadores: RUT concatenado con el DV, nombre y apellidos, sueldo base, 
-- ticket asociado (si lo posee; en caso contrario, se debe indicar "No hay info"), dirección, sistema de salud del trabajador, 
-- monto del ticket vendido, simulación de la bonificación asociada a cada ticket, la simulación
-- del sueldo aumentado por concepto de antigüedad laboral.

--SIMULACION POR VENTA DE TICKET

--DESAFIO 1
-- CONSULTA DATOS SIMULACION
SELECT
    t.numrut || '-' || UPPER(t.dvrut) RUT
    , INITCAP(t.nombre || ' ' || t.appaterno || ' ' || t.apmaterno ) NOMBRE_TRABAJADOR
    , t.sueldo_base SUELDO_BASE
    , NVL(TO_CHAR(tc.nro_ticket), 'No hay info') NUM_TICKET
    , INITCAP(t.direccion) DIRECCION
    , UPPER(i.nombre_isapre) SISTEMA_SALUD
    , NVL(tc.monto_ticket, 0) MONTO
    , NVL (
        CASE
        WHEN tc.monto_ticket <= 50000 THEN 0
        WHEN (tc.monto_ticket > 50000) AND (tc.monto_ticket <= 100000) THEN ROUND(tc.monto_ticket * 0.05)
        ELSE tc.monto_ticket * 0.07
        END, 0
    ) BONIF_X_TICKET
    , CASE
        WHEN NVL(tc.monto_ticket, 0) <= 50000 THEN t.sueldo_base
        WHEN tc.monto_ticket > 50000 AND tc.monto_ticket <= 100000 THEN ROUND(tc.monto_ticket * 0.05) + t.sueldo_base
        ELSE ROUND(tc.monto_ticket * 0.07) + t.sueldo_base
        END SIMULACION_X_TICKET
    , t.sueldo_base + ROUND(t.sueldo_base * ba.porcentaje) SIMULACION_ANTIGUEDAD
FROM
    syn_trabajador t  
    LEFT JOIN syn_tickets tc ON t.numrut = tc.numrut_t 
    INNER JOIN Isapre i ON t.cod_isapre = i.cod_isapre
    INNER JOIN syn_bono ba ON ROUND(MONTHS_BETWEEN(SYSDATE, t.fecing) / 12, 0) BETWEEN ba.limite_inferior AND ba.limite_superior
WHERE
    ROUND( (SYSDATE - t.fecnac) / 365.25) < 50 AND i.porc_descto_isapre > 4
ORDER BY 
    MONTO DESC;
    

-- INSERCION DATOS SIMULACION CON SECUENCIA
-- LA SECUENCIA QUE VENIA DECLARADA EN EL SCRIPT (SEQ_DET_BONIF) ENTREGO UN RESULTADO NO ESPERADO EMPEZÓ LA SECUENCIA EN EL NUMERO 220 
-- DECLARE UNA NUEVA SECUENCIA
CREATE SEQUENCE SEQ_SIMULACION_BONIF START WITH 100  INCREMENT BY 10;

INSERT INTO DETALLE_BONIFICACIONES_TRABAJADOR (NUM, RUT, NOMBRE_TRABAJADOR, SUELDO_BASE, NUM_TICKET, DIRECCION, SISTEMA_SALUD, MONTO, BONIF_X_TICKET, SIMULACION_X_TICKET, SIMULACION_ANTIGUEDAD)
    SELECT
        SEQ_SIMULACION_BONIF.NEXTVAL
        ,t.numrut || '-' || UPPER(t.dvrut)
        , INITCAP(t.nombre || ' ' || t.appaterno || ' ' || t.apmaterno )
        , t.sueldo_base
        , NVL(TO_CHAR(tc.nro_ticket), 'No hay info')
        , INITCAP(t.direccion)
        , UPPER(i.nombre_isapre)
        , NVL(tc.monto_ticket, 0)
        , NVL (
            CASE
            WHEN tc.monto_ticket <= 50000 THEN 0
            WHEN (tc.monto_ticket > 50000) AND (tc.monto_ticket <= 100000) THEN ROUND(tc.monto_ticket * 0.05)
            ELSE tc.monto_ticket * 0.07
            END, 0
        )
        , CASE
            WHEN NVL(tc.monto_ticket, 0) <= 50000 THEN t.sueldo_base
            WHEN tc.monto_ticket > 50000 AND tc.monto_ticket <= 100000 THEN ROUND(tc.monto_ticket * 0.05) + t.sueldo_base
            ELSE ROUND(tc.monto_ticket * 0.07) + t.sueldo_base
            END
        , t.sueldo_base + ROUND(t.sueldo_base * ba.porcentaje)
        
    FROM
        syn_trabajador t  
        LEFT JOIN syn_tickets tc ON t.numrut = tc.numrut_t 
        LEFT JOIN Isapre i ON t.cod_isapre = i.cod_isapre
        LEFT JOIN syn_bono ba ON ROUND(MONTHS_BETWEEN(SYSDATE, t.fecing) / 12, 0) BETWEEN ba.limite_inferior AND ba.limite_superior      
    WHERE
        ROUND( (SYSDATE - t.fecnac) / 365.25) < 50 AND i.porc_descto_isapre > 4;
        
COMMIT;

SELECT * FROM DETALLE_BONIFICACIONES_TRABAJADOR ORDER BY MONTO DESC;




--DESAFIO 2
-- Para este segundo requerimiento, debes realizar una consulta compleja a partir de los datos
-- de los trabajadores y sus respectivos niveles de estudios. En particular debes calcular una
-- simulación de aumento salarial considerando el porcentaje que se encuentra en la tabla de
--parámetros BONO_ESCOLAR de la Figura 4


-- CREAR SINONIMOS
CREATE SYNONYM SYN_ASIGNACION FOR ASIGNACION_FAMILIAR;
CREATE SYNONYM SYN_TIPO FOR TIPO_TRABAJADOR;


-- CONSULTA PARA CREAR VISTA
CREATE OR REPLACE VIEW V_AUMENTOS_ESTUDIOS
    AS 
        SELECT 
            TO_CHAR( SUBSTR(t.numrut, 1, LENGTH(t.numrut) - 6) )|| '.' ||
            TO_CHAR( SUBSTR(t.numrut, LENGTH(t.numrut) - 5, 3 ) ) || '.' ||
            TO_CHAR( SUBSTR(t.numrut, LENGTH(t.numrut) - 2, 3 ) ) || '-' || t.dvrut RUT_TRABAJADOR
            , INITCAP(t.nombre || ' ' || t.appaterno || ' ' || t.apmaterno ) NOMBRE_TRABAJADOR
            , UPPER(be.descrip) NIVEL_EDUCACION
            , LPAD(be.porc_bono, 7, 0) PCT_ESTUDIOS
            , t.sueldo_base SUELDO_ACTUAL
            , ROUND((be.porc_bono / 100) * t.sueldo_base, 0 ) AUMENTO
            , TO_CHAR(t.sueldo_base + ROUND((be.porc_bono / 100) * t.sueldo_base, 0 ), '$99G999G999') SUELDO_AUMENTADO
                
        FROM syn_trabajador t
            LEFT JOIN syn_tipo tt ON t.id_categoria_t = tt.id_categoria
            INNER JOIN Bono_Escolar be ON t.id_escolaridad_t = be.id_escolar
        WHERE tt.desc_categoria = 'CAJERO'
            OR (SELECT COUNT(*) 
                 FROM syn_asignacion a 
                 WHERE a.numrut_t = t.numrut) BETWEEN 1 AND 2
        ORDER BY 
            PCT_ESTUDIOS;

SELECT * FROM v_aumentos_estudios;



-- DESAFIO 3
-- Para mejorar el rendimiento de tus procesos, debes analizar el problema y crear 2 índices según 
-- las conclusiones que saques del análisis del plan de ejecución de la siguiente consulta:

SELECT numrut, fecnac, t.nombre, appaterno, t.apmaterno
FROM Trabajador t JOIN Isapre i ON t.cod_isapre = i.cod_isapre
WHERE UPPER(t.apmaterno) = 'CASTILLO'
ORDER BY 3;

-- PROFE: Aca creé  los indices pero no funcionaron. Sé que agregar el rut
-- no es necesario porque es PK y ya se indexa la tabla por ese valor, pero pensé que al crear
-- un indice compuesto podría de alguna forma cambiar el comportamiento, pero no funcionó
CREATE INDEX IDX_TRABAJADOR_APM_RUT ON Trabajador(apmaterno, numrut);
CREATE INDEX IDX_TRABAJADOR_APM ON Trabajador(UPPER(apmaterno));
--DROP INDEX IDX_TRABAJADOR_APM;

-- Tambien trate de usar algo como una consulta, donde queriá especificar el apellido,
-- pero SQL Developer reclama por la sintaxis en el WHERE
--CREATE INDEX idx_trabajador_apm 
--ON Trabajador (UPPER(apmaterno))
--WHERE UPPER(apmaterno) = 'CASTILLO';

COMMIT;




