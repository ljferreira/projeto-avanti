const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();

const getTodosUsuarios = async (request, response) => {
    const usuarios = await prisma.usuario.findMany();
    response.status(200).json(usuarios);
};

const criaUsuario = async (request, response) => {
    const {cpf, email, senha, nome, rua, numero, bairro, cidade, estado, cep} = request.body;
    const usuario = await prisma.usuario.create({
        data:{
            cpf, 
            email, 
            senha, 
            nome, 
            rua, 
            numero, 
            bairro, 
            cidade, 
            estado, 
            cep 
        }
    });
    response.status(201).json(usuario);
};

const atualizaUsuario = async (request, response) => {
    const {email, senha, data_cadastro, nome, rua, numero, bairro, cidade, estado, cep} = request.body;
    const {cpf} = request.params;

    const usuario = await prisma.usuario.findFirst({
        where:{cpf}
    });

    if(usuario){
        const usuario = await prisma.usuario.update({
            data:{
                email, 
                senha,
                data_cadastro, 
                nome, 
                rua, 
                numero, 
                bairro, 
                cidade, 
                estado, 
                cep 
            },
            where:{cpf}
        })
        response.status(200).json(usuario);
    }else{
        response.status(404).json('Usuário não encontrado');
    }
};

const deletaUsuario = async (request, response) => {
    const {cpf} = request.params;

    const usuario = await prisma.usuario.findFirst({
        where:{cpf}
    });

    if(usuario){
        await prisma.usuario.delete({
            where:{cpf}
        })
        response.status(204).send();
    }else{
        response.status(404).json('Usuário não encontrado');
    }
};


module.exports = {
    getTodosUsuarios,
    criaUsuario,
    atualizaUsuario,
    deletaUsuario
};
