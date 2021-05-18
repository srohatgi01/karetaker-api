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

router.get('/getuser/:id', async (req, res) => {
    let user = await prisma.users.findUnique({
        where: {
            email_address: req.params.id
        }
    })

    res.send(user)
})


//Pills Route
router.post('/pills', async (req, res) => {
    let newPill = await prisma.pills.create({
      data: {
        pill_name: req.body.pill_name,
        pill_time: req.body.pill_time,
        user_id: req.body.user_id
      }
    })

    res.send(newPill)
})

router.get('/pills', async (_req, res) => {
  res.send(await prisma.pills.findMany())
})

router.get('/pills/getpills/:id', async (req, res) => {
  res.send(await prisma.pills.findMany({
    where: {
      user_id: req.params.id
    }
  }))
})
module.exports = router;
