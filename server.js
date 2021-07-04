require("dotenv/config");
const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const cors = require("cors");
const path = require("path");
const multer = require("multer");

// Import Routes
const usersRoute = require("./routes/users.js");
const doctorsRoute = require("./routes/doctors.js");
const specialitiesRoute = require("./routes/specialities.js");
const hospitalsRoute = require("./routes/hospitals.js");
const hospitalsHasDoctorsRoute = require("./routes/hospital_has_doctors.js");
const appointmentsRoute = require("./routes/appointments.js");
const blogsRoute = require("./routes/blogs.js");

// Set Multer storage Engine
const storage = multer.diskStorage({
  destination: "./images/sample",
  filename: function (req, file, cb) {
    cb(
      null,
      file.originalname + "-" + Date.now() + path.extname(file.originalname)
    );
  },
});

//Init Upload
const upload = multer({ storage: storage }).single("sample");

app.use(express.static("./images/sample"));
app.use(cors());
app.use(bodyParser.json());

// This is the route for users GET and POST
app.use("/api/v1/users", usersRoute);
app.use("/api/v1/specialities", specialitiesRoute);
app.use("/api/v1/doctors", doctorsRoute);
app.use("/api/v1/hospitals", hospitalsRoute);
app.use("/api/v1/hoshasdocs", hospitalsHasDoctorsRoute);
app.use("/api/v1/appointments", appointmentsRoute);
app.use("/api/v1/blogs", blogsRoute);

app.post("/api/v1/sample", (req, res) => {
  upload(req, res, (_err) => {
    console.log(req.file);
    res.send("test");
  });
});

app.listen(process.env.PORT, () => {
  console.log(`Server running at http://localhost:${process.env.PORT}`);
});
