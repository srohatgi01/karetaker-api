require('dotenv/config')
const express = require("express")
const bodyParser = require("body-parser")
const app = express()

// Import Routes
const usersRoute = require('./routes/users.js')
const doctorsRoute = require('./routes/doctors.js')
const specialitiesRoute = require('./routes/specialities.js')
const hospitalsRoute = require('./routes/hospitals.js')

app.use(bodyParser.json())

app.use('/api/v1/users', usersRoute)
app.use('/api/v1/specialities', specialitiesRoute)
app.use('/api/v1/doctors', doctorsRoute)
app.use('/api/v1/hospitals', hospitalsRoute)

app.listen(process.env.PORT, () => {
    console.log(`Server running at http://localhost:${process.env.PORT}`)
})
