const express = require('express')
const { PrismaClient } = require('@prisma/client')
const router = express.Router()
const prisma = new PrismaClient()

router.post("/", async (req, res) => {
    let hospitals_has_doctors = await prisma.hospitals_has_doctors.create({
        data: {
            doctor_id: req.body.doctor_id,
            hospital_id: req.body.hospital_id,
            doctor_status: req.body.doctor_status,
            fee: req.body.fee
        }
    })

    res.send(hospitals_has_doctors)
})

router.get('/', async (_req, res) => {
    res.send(await prisma.hospitals_has_doctors.findMany())
})

module.exports = router;