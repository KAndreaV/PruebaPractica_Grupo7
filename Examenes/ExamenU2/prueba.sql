-- =========================================================
-- DDL
-- =========================================================

CREATE USER HOTEL IDENTIFIED BY HOTEL
  DEFAULT TABLESPACE USERS
  TEMPORARY TABLESPACE TEMP
  QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION TO HOTEL;
GRANT CREATE TABLE TO HOTEL;
GRANT CREATE VIEW TO HOTEL;
GRANT CREATE SEQUENCE TO HOTEL;
GRANT CREATE SYNONYM TO HOTEL;
GRANT RESOURCE, CONNECT TO HOTEL;



-- 1. TABLA Empresa
CREATE TABLE EMPRESA (
    ID_EMP VARCHAR2(10) PRIMARY KEY,
    NOM_EMP VARCHAR2(100),
    RAZ_SOC_EMP VARCHAR2(100),
    CIU_EMP VARCHAR2(50)
);

-- 2. TABLA Hotel
CREATE TABLE HOTEL (
    ID_HOT VARCHAR2(10) PRIMARY KEY,
    NOM_HOT VARCHAR2(100),
    CIU_HOT VARCHAR2(50),
    DIR_HOT VARCHAR2(150)
);

-- 3. TABLA Ejecutivo
CREATE TABLE EJECUTIVO (
    ID_EJE VARCHAR2(10) PRIMARY KEY,
    ID_EMP VARCHAR2(10),
    ID_SUP_EJE VARCHAR2(10), -- Mantenido como FK según tu dibujo
    NOM_EJE VARCHAR2(50),
    APE_EJE VARCHAR2(50),
    FEC_NAC_EJE DATE,
    SUE_EJE NUMBER(10, 2),
    CAR_EJE VARCHAR2(50),
    CONSTRAINT FK_EJE_EMP FOREIGN KEY (ID_EMP) REFERENCES EMPRESA(ID_EMP),
    CONSTRAINT FK_EJE_SUP FOREIGN KEY (ID_SUP_EJE) REFERENCES EJECUTIVO(ID_EJE)
);

-- 4. TABLA Recepcionista
CREATE TABLE RECEPCIONISTA (
    ID_REC VARCHAR2(10) PRIMARY KEY,
    ID_HOT VARCHAR2(10),
    NOM_REC VARCHAR2(50),
    APE_REC VARCHAR2(50),
    SUE_REC NUMBER(10, 2),
    TUR_REC VARCHAR2(20),
    CONSTRAINT FK_REC_HOT FOREIGN KEY (ID_HOT) REFERENCES HOTEL(ID_HOT)
);

-- 5. TABLA Habitación
CREATE TABLE HABITACION (
    ID_HAB VARCHAR2(10) PRIMARY KEY,
    ID_HOT VARCHAR2(10),
    TIP_HAB VARCHAR2(30),
    COS_HAB NUMBER(10, 2),
    EST_HAB VARCHAR2(20),
    CONSTRAINT FK_HAB_HOT FOREIGN KEY (ID_HOT) REFERENCES HOTEL(ID_HOT)
);

-- 6. TABLA Hospedaje
CREATE TABLE HOSPEDAJE (
    ID_HOS VARCHAR2(10) PRIMARY KEY,
    ID_EJE VARCHAR2(10),
    ID_HAB VARCHAR2(10),
    ID_REC VARCHAR2(10),
    FEC_ING_HOS DATE,
    FEC_SAL_HOS DATE,
    COS_TOT_HOS NUMBER(10, 2),
    CONSTRAINT FK_HOS_EJE FOREIGN KEY (ID_EJE) REFERENCES EJECUTIVO(ID_EJE),
    CONSTRAINT FK_HOS_HAB FOREIGN KEY (ID_HAB) REFERENCES HABITACION(ID_HAB),
    CONSTRAINT FK_HOS_REC FOREIGN KEY (ID_REC) REFERENCES RECEPCIONISTA(ID_REC)
);

-- 7. TABLA Novedad
CREATE TABLE NOVEDAD (
    ID_NOV VARCHAR2(10) PRIMARY KEY,
    ID_HOS VARCHAR2(10),
    TIP_NOV VARCHAR2(50),
    DES_NOV VARCHAR2(250),
    FEC_INC_NOV DATE,
    COS_REP_NOV NUMBER(10, 2),
    CONSTRAINT FK_NOV_HOS FOREIGN KEY (ID_HOS) REFERENCES HOSPEDAJE(ID_HOS)
);

-- =========================================================
-- DML
-- =========================================================

INSERT INTO EMPRESA (ID_EMP, NOM_EMP, RAZ_SOC_EMP, CIU_EMP) VALUES ('EMP01', 'TURISMO NACIONAL', 'EMPRESA PUBLICA TURISTICA', 'QUITO');
INSERT INTO EMPRESA (ID_EMP, NOM_EMP, RAZ_SOC_EMP, CIU_EMP) VALUES ('EMP02', 'HOTEL ANDINO', 'HOTELES PRIVADOS ANDINOS', 'GUAYAQUIL');
INSERT INTO EMPRESA (ID_EMP, NOM_EMP, RAZ_SOC_EMP, CIU_EMP) VALUES ('EMP03', 'SERVIHOTEL', 'SERVICIOS HOTELEROS DEL PACIFICO', 'CUENCA');

INSERT INTO HOTEL (ID_HOT, NOM_HOT, CIU_HOT, DIR_HOT) VALUES ('H01', 'COLON', 'QUITO', 'AV. COLON Y 10 DE AGOSTO');
INSERT INTO HOTEL (ID_HOT, NOM_HOT, CIU_HOT, DIR_HOT) VALUES ('H02', 'ANDES', 'GUAYAQUIL', 'AV. LAS TORRES 123');
INSERT INTO HOTEL (ID_HOT, NOM_HOT, CIU_HOT, DIR_HOT) VALUES ('H03', 'PACIFICO', 'CUENCA', 'AV. SOLANO 456');

INSERT INTO EJECUTIVO (ID_EJE, ID_EMP, ID_SUP_EJE, NOM_EJE, APE_EJE, FEC_NAC_EJE, SUE_EJE, CAR_EJE) VALUES ('E01', 'EMP01', NULL, 'JUAN', 'PEREZ', TO_DATE('1980-02-12', 'YYYY-MM-DD'), 3500, 'DIRECTOR');
INSERT INTO EJECUTIVO (ID_EJE, ID_EMP, ID_SUP_EJE, NOM_EJE, APE_EJE, FEC_NAC_EJE, SUE_EJE, CAR_EJE) VALUES ('E02', 'EMP01', 'E01', 'LUIS', 'TORRES', TO_DATE('1988-08-18', 'YYYY-MM-DD'), 2800, 'GERENTE');
INSERT INTO EJECUTIVO (ID_EJE, ID_EMP, ID_SUP_EJE, NOM_EJE, APE_EJE, FEC_NAC_EJE, SUE_EJE, CAR_EJE) VALUES ('E03', 'EMP02', 'E01', 'MARIO', 'GOMEZ', TO_DATE('1991-04-05', 'YYYY-MM-DD'), 2400, 'SUPERVISOR');
INSERT INTO EJECUTIVO (ID_EJE, ID_EMP, ID_SUP_EJE, NOM_EJE, APE_EJE, FEC_NAC_EJE, SUE_EJE, CAR_EJE) VALUES ('E04', 'EMP02', 'E03', 'ANA', 'MENA', TO_DATE('1993-11-30', 'YYYY-MM-DD'), 2200, 'ANALISTA');
INSERT INTO EJECUTIVO (ID_EJE, ID_EMP, ID_SUP_EJE, NOM_EJE, APE_EJE, FEC_NAC_EJE, SUE_EJE, CAR_EJE) VALUES ('E05', 'EMP03', 'E02', 'SOFIA', 'LEON', TO_DATE('1986-06-14', 'YYYY-MM-DD'), 2600, 'JEFE');

INSERT INTO RECEPCIONISTA (ID_REC, ID_HOT, NOM_REC, APE_REC, SUE_REC, TUR_REC) VALUES ('R01', 'H01', 'MARTA', 'RUIZ', 900, 'MATUTINO');
INSERT INTO RECEPCIONISTA (ID_REC, ID_HOT, NOM_REC, APE_REC, SUE_REC, TUR_REC) VALUES ('R02', 'H01', 'CARLOS', 'VEGA', 950, 'VESPERTINO');
INSERT INTO RECEPCIONISTA (ID_REC, ID_HOT, NOM_REC, APE_REC, SUE_REC, TUR_REC) VALUES ('R03', 'H02', 'ELENA', 'TORRES', 980, 'NOCTURNO');
INSERT INTO RECEPCIONISTA (ID_REC, ID_HOT, NOM_REC, APE_REC, SUE_REC, TUR_REC) VALUES ('R04', 'H03', 'DIEGO', 'MENA', 920, 'MATUTINO');

INSERT INTO HABITACION (ID_HAB, ID_HOT, TIP_HAB, COS_HAB, EST_HAB) VALUES ('01A', 'H01', 'SUITE', 150, 'DISPONIBLE');
INSERT INTO HABITACION (ID_HAB, ID_HOT, TIP_HAB, COS_HAB, EST_HAB) VALUES ('02B', 'H01', 'MATRIMONIAL', 120, 'OCUPADA');
INSERT INTO HABITACION (ID_HAB, ID_HOT, TIP_HAB, COS_HAB, EST_HAB) VALUES ('03C', 'H01', 'SIMPLE', 80, 'DISPONIBLE');
INSERT INTO HABITACION (ID_HAB, ID_HOT, TIP_HAB, COS_HAB, EST_HAB) VALUES ('08F', 'H02', 'MATRIMONIAL', 110, 'OCUPADA');
INSERT INTO HABITACION (ID_HAB, ID_HOT, TIP_HAB, COS_HAB, EST_HAB) VALUES ('12X', 'H03', 'SUITE', 200, 'DISPONIBLE');

INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS01', 'E02', '02B', 'R01', TO_DATE('2026-01-03', 'YYYY-MM-DD'), TO_DATE('2026-01-05', 'YYYY-MM-DD'), 240);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS02', 'E01', '01A', 'R02', TO_DATE('2026-01-15', 'YYYY-MM-DD'), TO_DATE('2026-01-20', 'YYYY-MM-DD'), 600);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS03', 'E01', '01A', 'R02', TO_DATE('2026-02-03', 'YYYY-MM-DD'), TO_DATE('2026-02-08', 'YYYY-MM-DD'), 700);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS04', 'E02', '01A', 'R02', TO_DATE('2026-02-10', 'YYYY-MM-DD'), TO_DATE('2026-02-12', 'YYYY-MM-DD'), 500);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS05', 'E01', '01A', 'R02', TO_DATE('2026-03-05', 'YYYY-MM-DD'), TO_DATE('2026-03-20', 'YYYY-MM-DD'), 650);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS06', 'E03', '08F', 'R03', TO_DATE('2026-03-10', 'YYYY-MM-DD'), TO_DATE('2026-03-15', 'YYYY-MM-DD'), 350);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS07', 'E04', '08F', 'R03', TO_DATE('2026-03-15', 'YYYY-MM-DD'), TO_DATE('2026-03-20', 'YYYY-MM-DD'), 400);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS08', 'E01', '12X', 'R04', TO_DATE('2026-04-02', 'YYYY-MM-DD'), TO_DATE('2026-04-10', 'YYYY-MM-DD'), 800);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS09', 'E01', '12X', 'R04', TO_DATE('2026-04-12', 'YYYY-MM-DD'), TO_DATE('2026-04-18', 'YYYY-MM-DD'), 500);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS10', 'E01', '08F', 'R03', TO_DATE('2026-04-20', 'YYYY-MM-DD'), TO_DATE('2026-04-25', 'YYYY-MM-DD'), 450);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS11', 'E02', '12X', 'R04', TO_DATE('2026-04-05', 'YYYY-MM-DD'), TO_DATE('2026-04-08', 'YYYY-MM-DD'), 300);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS12', 'E02', '12X', 'R04', TO_DATE('2026-04-15', 'YYYY-MM-DD'), TO_DATE('2026-04-17', 'YYYY-MM-DD'), 250);

INSERT INTO NOVEDAD (ID_NOV, ID_HOS, TIP_NOV, DES_NOV, FEC_INC_NOV, COS_REP_NOV) VALUES ('NV01', 'HS06', 'DANO', 'DANO EN MINIBAR', TO_DATE('2026-03-11', 'YYYY-MM-DD'), 40);
INSERT INTO NOVEDAD (ID_NOV, ID_HOS, TIP_NOV, DES_NOV, FEC_INC_NOV, COS_REP_NOV) VALUES ('NV02', 'HS06', 'LIMPIEZA', 'FALTA DE LIMPIEZA', TO_DATE('2026-03-12', 'YYYY-MM-DD'), 20);
INSERT INTO NOVEDAD (ID_NOV, ID_HOS, TIP_NOV, DES_NOV, FEC_INC_NOV, COS_REP_NOV) VALUES ('NV03', 'HS07', 'DANO', 'DANO EN CORTINA', TO_DATE('2026-03-16', 'YYYY-MM-DD'), 35);
INSERT INTO NOVEDAD (ID_NOV, ID_HOS, TIP_NOV, DES_NOV, FEC_INC_NOV, COS_REP_NOV) VALUES ('NV04', 'HS10', 'DANO', 'DANO EN TELEVISION', TO_DATE('2026-04-21', 'YYYY-MM-DD'), 60);
INSERT INTO NOVEDAD (ID_NOV, ID_HOS, TIP_NOV, DES_NOV, FEC_INC_NOV, COS_REP_NOV) VALUES ('NV05', 'HS10', 'REPOSICION', 'REPOSICION DE CONTROL', TO_DATE('2026-04-22', 'YYYY-MM-DD'), 25);
INSERT INTO NOVEDAD (ID_NOV, ID_HOS, TIP_NOV, DES_NOV, FEC_INC_NOV, COS_REP_NOV) VALUES ('NV06', 'HS02', 'DANO', 'DANO EN LLAVE', TO_DATE('2026-01-16', 'YYYY-MM-DD'), 15);
INSERT INTO NOVEDAD (ID_NOV, ID_HOS, TIP_NOV, DES_NOV, FEC_INC_NOV, COS_REP_NOV) VALUES ('NV07', 'HS05', 'REPOSICION', 'REPOSICION DE SABANAS', TO_DATE('2026-03-10', 'YYYY-MM-DD'), 18);
INSERT INTO NOVEDAD (ID_NOV, ID_HOS, TIP_NOV, DES_NOV, FEC_INC_NOV, COS_REP_NOV) VALUES ('NV08', 'HS08', 'DANO', 'DANO EN TELEVISION', TO_DATE('2026-04-08', 'YYYY-MM-DD'), 55);
INSERT INTO HOTEL (ID_HOT, NOM_HOT, CIU_HOT, DIR_HOT) VALUES ('H04', 'MARRIOT', 'QUITO', 'AV. ELOY ALFARO 789');
INSERT INTO EJECUTIVO (ID_EJE, ID_EMP, ID_SUP_EJE, NOM_EJE, APE_EJE, FEC_NAC_EJE, SUE_EJE, CAR_EJE) VALUES ('1815', 'EMP03', 'E05', 'RAUL', 'SANTOS', TO_DATE('1987-09-21', 'YYYY-MM-DD'), 2100, 'COORDINADOR');
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS13', '1815', '02B', 'R02', TO_DATE('2026-05-01', 'YYYY-MM-DD'), TO_DATE('2026-05-03', 'YYYY-MM-DD'), 260);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS14', '1815', '12X', 'R04', TO_DATE('2026-05-04', 'YYYY-MM-DD'), TO_DATE('2026-05-06', 'YYYY-MM-DD'), 320);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS15', 'E03', '02B', 'R02', TO_DATE('2026-05-01', 'YYYY-MM-DD'), TO_DATE('2026-05-02', 'YYYY-MM-DD'), 280);
INSERT INTO HOSPEDAJE (ID_HOS, ID_EJE, ID_HAB, ID_REC, FEC_ING_HOS, FEC_SAL_HOS, COS_TOT_HOS) VALUES ('HS16', 'E02', '02B', 'R02', TO_DATE('2026-05-01', 'YYYY-MM-DD'), TO_DATE('2026-05-04', 'YYYY-MM-DD'), 300);

-- =========================================================
-- CONSULTAS AVANZADAS DEL GRUPO G
-- =========================================================

-- 37. Mostrar el nombre y apellido del ejecutivo cuyo supervisor pertenece a la misma empresa
-- y que registró el mayor costo acumulado de hospedajes durante 2026.
SELECT e.nom_eje, e.ape_eje
FROM ejecutivo e
WHERE e.id_sup_eje IS NOT NULL
  AND EXISTS (
        SELECT 1
        FROM ejecutivo s
        WHERE s.id_eje = e.id_sup_eje
          AND s.id_emp = e.id_emp
    )
  AND (
        SELECT SUM(h.cos_tot_hos)
        FROM hospedaje h
        WHERE h.id_eje = e.id_eje
          AND h.fec_ing_hos >= TO_DATE('2026-01-01', 'YYYY-MM-DD')
          AND h.fec_ing_hos < TO_DATE('2027-01-01', 'YYYY-MM-DD')
    ) = (
        SELECT MAX(tot_costo)
        FROM (
                        SELECT SUM(h2.cos_tot_hos) AS tot_costo
            FROM hospedaje h2
                        JOIN ejecutivo e2 ON e2.id_eje = h2.id_eje
            WHERE h2.fec_ing_hos >= TO_DATE('2026-01-01', 'YYYY-MM-DD')
              AND h2.fec_ing_hos < TO_DATE('2027-01-01', 'YYYY-MM-DD')
                            AND e2.id_sup_eje IS NOT NULL
                            AND EXISTS (
                                        SELECT 1
                                        FROM ejecutivo s2
                                        WHERE s2.id_eje = e2.id_sup_eje
                                            AND s2.id_emp = e2.id_emp
                            )
            GROUP BY h2.id_eje
        )
    );

-- 38. Mostrar los datos del hotel en el que se hospedaron ejecutivos supervisados por más de un supervisor diferente,
-- siempre que ese hotel haya registrado novedades de al menos dos tipos distintos.
SELECT ho.*
FROM hotel ho
WHERE ho.id_hot IN (
        SELECT ha.id_hot
        FROM habitacion ha
        JOIN hospedaje h ON h.id_hab = ha.id_hab
        JOIN ejecutivo e ON e.id_eje = h.id_eje
        GROUP BY ha.id_hot
        HAVING COUNT(DISTINCT e.id_sup_eje) > 1
    )
  AND ho.id_hot IN (
        SELECT ha2.id_hot
        FROM habitacion ha2
        JOIN hospedaje h2 ON h2.id_hab = ha2.id_hab
        JOIN novedad n ON n.id_hos = h2.id_hos
        GROUP BY ha2.id_hot
        HAVING COUNT(DISTINCT n.tip_nov) >= 2
    );

-- 39. Mostrar el recepcionista que registró hospedajes para ejecutivos de empresas distintas en una misma fecha
-- y cuyo hotel tenga más habitaciones que el promedio general.
SELECT DISTINCT r.nom_rec, r.ape_rec
FROM recepcionista r
WHERE r.id_hot IN (
        SELECT ha.id_hot
        FROM habitacion ha
        GROUP BY ha.id_hot
        HAVING COUNT(*) > (
            SELECT AVG(cnt_hab)
            FROM (
                SELECT COUNT(*) AS cnt_hab
                FROM habitacion
                GROUP BY id_hot
            )
        )
    )
  AND EXISTS (
        SELECT 1
        FROM hospedaje h1
        JOIN ejecutivo e1 ON e1.id_eje = h1.id_eje
        WHERE h1.id_rec = r.id_rec
          AND EXISTS (
                SELECT 1
                FROM hospedaje h2
                JOIN ejecutivo e2 ON e2.id_eje = h2.id_eje
                WHERE h2.id_rec = h1.id_rec
                  AND TRUNC(h2.fec_ing_hos) = TRUNC(h1.fec_ing_hos)
                  AND e1.id_emp <> e2.id_emp
                  AND h2.id_hos <> h1.id_hos
          )
    );

-- 40. Mostrar la empresa pública cuyos ejecutivos tuvieron hospedajes en hoteles de más ciudades diferentes
-- que cualquier otra empresa pública.
SELECT emp.id_emp, emp.nom_emp, emp.raz_soc_emp, emp.ciu_emp
FROM empresa emp
WHERE UPPER(emp.raz_soc_emp) LIKE '%PUBLICA%'
  AND (
        SELECT COUNT(DISTINCT ho.ciu_hot)
        FROM ejecutivo e
        JOIN hospedaje h ON h.id_eje = e.id_eje
        JOIN habitacion ha ON ha.id_hab = h.id_hab
        JOIN hotel ho ON ho.id_hot = ha.id_hot
        WHERE e.id_emp = emp.id_emp
    ) = (
        SELECT MAX(cant_ciudades)
        FROM (
            SELECT COUNT(DISTINCT ho2.ciu_hot) AS cant_ciudades
            FROM empresa emp2
            JOIN ejecutivo e2 ON e2.id_emp = emp2.id_emp
            JOIN hospedaje h2 ON h2.id_eje = e2.id_eje
            JOIN habitacion ha2 ON ha2.id_hab = h2.id_hab
            JOIN hotel ho2 ON ho2.id_hot = ha2.id_hot
            WHERE UPPER(emp2.raz_soc_emp) LIKE '%PUBLICA%'
            GROUP BY emp2.id_emp
        )
    );

-- 41. Mostrar los datos del ejecutivo que nunca se hospedó en el hotel MARRIOT,
-- pero sí en todos los hoteles donde se hospedó el ejecutivo con cédula 1815.
SELECT e.*
FROM ejecutivo e
WHERE NOT EXISTS (
        SELECT 1
        FROM hospedaje h
        JOIN habitacion ha ON ha.id_hab = h.id_hab
        JOIN hotel ho ON ho.id_hot = ha.id_hot
        WHERE h.id_eje = e.id_eje
          AND UPPER(ho.nom_hot) = 'MARRIOT'
    )
  AND NOT EXISTS (
        SELECT 1
        FROM (
            SELECT DISTINCT ho.id_hot
            FROM hospedaje h1815
            JOIN habitacion ha1815 ON ha1815.id_hab = h1815.id_hab
            JOIN hotel ho ON ho.id_hot = ha1815.id_hot
            WHERE h1815.id_eje = '1815'
        ) hh
        WHERE NOT EXISTS (
            SELECT 1
            FROM hospedaje h3
            JOIN habitacion ha3 ON ha3.id_hab = h3.id_hab
            JOIN hotel ho3 ON ho3.id_hot = ha3.id_hot
            WHERE h3.id_eje = e.id_eje
              AND ho3.id_hot = hh.id_hot
        )
    );

-- 42. Mostrar el hospedaje cuyo costo es el más cercano, por encima, al costo promedio de todos los hospedajes del sistema,
-- junto con el ejecutivo y hotel asociados.
SELECT h.*, e.nom_eje, e.ape_eje, ho.nom_hot, ho.ciu_hot
FROM hospedaje h
JOIN ejecutivo e ON e.id_eje = h.id_eje
JOIN habitacion ha ON ha.id_hab = h.id_hab
JOIN hotel ho ON ho.id_hot = ha.id_hot
WHERE h.cos_tot_hos = (
        SELECT MIN(h2.cos_tot_hos)
        FROM hospedaje h2
        WHERE h2.cos_tot_hos > (
            SELECT AVG(h3.cos_tot_hos)
            FROM hospedaje h3
        )
    );

