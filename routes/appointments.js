const express = require('express')
const { PrismaClient } = require('@prisma/client')
const { get } = require('./users')
const router = express.Router()
const prisma = new PrismaClient()

router.post('/createslot/:doctorId', async (req, res) => {
  let newSlot = await prisma.slots.create({
    data: {
      doctor_id: req.params.doctorId,
      hospital_id: req.body.hospital_id,
      start_time: req.body.start_time,
      end_time: req.body.end_time
    }
  })

  res.send(newSlot)
})

router.get('/slots', async (req, res) => {
  res.send(await prisma.slots.findMany())
})
  module.exports = router;