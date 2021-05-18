const express = require("express");
const router = express.Router();
const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

router.get("/", async (_req, res) => {
  let users = await prisma.users.findMany();
  res.json(users);
});

router.post("/", async (req, res) => {
  let newUser = await prisma.users.create({
    data: {
      email_address: req.body.email_address,
      first_name: req.body.first_name,
      last_name: req.body.last_name,
      uuid: req.body.uuid,
      phone_number: req.body.phone_number,
      gender: req.body.gender
    },
  });

  res.send(newUser);
});

router.get('/:id', async (req, res) => {
    let user = await prisma.users.findUnique({
        where: {
            email_address: req.params.id
        }
    })

    res.send(user)
})
module.exports = router;
