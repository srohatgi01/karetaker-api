const express = require("express");
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const router = express.Router();

router.get("/", async (_req, res) => {
  res.send(await prisma.hospitals.findMany());
});

router.post("/", async (req, res) => {
    let newHospital = await prisma.hospitals.create({
        data: {
            hospital_name: req.body.hospital_name,
            email_address: req.body.email_address,
            phone_number: req.body.phone_number,
            hospital_address: req.body.hospital_address
        }
    })

    res.send(newHospital)
})

router.get("/:id", async (req, res) => {
    res.send( await prisma.hospitals.findUnique({
        where: {
            hospital_id: parseInt(req.params.id),
        }
    }))
})

module.exports = router;
 