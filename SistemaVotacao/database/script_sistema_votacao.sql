use tabelas

drop database SIS_VOT_DB;

create database SIS_VOT_DB;

USE SIS_VOT_DB;

--Primeiro: voc� deve criar um login, que � um "cara" que tem permisss�o de se logar no SQL Sever
 DROP LOGIN sisvot;
CREATE LOGIN sisvot WITH PASSWORD = 's1i2s3v4o5t';

--Segundo: voc� deve criar um usu�rio para o banco de dados que deseja mapeando esse usu�rio para o login criado, 
--assim seu usu�rio conseguir� se logar no SQL Server e entrar no banco de dados desejado.
 DROP USER sisvot;
CREATE USER sisvot FROM LOGIN sisvot;

--Terceiro: voc� deve dar ou remover permiss�es ao usu�rio porque at� o segundo passo o usu�rio criado 
--s� tem direito a entrar no banco de dados, dando as permiss�es o usu�rio j� pode operar no banco de dados. 
--Se o usu�rio for comum voc� pode adicion�-lo apenas as roles de db_reader e db_writer, que permitir� 
--que o usu�rio fa�a select, insert, delete e update em todas as tabelas do referido banco de dados.
EXEC SP_ADDROLEMEMBER 'DB_DATAREADER', 'sisvot';

EXEC SP_ADDROLEMEMBER 'DB_DATAWRITER', 'sisvot';

create table TB_USUARIO (
	LOGIN VARCHAR(15) PRIMARY KEY,
	SENHA VARCHAR(15) NOT NULL,
	TIPO CHAR(1) NOT NULL,
	NOME VARCHAR(50) NULL,
	FL_TROCAR_SENHA CHAR(1) NOT NULL DEFAULT 'N'
)

INSERT INTO TB_USUARIO (LOGIN, SENHA, TIPO, NOME, FL_TROCAR_SENHA)
VALUES ('admin', 'admin', 'A', 'Administrador do Sistema', 'N')

--SELECT * FROM TB_USUARIO

create table TB_VOTACAO (
	ID_VOTACAO INT PRIMARY KEY,
	DESCRICAO VARCHAR(200) NOT NULL,
	DT_INI DATETIME NOT NULL,
	DT_FIM DATETIME NOT NULL,
	LOGIN_ADMIN VARCHAR(15) NULL 
		CONSTRAINT FK_USUARIO FOREIGN KEY 
			REFERENCES TB_USUARIO(LOGIN),
	FL_SECRETA CHAR(1) NOT NULL DEFAULT 'N',
	NM_ARQ_IMG_FUNDO VARCHAR(20)  NULL,
	CONTENT_TYPE_IMG_FUNDO VARCHAR(50)  NULL,
	IMAGEM_FUNDO VARBINARY(MAX)  NULL
)

INSERT INTO TB_VOTACAO (ID_VOTACAO, DESCRICAO, DT_INI, DT_FIM, LOGIN_ADMIN, FL_SECRETA)
VALUES (1, 'Bicho Preferido', '10-10-2010', '10-11-2114', 'admin', 'N')

--select *  from TB_VOTACAO  where ID_VOTACAO = 1

--drop table TB_CANDIDATO
create table TB_CANDIDATO (
	ID_CANDIDATO INT PRIMARY KEY,
	ID_VOTACAO INT NOT NULL,
	NOME VARCHAR(50) NOT NULL,
	IMAGEM VARBINARY(MAX) NULL,
	IMG_CONT_TYPE VARCHAR(30) NULL,
	DESCRICAO VARCHAR(200) NULL,
	NUMERO_VOTOS SMALLINT NOT NULL DEFAULT 0,
	
	CONSTRAINT FK_VOTACAO FOREIGN KEY (ID_VOTACAO)
		REFERENCES TB_VOTACAO(ID_VOTACAO)

)

INSERT INTO TB_CANDIDATO (ID_VOTACAO, ID_CANDIDATO, NOME, IMAGEM, IMG_CONT_TYPE, DESCRICAO, NUMERO_VOTOS)
VALUES (1, 1, 'Macaco Sim�o', NULL, NULL, 'Macaco Prego da esp�cie Cebus apella', 0)

INSERT INTO TB_CANDIDATO (ID_VOTACAO, ID_CANDIDATO, NOME, IMAGEM, IMG_CONT_TYPE, DESCRICAO, NUMERO_VOTOS)
VALUES (1, 2, 'C�o', NULL, NULL, 'Canis lupus familiaris', 0)

INSERT INTO TB_CANDIDATO (ID_VOTACAO, ID_CANDIDATO, NOME, IMAGEM, IMG_CONT_TYPE, DESCRICAO, NUMERO_VOTOS)
VALUES (1, 3, 'Gato', NULL, NULL, 'Felis silvestris catus', 0)

-- select * from TB_CANDIDATO where ID_VOTACAO = 1

create table TB_ELEITORADO (
	LOGIN VARCHAR(15) NOT NULL,
	ID_VOTACAO INT NOT NULL,
	FL_COMPARECEU CHAR(1) NOT NULL DEFAULT 'N',
	ID_CANDIDATO_VOTADO INT NULL,
	
	CONSTRAINT PK_TB_ELEITORADO PRIMARY KEY (LOGIN, ID_VOTACAO),
	
	CONSTRAINT FK_CANDIDATO FOREIGN KEY (ID_CANDIDATO_VOTADO)
			REFERENCES TB_CANDIDATO(ID_CANDIDATO)

)

insert into TB_ELEITORADO (LOGIN, ID_VOTACAO, FL_COMPARECEU, ID_CANDIDATO_VOTADO)
values ('admin', 1, 'N', NULL)

--select * from TB_ELEITORADO
