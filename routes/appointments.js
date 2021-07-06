const express = require("express");
const { PrismaClient } = require("@prisma/client");
const router = express.Router();
const prisma = new PrismaClient();
var conn = require("../config.js");

//This route will take doctor's id and create a new time slot for a doctor given the hospital_id, start_time and end_time
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

// This route will get you all the slots for all the doctors
router.get("/slots", async (_req, res) => {
  res.send(await prisma.slots.findMany());
});

// This route will get you all the slots for a particular doctor
router.get("/slots/:doctorId", async (req, res) => {
  res.send(
    await prisma.slots.findMany({
      where: {
        doctor_id: req.params.doctorId,
      },
    })
  );
});

// This route will get you all the available start time for the available slots of a particular doctor on a particular date
router.get("/getfreeslots/:doctorId/:date", async (req, res) => {
  conn.query(
    `select start_time, slot_id from slots where doctor_id='${req.params.doctorId}' and not exists (select slot_id from appointments where appointments.slot_id=slots.slot_id and appointments.doctor_id=slots.doctor_id and appointment_date='${req.params.date}');`,
    (_err, rows, _fields) => {
      res.send(rows);
    }
  );
});

// This route will get you all the appoitnments
router.get("/", async (_req, res) => {
  res.send(await prisma.appointments.findMany());
});

// get all the appointments of a particular user
router.get("/appointmentbyid/:userId", async (_req, res) => {
  res.send(
    await prisma.appointments.findMany({
      take: 10,
      where: {
        user_id: _req.params.userId,
      },
      orderBy: {
        appointment_id: 'desc',
      },
      select: {
        appointment_id: true,
        appointment_date: true,
        status: true,
        slots: {
          select: {
            start_time: true,
          },
        },
        hospitals: {
          select: {
            hospital_name: true,
            hospital_address: true,
          },
        },
        doctors: {
          select: {
            first_name: true,
            last_name: true,
          },
        },
      },
    })
  );
});

router.patch('/appointmentbyid/:appointmentId', async (req, res) => {
  res.send(await prisma.appointments.update({
    where: {
      appointment_id: parseInt(req.params.appointmentId),
    },
    data: {
      status: req.body.status
    }
  }))
})

//this route will let you create a new appointment
router.post("/", async (req, res) => {
  let newAppointment = await prisma.appointments.create({
    data: {
      appointment_date: req.body.appointment_date,
      user_id: req.body.user_id,
      doctor_id: req.body.doctor_id,
      hospital_id: req.body.hospital_id,
      slot_id: req.body.slot_id,
      remarks: req.body.remarks,
    },
  });

  res.send(newAppointment);
});

router.post("/rating", async (req, res) => {
  let newRating = await prisma.ratings.create({
    data: {
      user_id: req.body.user_id,
      doctor_id: req.body.doctor_id,
      hospital_id: req.body.hospital_id,
      rating_value: req.body.rating_value,
    },
  });
  res.send(newRating);
});

router.get("/rating", async (_req, res) => {
  res.send(await prisma.ratings.findMany());
});

router.get("/review", async (_req, res) => {
  res.send(await prisma.reviews.findMany());
});

router.post("/review", async (req, res) => {
  let newReview = await prisma.reviews.create({
    data: {
      review_text: req.body.review_text,
      rating_id: req.body.rating_id,
    },
  });

  res.send(newReview);
});
module.exports = router;
