-- CreateTable
CREATE TABLE "avaliacao_emprestimo" (
    "cod_avaliacao" SERIAL NOT NULL,
    "fk_emprestimo_id" INTEGER,
    "classif_livro" INTEGER,
    "classif_usuario" INTEGER,
    "comentario" TEXT,

    CONSTRAINT "avaliacao_emprestimo_pkey" PRIMARY KEY ("cod_avaliacao")
);

-- CreateTable
CREATE TABLE "classificacao_usuario" (
    "fk_usuario_cpf" CHAR(15) NOT NULL,
    "fk_avaliacao_cod" INTEGER NOT NULL,

    CONSTRAINT "classificacao_usuario_pkey" PRIMARY KEY ("fk_usuario_cpf","fk_avaliacao_cod")
);

-- CreateTable
CREATE TABLE "emprestimo" (
    "id_emprestimo" SERIAL NOT NULL,
    "fk_usuario_cpf" CHAR(15),
    "fk_livro_codigo" INTEGER,
    "data_emprestimo" DATE NOT NULL DEFAULT CURRENT_DATE,
    "data_prevista_devolucao" DATE,
    "data_devolucao" DATE,
    "emprestimo_autorizado" BOOLEAN DEFAULT false,
    "emprestimo_solicitado" BOOLEAN DEFAULT true,

    CONSTRAINT "emprestimo_pkey" PRIMARY KEY ("id_emprestimo")
);

-- CreateTable
CREATE TABLE "livro" (
    "codigo" SERIAL NOT NULL,
    "fk_usuario_cpf" CHAR(15),
    "nome" VARCHAR(100) NOT NULL,
    "editora" VARCHAR(100),
    "data_publicacao" DATE,
    "num_edicao" INTEGER,
    "autor_es" VARCHAR(100),
    "genero" VARCHAR(100),
    "disponivel" BOOLEAN DEFAULT true,

    CONSTRAINT "livro_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "usuario" (
    "cpf" CHAR(15) NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "senha" VARCHAR(255) NOT NULL,
    "data_cadastro" DATE NOT NULL DEFAULT CURRENT_DATE,
    "nome" VARCHAR(100) NOT NULL,
    "rua" VARCHAR(100),
    "numero" INTEGER,
    "bairro" VARCHAR(100),
    "cidade" VARCHAR(100),
    "estado" CHAR(2),
    "cep" VARCHAR(10),

    CONSTRAINT "usuario_pkey" PRIMARY KEY ("cpf")
);

-- AddForeignKey
ALTER TABLE "avaliacao_emprestimo" ADD CONSTRAINT "avaliacao_emprestimo_fk_emprestimo_id_fkey" FOREIGN KEY ("fk_emprestimo_id") REFERENCES "emprestimo"("id_emprestimo") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "classificacao_usuario" ADD CONSTRAINT "classificacao_usuario_fk_avaliacao_cod_fkey" FOREIGN KEY ("fk_avaliacao_cod") REFERENCES "avaliacao_emprestimo"("cod_avaliacao") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "classificacao_usuario" ADD CONSTRAINT "classificacao_usuario_fk_usuario_cpf_fkey" FOREIGN KEY ("fk_usuario_cpf") REFERENCES "usuario"("cpf") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "emprestimo" ADD CONSTRAINT "emprestimo_fk_livro_codigo_fkey" FOREIGN KEY ("fk_livro_codigo") REFERENCES "livro"("codigo") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "emprestimo" ADD CONSTRAINT "emprestimo_fk_usuario_cpf_fkey" FOREIGN KEY ("fk_usuario_cpf") REFERENCES "usuario"("cpf") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "livro" ADD CONSTRAINT "livro_fk_usuario_cpf_fkey" FOREIGN KEY ("fk_usuario_cpf") REFERENCES "usuario"("cpf") ON DELETE NO ACTION ON UPDATE NO ACTION;
