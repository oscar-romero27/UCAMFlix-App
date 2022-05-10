DROP TABLE Categoria;
DROP TABLE Rol;
DROP TABLE UsuarioEditor;
DROP TABLE UsuarioLector;
DROP TABLE UsuarioAdministrador;
DROP TABLE Video;
DROP TABLE Accede;
DROP TABLE Gestiona;
DROP TABLE Tiene;
/
CREATE TABLE  "USUARIOADMINISTRADOR" 
   (	"NICKADMINISTRADOR" VARCHAR2(255) NOT NULL ENABLE, 
	"CONTRASENIA" VARCHAR2(255) NOT NULL ENABLE, 
	"NOMPPAL" VARCHAR2(255), 
	"AP1" VARCHAR2(255) NOT NULL ENABLE, 
	"AP2" VARCHAR2(255), 
	"TELEFONO" VARCHAR2(255), 
	"EMAIL" VARCHAR2(255), 
	"NSS" VARCHAR2(255), 
	"TIPOVIA" VARCHAR2(255), 
	"NOMVIA" VARCHAR2(255), 
	"NUMVIA" VARCHAR2(255), 
	"CP" NUMBER(*,0), 
	 CONSTRAINT "USUARIOADMINISTRADOR_NICK_PK" PRIMARY KEY ("NICKADMINISTRADOR")
  USING INDEX  ENABLE
   )
/
CREATE TABLE  "ROL" 
   (	"NOMBREROL" VARCHAR2(255) NOT NULL ENABLE, 
	"DESCRIPCION" VARCHAR2(255), 
	 CONSTRAINT "ROL_NOMBRE_PK" PRIMARY KEY ("NOMBREROL")
  USING INDEX  ENABLE
   )
/
CREATE TABLE  "GESTIONA" 
   (	"NOMBREROL" VARCHAR2(255), 
	"NICKADMINISTRADOR" VARCHAR2(255), 
	 CONSTRAINT "GESTIONA_PK" PRIMARY KEY ("NOMBREROL", "NICKADMINISTRADOR")
  USING INDEX  ENABLE
   )
/
CREATE TABLE  "CATEGORIA" 
   (	"IDCATEGORIA" NUMBER(*,0) NOT NULL ENABLE, 
	"NOMBRE" VARCHAR2(255) NOT NULL ENABLE, 
	"DESCRIPCION" VARCHAR2(255), 
	"NUMVIDEOS" NUMBER(*,0), 
	 CONSTRAINT "CATEGORIA_IDCATEGORIA_PK" PRIMARY KEY ("IDCATEGORIA")
  USING INDEX  ENABLE
   )
/
CREATE TABLE  "VIDEO" 
   (	"IDVIDEO" NUMBER(*,0) NOT NULL ENABLE, 
	"NOMBRE" VARCHAR2(255) NOT NULL ENABLE, 
	"DIRECTOR" VARCHAR2(255), 
	"DESCRIPCION" VARCHAR2(255), 
	"DURACION" NUMBER, 
	"TIPO" VARCHAR2(255), 
	"IDCATEGORIA" NUMBER(*,0), 
	 CHECK (Duracion > 0.0) ENABLE, 
	 CONSTRAINT "VIDEO_IDVIDEO_PK" PRIMARY KEY ("IDVIDEO")
  USING INDEX  ENABLE
   )
/
CREATE TABLE  "ACCEDE" 
   (	"IDVIDEO" NUMBER(*,0), 
	"NOMBREROL" VARCHAR2(255), 
	 CONSTRAINT "ACCEDE_PK" PRIMARY KEY ("IDVIDEO", "NOMBREROL")
  USING INDEX  ENABLE
   )
/
CREATE TABLE  "USUARIOLECTOR" 
   (	"NICKLECTOR" VARCHAR2(255) NOT NULL ENABLE, 
	"CONTRASENIA" VARCHAR2(255) NOT NULL ENABLE, 
	"NOMPPAL" VARCHAR2(255), 
	"AP1" VARCHAR2(255) NOT NULL ENABLE, 
	"AP2" VARCHAR2(255), 
	"TELEFONO" VARCHAR2(255), 
	"EMAIL" VARCHAR2(255), 
	"EDAD" NUMBER(*,0), 
	 CONSTRAINT "USUARIOLECTOR_NICK_PK" PRIMARY KEY ("NICKLECTOR")
  USING INDEX  ENABLE
   )
/
CREATE TABLE  "TIENE" 
   (	"NOMBREROL" VARCHAR2(255), 
	"NICKLECTOR" VARCHAR2(255), 
	 CONSTRAINT "TIENE_PK" PRIMARY KEY ("NOMBREROL", "NICKLECTOR")
  USING INDEX  ENABLE
   )
/
CREATE TABLE  "USUARIOEDITOR" 
   (	"NICKEDITOR" VARCHAR2(255) NOT NULL ENABLE, 
	"CONTRASENIA" VARCHAR2(255) NOT NULL ENABLE, 
	"NOMPPAL" VARCHAR2(255), 
	"AP1" VARCHAR2(255) NOT NULL ENABLE, 
	"AP2" VARCHAR2(255), 
	"COMPANIA" VARCHAR2(255), 
	"TELEFONO" VARCHAR2(255), 
	"EMAIL" VARCHAR2(255), 
	"IDCATEGORIA" NUMBER(*,0) NOT NULL ENABLE, 
	 CONSTRAINT "USUARIOEDITOR_NICK_PK" PRIMARY KEY ("NICKEDITOR")
  USING INDEX  ENABLE
   )
/
ALTER TABLE  "ACCEDE" ADD CONSTRAINT "ACCEDE_ROL_FK2" FOREIGN KEY ("NOMBREROL")
	  REFERENCES  "ROL" ("NOMBREROL") ENABLE
/
ALTER TABLE  "ACCEDE" ADD CONSTRAINT "ACCEDE_VIDEO_FK1" FOREIGN KEY ("IDVIDEO")
	  REFERENCES  "VIDEO" ("IDVIDEO") ENABLE
/
ALTER TABLE  "GESTIONA" ADD CONSTRAINT "GESTIONA_ROL_FK1" FOREIGN KEY ("NOMBREROL")
	  REFERENCES  "ROL" ("NOMBREROL") ENABLE
/
ALTER TABLE  "GESTIONA" ADD CONSTRAINT "GESTIONA_USUARIOADMINISTRADOR_FK2" FOREIGN KEY ("NICKADMINISTRADOR")
	  REFERENCES  "USUARIOADMINISTRADOR" ("NICKADMINISTRADOR") ENABLE
/
ALTER TABLE  "TIENE" ADD CONSTRAINT "TIENE_ROL_FK1" FOREIGN KEY ("NOMBREROL")
	  REFERENCES  "ROL" ("NOMBREROL") ENABLE
/
ALTER TABLE  "TIENE" ADD CONSTRAINT "TIENE_USUARIOLECTOR_FK2" FOREIGN KEY ("NICKLECTOR")
	  REFERENCES  "USUARIOLECTOR" ("NICKLECTOR") ENABLE
/
ALTER TABLE  "USUARIOEDITOR" ADD CONSTRAINT "USUARIOEDITOR_CATEGORIA_FK" FOREIGN KEY ("IDCATEGORIA")
	  REFERENCES  "CATEGORIA" ("IDCATEGORIA") ENABLE
/
ALTER TABLE  "VIDEO" ADD CONSTRAINT "VIDEO_CATEGORIA_FK" FOREIGN KEY ("IDCATEGORIA")
	  REFERENCES  "CATEGORIA" ("IDCATEGORIA") ENABLE
/
CREATE UNIQUE INDEX  "ACCEDE_PK" ON  "ACCEDE" ("IDVIDEO", "NOMBREROL")
/
CREATE UNIQUE INDEX  "CATEGORIA_IDCATEGORIA_PK" ON  "CATEGORIA" ("IDCATEGORIA")
/
CREATE UNIQUE INDEX  "GESTIONA_PK" ON  "GESTIONA" ("NOMBREROL", "NICKADMINISTRADOR")
/
CREATE UNIQUE INDEX  "ROL_NOMBRE_PK" ON  "ROL" ("NOMBREROL")
/
CREATE UNIQUE INDEX  "TIENE_PK" ON  "TIENE" ("NOMBREROL", "NICKLECTOR")
/
CREATE UNIQUE INDEX  "USUARIOADMINISTRADOR_NICK_PK" ON  "USUARIOADMINISTRADOR" ("NICKADMINISTRADOR")
/
CREATE UNIQUE INDEX  "USUARIOEDITOR_NICK_PK" ON  "USUARIOEDITOR" ("NICKEDITOR")
/
CREATE UNIQUE INDEX  "USUARIOLECTOR_NICK_PK" ON  "USUARIOLECTOR" ("NICKLECTOR")
/
CREATE UNIQUE INDEX  "VIDEO_IDVIDEO_PK" ON  "VIDEO" ("IDVIDEO")
/
create index video_categoria_indice on video(idcategoria)
/
create index video_descripcion_indice on video(descripcion)
/
create index usuariolector_contrasenia_indice on usuariolector(contrasenia)
/
 CREATE SEQUENCE   "SEQ_CATEGORIA"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 10 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
/
INSERT INTO rol values ('Novel', 'Usuario de nivel inicial con acceso limitado')
/
INSERT INTO rol values ('Estandar', 'Usuario de nivel medio con acceso amplio')
/
INSERT INTO rol values ('Premium', 'Usuario de nivel alto con acceso completo')
/
INSERT INTO Categoria VALUES (seq_categoria.nextval, 'Accion', 'Caracterizado por luchas, peleas y violencia', 6)
/
INSERT INTO Categoria VALUES (seq_categoria.nextval, 'Aventura', 'Cuentan historias interesantes y excitantes en contextos normalmente exóticos', 9)
/
INSERT INTO Categoria VALUES (seq_categoria.nextval, 'Comedia', 'Exageran la situación para que el público se ría a carcajadas.', 3)
/
INSERT INTO Categoria VALUES (seq_categoria.nextval, 'Drama', 'Incluyen situaciones tensas y dramáticas, y que pueden acabar mal o no', 4)
/
INSERT INTO Categoria VALUES (seq_categoria.nextval, 'Terror', 'Pretenden despertar nuestro miedo con escenas chocantes, tensas y terroríficas', 5)
/
INSERT INTO Categoria VALUES (seq_categoria.nextval, 'Ciencia Ficcion', 'Giran en torno a situaciones fantásticas y, en muchos casos, futurísticas ', 5)
/
CREATE OR REPLACE TRIGGER CHECK_DURACION_TRG 
BEFORE INSERT OR UPDATE OF DURACION ON VIDEO
FOR EACH ROW
    BEGIN
    IF :NEW.DURACION < 0.0
THEN
RAISE_APPLICATION_ERROR(-20501, 'Tú debes hacer INSERT OR UPDATE' ||' en la tabla de VIDEO, en duración ' || ' CON valores por encima de cero.');
END IF;
END;
/
CREATE OR REPLACE TRIGGER CHECK_EDAD_TRG 
BEFORE INSERT OR UPDATE OF EDAD ON USUARIOLECTOR
FOR EACH ROW
    BEGIN
    IF :NEW.EDAD < 16
THEN
RAISE_APPLICATION_ERROR(-20502, 'Tú debes hacer INSERT OR UPDATE' ||' en la tabla de USUARIOLECTOR, en edad ' || ' CON valores por encima de 16.');
END IF;
END;
/
alter table USUARIOLECTOR add constraint chk_email_lector check (email like '%_@__%.__%');
/
alter table USUARIOEDITOR add constraint chk_email_editor check (email like '%_@__%.__%');
/
alter table USUARIOADMINISTRADOR add constraint chk_email_admin check (email like '%_@__%.__%');
/
CREATE OR REPLACE PROCEDURE UPDATE_NUMVID
(p_id_cat CATEGORIA.IDCATEGORIA%type) IS
    v_num_vid CATEGORIA.NUMVIDEOS%type;
BEGIN
    select count(*) into v_num_vid
    from video 
    where idcategoria = p_id_cat;

    update categoria set NUMVIDEOS = v_num_vid
    where idcategoria = p_id_cat;

END UPDATE_NUMVID;
/
CREATE OR REPLACE TRIGGER UPDATE_NUMVID_TRG 
AFTER INSERT OR UPDATE OF IDCATEGORIA ON VIDEO
FOR EACH ROW
BEGIN
    UPDATE_NUMVID(:NEW.IDCATEGORIA);
END;
/