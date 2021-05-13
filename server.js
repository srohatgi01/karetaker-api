const express = require("express")
const app = express()
PORT = 4000

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`)
})

// MIDDLEWARE
app.use('/users', () => {
    console.log('Users Page');
});

// ROUTES
app.get('/', (_req, res) => { res.send('This is Home page')})
app.get('/users', (_req, res)=> {res.send('This is Page for all the users')})