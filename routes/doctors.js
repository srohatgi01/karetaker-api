const { PrismaClient } = require("@prisma/client");
const express = require("express");
const router = express.Router();
const { nanoid } = require("nanoid");
const prisma = new PrismaClient();
var conn = require("../config.js");

router.get("/", async (_req, res) => {
  let doctors = await prisma.doctors.findMany({
    include: {
      specialities: true,
    },
  });

  res.send(doctors);
});

router.get("/doctorbyid/:id", async (req, res) => {
  res.send(
    await prisma.doctors.findUnique({
      where: {
        doctor_id: req.params.id,
      },
      include: {
        specialities: true,
        hospitals_has_doctors: {
          include: { hospitals: true },
        },
      },
    })
  );
});

router.post("/", async (req, res) => {
  let doctorId = nanoid(6);
  let newDoctor = await prisma.doctors.create({
    data: {
      doctor_id: doctorId,
      first_name: req.body.first_name,
      last_name: req.body.last_name,
      speciality_id: req.body.speciality_id,
      phone_number: req.body.phone_number,
      practicing_years: req.body.practicing_years,
      email_address: req.body.email_address,
    },
  });

  res.send(newDoctor);
});

router.get("/search/:search", async (req, res) => {
  //   conn.query(`SELECT * from doctors where first_name LIKE '%${req.params.search}%' OR last_name LIKE '%${req.params.search}%';`, (_err, rows, _fields) => {res.send(rows)})

  res.send(
    await prisma.doctors.findMany({
      take: 10,
      where: {
        OR: [
          {
            first_name: {
              contains: req.params.search,
            },
          },
          {
            last_name: {
              contains: req.params.search,
            },
          },
        ],
      },
      select: {
        doctor_id: true,
        first_name: true,
        last_name: true,
        practicing_years: true,
        specialities: true,
      },
    })
  );
});

module.exports = router;
