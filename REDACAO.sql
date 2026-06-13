
 CREATE TABLE JORNALISTA( 
	id_jornalista INTEGER PRIMARY KEY auto_increment,
	nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) UNIQUE NOT NULL,
    RG VARCHAR(9) UNIQUE NOT NULL,
	sexo CHAR(1) NOT NULL,
    salario DECIMAL(9,2),
    cargo VARCHAR(30),
    senha VARCHAR(128),
    data_admissao DATE NOT NULL,
    data_nascimento DATE NOT NULL,  
    numero_supervisor INTEGER,
    data_admissao_diretor DATE,
    data_admissao_editor DATE
 );
 
 CREATE TABLE LEITOR(  
	numero_leitor INTEGER PRIMARY KEY auto_increment,
    nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) UNIQUE NOT NULL,
    RG VARCHAR(9) UNIQUE NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo CHAR(1) NOT NULL,
    senha VARCHAR(128)
 );
 
 CREATE TABLE EMAIL( 
	id_email INTEGER PRIMARY KEY auto_increment,
	endereco_email VARCHAR(50) NOT NULL,
    numero_leitor INTEGER UNIQUE,
    numero_jornalista INTEGER UNIQUE,
CONSTRAINT FK_EMAIL1 FOREIGN KEY (numero_leitor) REFERENCES LEITOR(numero_leitor),
CONSTRAINT FK_EMAIL2 FOREIGN KEY (numero_jornalista) REFERENCES JORNALISTA(id_jornalista)
 );
 
 CREATE TABLE TELEFONE( 
	id_telefone INTEGER PRIMARY KEY AUTO_INCREMENT,
    DDD CHAR(2) NOT NULL,
    numero_telefone VARCHAR(15) NOT NULL, 
    telefone_movel BOOLEAN,               
    numero_leitor INTEGER UNIQUE,
    numero_jornalista INTEGER UNIQUE,
CONSTRAINT FK_TELEFONE1 FOREIGN KEY (numero_leitor) REFERENCES LEITOR(numero_leitor),
CONSTRAINT FK_TELEFONE2 FOREIGN KEY (numero_jornalista) REFERENCES JORNALISTA(id_jornalista)
 );
 
 CREATE TABLE ENDERECO( 
 id_endereco INTEGER PRIMARY KEY AUTO_INCREMENT,
 DDD char(2),
 logradouro VARCHAR (70),
 numero INTEGER,
 quadra VARCHAR(20),
 lote VARCHAR(20),
 bairro VARCHAR(50),
 CEP VARCHAR(8) NOT NULL,
 UF CHAR(2) NOT NULL,
 cidade VARCHAR(50) NOT NULL,
 complemento VARCHAR(50),
 numero_leitor INTEGER UNIQUE,
 numero_jornalista INTEGER UNIQUE,
CONSTRAINT FK_ENDERECO1 FOREIGN KEY (numero_leitor) REFERENCES LEITOR(numero_leitor),
CONSTRAINT FK_ENDERECO2 FOREIGN KEY (numero_jornalista) REFERENCES JORNALISTA(id_jornalista)
 );
 
 CREATE TABLE ASSINATURA( 
	numero_assinatura INTEGER PRIMARY KEY AUTO_INCREMENT,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    numero_leitor INTEGER NOT NULL,
 CONSTRAINT FK_ASSINATURA1 FOREIGN KEY (numero_leitor) REFERENCES LEITOR(numero_leitor)
 );
 
 CREATE TABLE PAGAMENTO( 
    id_pagamento INTEGER PRIMARY KEY AUTO_INCREMENT,
	valor DECIMAL(5,2),    
    numero_assinatura INTEGER NOT NULL,
 CONSTRAINT FK_PAGAMENTO1 FOREIGN KEY (numero_assinatura) REFERENCES ASSINATURA(numero_assinatura) 
 );
 
 CREATE TABLE EDICAO( 
 numero_edicao INTEGER PRIMARY KEY AUTO_INCREMENT,
 data_publicacao DATE NOT NULL,
 numero_diretor INTEGER NOT NULL,
 CONSTRAINT FK_EDICAO1 FOREIGN KEY (numero_diretor) REFERENCES JORNALISTA(id_jornalista)
 );
 
 CREATE TABLE SECAO( 
 numero_secao INTEGER PRIMARY KEY AUTO_INCREMENT,
 nome_secao VARCHAR(40),
 data_publicacao DATE NOT NULL,
 numero_edicao INTEGER NOT NULL,
 numero_editor INTEGER NOT NULL,
CONSTRAINT FK_SECAO1 FOREIGN KEY (numero_edicao) REFERENCES EDICAO(numero_edicao),
CONSTRAINT FK_SECAO2 FOREIGN KEY (numero_editor) REFERENCES JORNALISTA(id_jornalista)
);

CREATE TABLE ARTIGO( 
numero_artigo INTEGER PRIMARY KEY AUTO_INCREMENT,
titulo VARCHAR(70) NOT NULL,
texto TEXT NOT NULL,
data_publicacao DATE NOT NULL,
data_atualizacao DATE,
numero_secao INTEGER NOT NULL,
CONSTRAINT FK_ARTIGO1 FOREIGN KEY (numero_secao) REFERENCES SECAO(numero_secao)
);

CREATE TABLE LEITURA(  
numero_acesso INTEGER PRIMARY KEY AUTO_INCREMENT,
tempo_de_leitura INTEGER,
numero_artigo INTEGER NOT NULL,
numero_leitor INTEGER NOT NULL,
CONSTRAINT FK_LEITURA1 FOREIGN KEY (numero_artigo) REFERENCES ARTIGO(numero_artigo),
CONSTRAINT FK_LEITURA2 FOREIGN KEY (numero_leitor) REFERENCES LEITOR(numero_leitor)
);

CREATE TABLE AUTORIA( 
id_autoria INTEGER PRIMARY KEY AUTO_INCREMENT,
numero_jornalista INTEGER NOT NULL,
numero_artigo INTEGER NOT NULL,
CONSTRAINT FK_AUTORIA1 FOREIGN KEY (numero_artigo) REFERENCES ARTIGO(numero_artigo),
CONSTRAINT FK_AUTORIA2 FOREIGN KEY (numero_jornalista) REFERENCES JORNALISTA(id_jornalista)
);
 
 
 -- INSERINDO DADOS NAS TABELAS
 INSERT INTO JORNALISTA(nome, CPF, RG, sexo, salario, data_admissao, data_nascimento, data_admissao_diretor, data_admissao_editor, cargo, numero_supervisor)
 VALUES
 ('Rodrigo Guedes Couto', '12345678901', '123456789',  'M', 5900.50, '2025-09-15', '2000-06-01', NULL, NULL, 'REDATOR', 7),  
('Fernanda Viana Saraiva', '98765432100', '987654321', 'F', 5900.50, '2025-09-15', '2002-02-26', NULL, NULL, 'REDATOR', 7),    
('Alice Jardim Becker', '45678912345', '456789123', 'F', 4900.50, '2025-09-15', '2004-12-20', NULL, NULL, 'REDATOR', 7),    
('Jorge Dornelles Bandeira', '10293847566', '102938475', 'M', 4900.50, '2025-09-15', '2004-01-30', NULL, NULL, 'REDATOR', 7),     
('Felipe Barcellos Maia', '56473829100', '564738291', 'M', 4900.50, '2024-08-13', '2003-06-21', NULL, NULL, 'REDATOR', 7),   
('Laura Bernardes Torres', '22334455677', '223344556', 'F', 6900.50, '2024-08-13', '2003-06-21', NULL, NULL, 'REDATOR', 7),  
('Bruno Prates Bitencourt', '88990011223', '889900112', 'M', 8900.50, '2025-04-10', '1988-10-25', NULL, '2025-09-11', 'EDITOR', NULL),  
('Andre Nogueira Paiva' , '33445566778', '334455667', 'M', 12900.50, '2024-04-10', '1980-11-30', '2024-12-04', NULL, 'DIRETOR', NULL),  
('Daniel Prestes Mendonca', '77889900112', '778899001', 'M', 2900.50, '2025-06-01', '2006-08-18', NULL, NULL, 'ESTAGIARIO', 6), 
('Patricia Assis Figueiredo', '44556677889', '445566778', 'F', 2900.50, '2025-06-01', '2007-04-21', NULL, NULL, 'ESTAGIARIO', 3);
 
 INSERT INTO LEITOR(nome, CPF, RG, data_nascimento, sexo)
 VALUES ( 'Pedro Almeida Silva', '11223344556','112233445', '1997-05-30', 'M' ),
( 'Paulo Alves Santos', '66778899001','667788990', '2001-10-20', 'M'  ),
( 'Patricia Araujo Oliveira', '99001122334','990011223', '1994-07-12', 'F' ),
( 'Maria Barbosa Souza', '55667788990','556677889', '1992-01-30', 'F' ),
( 'Marcia Carvalho Pereira', '10101010101','101010101', '1992-05-12', 'F' ),
( 'Luiz Costa Ferreira', '20202020202','202020202', '1994-03-02', 'M'  ),
( 'Lucas Ferreira Lima', '30303030303','303030303', '1993-03-02', 'M'  ),
( 'Juliana Gomes Alves', '40404040404','404040404', '1995-12-13', 'F' ),
( 'Julia Rodrigues Jesus', '50505050505','505050505', '1991-01-05', 'F' ),
( 'Jose Lima Costa', '60606060606','606060606', '1990-09-10', 'M'  ),
( 'Joao Nascimento Sousa', '70707070707','707070707', '1995-09-10', 'M'  ),
( 'Francisco Oliveira Gomes', '80808080808','808080808', '1997-12-30', 'M'  ),
( 'Gabriel Pereira Nascimento', '90909090909','909090909', '1989-12-01', 'M'  ),
( 'Francisca Ribeiro Soares', '11122233344','111222333', '1989-08-21', 'F' ),
( 'Fernanda Rodrigues Ribeiro', '22233344455','222333444', '1989-06-21', 'F' ),
( 'Carlos Almeida Santos', '33344455566','333444555', '2001-10-20', 'M'  ),
( 'Antonio Silva Jesus', '44455566677','444555666', '1982-08-15', 'M'  ),
( 'Antonia Soares Araujo', '55566677788','555666777', '1982-08-22', 'F' ),
( 'Ana Sousa Barbosa', '66677788899','666777888', '1988-01-22', 'F' ),
( 'Adriana Souza Carvalho', '77788899900','777888999', '1990-01-15', 'F'  );
 
 INSERT INTO EMAIL(endereco_email, numero_leitor, numero_jornalista)
 VALUES
('rodrigo.couto@mail.com', NULL,  1),
('fernanda.saraiva@mail.com', NULL,  2),
('alice.becker@mail.com', NULL,  3),
('jorge.bandeira@mail.com', NULL,  4),
('felipe.maia@mail.com', NULL,  5),
('laura.torres@mail.com', NULL,  6),
('bruno.bitencourt@mail.com', NULL,  7),
('andre.paiva@mail.com', NULL,  8),
('daniel.mendonca@mail.com', NULL,  9),
('patricia.figueiredo@mail.com', NULL, 10),
('pedro.silva@mail.com', 1, NULL ),
('paulo.santos@mail.com', 2, NULL ),
('patricia.oliveira@mail.com', 3, NULL ),
('maria.souza@mail.com', 4, NULL ),
('marcia.pereira@mail.com', 5, NULL ),
('luiz.ferreira@mail.com', 6, NULL ),
('lucas.lima@mail.com', 7, NULL ),
('juliana.alves@mail.com', 8 , NULL ),
('julia.jesus@mail.com', 9, NULL ),
('jose.costa@mail.com', 10, NULL ),
('joao.sousa@mail.com', 11, NULL ),
('francisco.gomes@mail.com', 12, NULL ),
('gabriel.nascimento@mail.com', 13, NULL ),
('francisca.soares@mail.com', 14, NULL ),
('fernanda.ribeiro@mail.com', 15, NULL ),
('carlos.santos@mail.com', 16, NULL ),
('antonio.jesus@mail.com', 17, NULL ),
('antonia.araujo@mail.com', 18, NULL ),
('ana.barbosa@mail.com', 19, NULL ),
('adriana.carvalho@mail.com', 20, NULL );

 INSERT INTO TELEFONE( DDD, numero_telefone, telefone_movel, numero_leitor, numero_jornalista)
 VALUES('61','999990001', true, null, 1 ),
('61', '999990002', true, null, 2 ),
('61', '999990003', true, null, 3 ),
('61', '999990004', true, null, 4 ),
('61', '999990005', true, null, 5 ),
('61', '999990006', true, null, 6 ),
('61', '999990007', true, null, 7 ),
('61', '999990008', true, null, 8 ),
('61', '999990009', true, null, 9 ),
('61', '999990010', true, null, 10),
('61', '999990011', true, 1 , null),
('61', '999990012', true, 2 , null),
('61', '999990013', true, 3 , null),
('61', '999990014', true, 4 , null),
('61', '999990015', true, 5 , null),
('61', '999990016', true, 6 , null),
('61', '999990017', true, 7 , null),
('61', '999990018', true, 8 , null),
('61', '999990019', true, 9 , null),
('61', '999990020', true, 10, null),
('61', '999990021', true, 11, null),
('61', '999990022', true, 12, null),
('61', '999990023', true, 13, null),
('61', '999990024', true, 14, null),
('61', '999990025', true, 15, null),
('61', '999990026', true, 16, null),
('61', '999990027', true, 17, null),
('61', '999990028', true, 18, null),
('61', '999990029', true, 19, null),
('61', '999990030', true, 20, null);


 INSERT INTO ASSINATURA(data_inicio, numero_leitor)
 VALUES  (current_date, 1 ),
 (current_date, 2 ),
 (current_date, 3 ),
 (current_date, 4 ),
 (current_date, 5 ), 
 (current_date, 6 ),
 (current_date, 7 ),
 (current_date, 8 ),
 (current_date, 9 ),
 (current_date, 10), 
 (current_date, 11),
 (current_date, 12),
 (current_date, 13),
 (current_date, 14),
 (current_date, 15), 
 (current_date, 16),
 (current_date, 17),
 (current_date, 18),
 (current_date, 19),
 (current_date, 20);
 
INSERT INTO PAGAMENTO(valor, numero_assinatura)
VALUES 
(19.9, 1),
(19.9, 2),
(19.9, 3);
 
  INSERT INTO EDICAO(data_publicacao, numero_diretor)
 VALUES
 ('2026-06-12', 8 ),
 ('2026-06-13', 8 ),
 ('2026-06-14', 8 ),
 ('2026-06-15', 8 ),
 ('2026-06-16', 8 );

 INSERT INTO SECAO(nome_secao, data_publicacao, numero_edicao, numero_editor)
 VALUES 
 ('COBERTURA COPA DO MUNDO 2026', '2026-06-12', 1, 7),
 ('ELEIÇÕES 2026', '2026-06-12', 1, 7),
 ('ECONOMIA E FINANÇAS', '2026-06-12', 1, 7),
 ('CELEBRIDADES E FOFOCAS', '2026-06-12', 1, 7); 
 
 
 INSERT INTO ARTIGO(titulo, texto, data_publicacao, numero_secao)
 VALUES 
 ('SELEÇÃO AGUARDA RETORNO DE CRAQUE PARA REFORÇAR TIME NA ESTREIA', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sed mi in nisi feugiat molestie. Maecenas porta dolor at orci hendrerit, at tincidunt justo blandit. Nunc aliquet egestas vestibulum. Nullam metus ante, sollicitudin a iaculis sed, tempus eu magna. Etiam ut sapien magna. Phasellus ornare mi erat, quis facilisis nibh ornare sed. Quisque ultricies, justo ut consequat tincidunt, tellus nisl pellentesque urna, eget mattis arcu nisi id risus. Vestibulum eu libero at ex egestas tincidunt vel vitae nibh. Fusce tincidunt ex quis felis luctus vestibulum. Vestibulum varius risus at pellentesque consectetur. Quisque et molestie dui. Phasellus et convallis lorem.', '2026-06-12', 1),
 ('VEJA OS CANDIDATOS COM PROCESSOS NA JUSTIÇA', 'Sed a est accumsan, mollis mi a, tincidunt lectus. Sed condimentum magna vitae ullamcorper feugiat. Donec tempus tortor non feugiat porttitor. Ut sed tortor augue. Nulla facilisi. Cras nec aliquet est. Sed aliquet suscipit mi, eu dictum tellus maximus eget. Cras congue enim non eleifend consequat. Duis vel quam sed justo consequat lacinia. Aliquam convallis sit amet massa sit amet aliquet. Maecenas elit orci, eleifend sit amet augue id, pellentesque convallis nulla. Morbi sagittis nisl nec nibh malesuada, at bibendum est tempor. Maecenas sed nisi turpis.', '2026-06-12', 2),
 ('INFLAÇÃO AVANÇA NO SEGUNDO TRIMESTRE', 'Cras enim urna, venenatis quis sollicitudin quis, euismod nec metus. Cras ut tellus rhoncus, convallis nisi ut, sollicitudin nunc. Nunc quis eros leo. Etiam aliquam lectus dolor, sit amet fermentum dui aliquam in. In id imperdiet massa, non egestas lacus. Etiam massa nisi, volutpat scelerisque facilisis sed, sollicitudin eu nulla. Integer in lorem dui. Proin orci lectus, rutrum ut felis in, tincidunt iaculis arcu. Nullam maximus mi turpis, id pulvinar ante blandit eget. Donec sed tortor purus. Nulla facilisi. Suspendisse cursus, lectus laoreet finibus lacinia, neque nunc dapibus ipsum, vitae sagittis est elit sed ligula. Aliquam tincidunt tristique arcu, a convallis purus. Integer auctor malesuada nisi vel commodo. Nullam ullamcorper convallis velit, et dictum leo tristique ut.', '2026-06-12', 3),
 ('INFLUENCIADORA É FLAGRADA COM NOVO NAMORADO', 'Curabitur ornare tellus eu metus dignissim, quis posuere nunc porttitor. Pellentesque lacinia convallis turpis tempor suscipit. In hac habitasse platea dictumst. Maecenas ac volutpat risus. Morbi rutrum dolor eget orci molestie ullamcorper. Donec nulla sem, cursus vitae sem eu, eleifend facilisis neque. Duis vestibulum interdum magna, quis auctor sapien euismod at. Aenean a nulla dictum, suscipit mauris vitae, sagittis enim. Ut a lectus pharetra, tincidunt lectus vitae, sodales magna.', '2026-06-12', 4);

 
 INSERT INTO ENDERECO(logradouro, numero, CEP, UF, cidade, bairro, numero_leitor, numero_jornalista)
 VALUES
 ( 'Rua 1', 10, 70000000, 'SP', 'Aguas Claras Sul' , 'Brasilia ', NULL, 1 ), 
 ( 'Rua 2', 10, 70234567, 'SP', 'Aguas Claras Sul', 'Santos', NULL, 2 ), 
 ( 'Rua 3', 10, 70345678, 'SP', 'Aguas Claras Sul', 'Goiania', NULL, 3 ), 
 ( 'Rua 4', 10, 70456789, 'SP', 'Aguas Claras Sul', 'Goiania', NULL, 4 ), 
 ( 'Rua 5', 10, 70567890, 'SP', 'Aguas Claras Sul', 'Goiania', NULL, 5 ), 
 ( 'Rua 6', 10, 70678901, 'SP', 'Aguas Claras Sul', 'Goiania', NULL, 6 ), 
 ( 'Rua 7', 10, 70789012, 'SP', 'Aguas Claras Sul', 'Goiania', NULL, 7 ), 
 ( 'Rua 8', 10, 70890123, 'SP', 'Aguas Claras Sul', 'Goiania', NULL, 8 ), 
 ( 'Rua 9', 10, 70901234, 'SP', 'Aguas Claras Sul', 'Goiania', NULL, 9 ), 
 ( 'Rua 10', 10, 71789012, 'SP', 'Aguas Claras Sul', 'Goiania', NULL, 10 ), 
 ( 'Rua dos Bobos', 10, 71012345, 'GO', 'Jardim Goias', 'Goiania', 1, NULL );
                         
INSERT INTO LEITURA(tempo_de_leitura, numero_artigo, numero_leitor)
VALUES 
(10, 1, 1),
(5, 4, 2),
(7, 2, 3),
(15, 1, 4);

INSERT INTO AUTORIA(numero_jornalista, numero_artigo)
VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4);

 
 SELECT * FROM JORNALISTA;
 SELECT * FROM LEITOR;
 SELECT * FROM EMAIL;
 SELECT * FROM TELEFONE;
 SELECT * FROM ASSINATURA;
 SELECT * FROM PAGAMENTO;
 SELECT * FROM EDICAO;
 SELECT * FROM SECAO;
 SELECT * FROM ARTIGO;
 SELECT * FROM AUTORIA;
 SELECT * FROM LEITURA;
 SELECT * FROM ENDERECO;
 
 
 

