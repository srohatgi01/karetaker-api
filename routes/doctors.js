const { PrismaClient } = require('@prisma/client')
const express = require("express")
const router = express.Router()
const { nanoid } = require('nanoid')
const prisma = new PrismaClient()

router.get('/', async (_req, res) => {
    let doctors = await prisma.doctors.findMany({
        include: {
            specialities: true
        }
    })

    res.send(doctors)
})

router.get('/:id', async (req, res) => {
    res.send(await prisma.doctors.findUnique({
        where: {
            doctor_id: req.params.id
        },
        include: {
            specialities: true,
            hospitals_has_doctors: true
        }
    }))
})

router.post('/', async (req, res) => {
    let newDoctor = await prisma.doctors.create({
        data: {
            doctor_id: nanoid(6),
            first_name: req.body.first_name,
            last_name: req.body.last_name,
            speciality_id: req.body.speciality_id,
            phone_number: req.body.phone_number,
            practicing_years: req.body.practicing_years,
            email_address: req.body.email_address
        },
    })
    
    res.send(newDoctor)
})

module.exports = router;