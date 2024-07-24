-- Criando as tabelas
CREATE TABLE USUARIO (
    cpf CHAR(15) PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_cadastro DATE NOT NULL DEFAULT CURRENT_DATE,
    nome VARCHAR(100) NOT NULL,
    rua VARCHAR(100),
    numero INT,
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado CHAR(2),
    cep VARCHAR(10)
);

CREATE TABLE LIVRO (
    codigo SERIAL PRIMARY KEY,
    fk_usuario_cpf CHAR(15),
    nome VARCHAR(100) NOT NULL,
    editora VARCHAR(100),
    data_publicacao DATE,
    num_edicao INT,
    autor_es VARCHAR(100),
    genero VARCHAR(100),
    disponivel BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (fk_usuario_cpf) REFERENCES USUARIO(cpf)
);

CREATE TABLE EMPRESTIMO (
    id_emprestimo SERIAL PRIMARY KEY,
    fk_usuario_cpf CHAR(15),
    fk_livro_codigo INT,
    data_emprestimo DATE NOT NULL DEFAULT CURRENT_DATE,
    data_prevista_devolucao DATE,
    data_devolucao DATE,
    emprestimo_autorizado BOOLEAN DEFAULT FALSE,
    emprestimo_solicitado BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (fk_usuario_cpf) REFERENCES USUARIO(cpf),
    FOREIGN KEY (fk_livro_codigo) REFERENCES LIVRO(codigo)
);

CREATE TABLE AVALIACAO_EMPRESTIMO (
    cod_avaliacao SERIAL PRIMARY KEY,
    fk_emprestimo_id INT,
    classif_livro INT,
    classif_usuario INT,
    comentario TEXT,
    FOREIGN KEY (fk_emprestimo_id) REFERENCES EMPRESTIMO(id_emprestimo)
);

CREATE TABLE CLASSIFICACAO_USUARIO (
    fk_usuario_cpf CHAR(15),
    fk_avaliacao_cod INT,
    PRIMARY KEY (fk_usuario_cpf, fk_avaliacao_cod),
    FOREIGN KEY (fk_usuario_cpf) REFERENCES USUARIO(cpf),
    FOREIGN KEY (fk_avaliacao_cod) REFERENCES AVALIACAO_EMPRESTIMO(cod_avaliacao)
);

