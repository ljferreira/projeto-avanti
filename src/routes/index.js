const {PrismaClient} = require('@prisma/client');
const Router = require('express');
const userController = require('../controller/userController');
const prisma = new PrismaClient();

const router = Router();

router.get(("/usuarios"), userController.getTodosUsuarios);
router.post(("/usuarios"), userController.criaUsuario);
router.put(("/usuarios/:cpf"), userController.atualizaUsuario);
router.delete(("/usuarios/:cpf"),userController.deletaUsuario);

module.exports = router;