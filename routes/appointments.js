const express = require("express");
const { PrismaClient } = require("@prisma/client");
const { get } = require("./users");
const router = express.Router();
const prisma = new PrismaClient();
var conn = require('../config.js')

router.post("/createslot/:doctorId", async (req, res) => {
  let newSlot = await prisma.slots.create({
    data: {
      doctor_id: req.params.doctorId,
      hospital_id: req.body.hospital_id,
      start_time: req.body.start_time,
      end_time: req.body.end_time,
    },
  });

  res.send(newSlot);
});

router.get("/slots", async (req, res) => {
  res.send(await prisma.slots.findMany());
});

router.get("/getfreeslots/:doctorId/:date", async (req, res) => {
  conn.query(`select slot_id from slots where doctor_id='${req.params.doctorId}' and not exists (select slot_id from appointments where appointments.slot_id=slots.slot_id and appointments.doctor_id=slots.doctor_id and appointment_date='${req.params.date}' and slots.hospital_id = appointments.hospital_id);`, (err, rows, fields) => {res.send(rows)})
});
module.exports = router;

// 
