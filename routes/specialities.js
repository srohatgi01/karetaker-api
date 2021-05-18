const express = require("express")
const router = express.Router()
const {PrismaClient} = require('@prisma/client')

const prisma = new PrismaClient()

router.get('/', async (_req, res) => {
    let specialities = await prisma.specialities.findMany()
    res.send(specialities)
})

router.post('/', async (req, res) => {
    let newSpeciality = await prisma.specialities.create({
        data: {
            speciality_name: req.body.speciality_name
        }
    })

    res.send(newSpeciality)
})

module.exports = router;