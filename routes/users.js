//imports
const express = require("express");
const router = express.Router();
const { PrismaClient } = require("@prisma/client");
var conn = require('../config.js')

//to implement file upload
const multer = require('multer')

const QRCode = require('qrcode')




//to tamper with file paths
const path = require('path')


// Init
const prisma = new PrismaClient();


// ------------ ADMIN --------------
// This route will give a list of all the users present in the database
router.get("/", async (_req, res) => {
  let users = await prisma.users.findMany();
  res.json(users);
});

// Create a new User
router.post("/", async (req, res) => {
  let newUser = await prisma.users.create({
    data: {
      email_address: req.body.email_address,
      first_name: req.body.first_name,
      last_name: req.body.last_name,
      uuid: req.body.uuid,
      phone_number: req.body.phone_number,
      gender: req.body.gender,
      photo_url: req.body.photo_url,
    },
  });

  res.send(newUser);
});

router.get("/getuser/:id", async (req, res) => {
  let user = await prisma.users.findUnique({
    where: {
      email_address: req.params.id,
    },
  });

  if (user == null) res.sendStatus(404);
  else res.send(user);
});

//Pills Route
// TODO: Create PATCH requests for pills
router.post("/pills", async (req, res) => {
  let newPill = await prisma.pills.create({
    data: {
      pill_name: req.body.pill_name,
      pill_time: req.body.pill_time,
      user_id: req.body.user_id,
    },
  });

  res.send(newPill);
});

router.get("/pills", async (_req, res) => {
  res.send(await prisma.pills.findMany());
});

router.get("/pills/getpills/:id", async (req, res) => {
  res.send(
    await prisma.pills.findMany({
      where: {
        user_id: req.params.id,
      },
    })
  );
});






// User medical reports


// --------------- ADMIN -------------
// this will get all reports of all the users
router.get("/reports", async (_req, res) => {
  res.send(await prisma.reports.findMany());
});

// this will get all the reports for the particular user
router.get("/reports/getreportsbyuser/:userId", async (req, res) => {
  res.send(
    await prisma.reports.findMany({
      where: {
        user_id: req.params.userId,
      },
    })
  );
});

// to create a new user report
router.post("/reports", async (req, res) => {
  let newReport = await prisma.reports.create({
    data: {
      user_id: req.body.user_id,
      name_of_report: req.body.name_of_report,
      date_of_report: req.body.date_of_report,
      doctor_who_created_report: req.body.doctor_who_created_report,
      show_status: req.body.show_status,
    },
  });

  res.send(newReport);
});


//* Reports details

const reportDetailStorage = multer.diskStorage({
  destination: function(req, file, cb) {
    cb(null, 'uploads/reportdetails');
  },
  filename: function(req, file, cb) {
    cb(null,  file.fieldname + '_' + Date.now() + '_' + file.originalname);
  }
})


const fileFilter = function(req, file, cb) {
  if(file.mimetype === 'image/png' || file.mimetype === 'image/jpeg') {cb(null, true)}
else {cb(null, false)}
}

const reportUpload = multer({
  storage: reportDetailStorage,
  fileFilter: fileFilter
}).single('reportDetails')


//! POST
// to create a new report detail for a report
router.post("/reports/reportdetails", reportUpload, async (req, res) => {
  console.log(req.file)
  let newReportDetails = await prisma.report_details.create({
    data: {
      report_id: parseInt(req.body.report_id),
      report_image_link: '/api/v1' + req.file.path,
      remark: req.body.remark,
    },
  });

  res.send(newReportDetails);
});

//! GET
// To get the report details of a particular report
router.get("/reports/reportdetails/:reportId", async (_req, res) => {
  res.send(await prisma.report_details.findMany(
    {
      orderBy: {
        report_details_id: 'asc'
      },
      where: {
        report_id: parseInt(_req.params.reportId)
      }
    }
  ));
});


//* QR Code

//! GET
router.get("/qrcode/:id", async (req, res) => {
  let qrcode = await prisma.qr_code.findFirst({
    where: {
      user_id: req.params.id,
    },
    select: {
      qr_link: true
    }
  });

   res.send(qrcode);
});

//! POST
router.post("/qrcode", async (req, res) => {
  var uri = `/uploads/qrcode/${req.body.user_id.split('@')[0]}-${Date.now()}.png`;
  await QRCode.toFile(`.${uri}`, `localhost:4000/api/v1/users/getuser/${req.body.user_id}`);

  let newQRCode = await prisma.qr_code.create({
    data: {
      qr_link: uri,
      user_id: req.body.user_id,
    },
  });

  res.send(newQRCode);
});




// Health Stats Readings 


// ------------- ADMIN ---------------
router.get("/sugar", async (_req, res) => {
  res.send(await prisma.sugar_readings.findMany());
});


// Get the lastest Sugar Reading
router.get("/sugar/latest/:userId", async (_req, res) => {

  conn.query(`select * from sugar_readings where user_id = "${_req.params.userId}" ORDER BY reading_id DESC LIMIT 0, 1;`, (_err, rows, _fields) => {res.send(rows[0])})
});


//create new sugar reading
router.post("/sugar", async (req, res) => {
  let newSugarReading = await prisma.sugar_readings.create({
    data: {
      user_id: req.body.user_id,
      value: req.body.value,
      type: "TYPE_1"
    },
  });

  res.send(newSugarReading);
});

//get sugar readings for a specific user
router.get("/sugar/sugarbyid/:userId", async (req, res) => {
  res.send(await prisma.sugar_readings.findMany({
    where: {
      user_id: req.params.userId,
    }
  }))
})



// Blood Pressure

router.get("/bloodpressure", async (_req, res) => {
  res.send(await prisma.blood_pressure_readings.findMany());
});

// Get latest Blood Pressure Reading
router.get("/bloodpressure/latest/:userId", async (_req, res) => {

  conn.query(`select * from blood_pressure_readings where user_id = "${_req.params.userId}" ORDER BY reading_id DESC LIMIT 0, 1;`, (_err, rows, _fields) => {res.send(rows[0])})
});

router.post("/bloodpressure", async (req, res) => {
  let newBloodPressureReading = await prisma.blood_pressure_readings.create({
    data: {
      user_id: req.body.user_id,
      reading_value: req.body.reading_value,
    },
  });

  res.send(newBloodPressureReading);
});

//get blood pressure readings for a specific user
router.get("/bloodpressure/bloodpressurebyid/:userId", async (req, res) => {
  res.send(await prisma.blood_pressure_readings.findMany({
    where: {
      user_id: req.params.userId,
    }
  }))
})

// Heart Rate
router.get("/heartrate", async (_req, res) => {
  res.send(await prisma.heart_rate_readings.findMany());
});

// Get latest heart reading
router.get("/heart/latest/:userId", async (_req, res) => {

  conn.query(`select * from heart_rate_readings where user_id = "${_req.params.userId}" ORDER BY reading_id DESC LIMIT 0, 1;`, (_err, rows, _fields) => {res.send(rows[0])})
});

// Create new heart rate reading
router.post("/heartrate", async (req, res) => {
  let newHeartRateReading = await prisma.heart_rate_readings.create({
    data: {
      user_id: req.body.user_id,
      reading_value: req.body.reading_value,
    },
  });

  res.send(newHeartRateReading);
});

//get heart rate readings for a specific user
router.get("/heart/heartbyid/:userId", async (req, res) => {
  res.send(await prisma.heart_rate_readings.findMany({
    where: {
      user_id: req.params.userId,
    }
  }))
})


module.exports = router;
