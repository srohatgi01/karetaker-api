const express = require('express')
const router = express.Router()
const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient()

router.get('/getblogs', async (_req, res) => {
    res.send(await prisma.blogs.findMany())
})

router.post('/createblog', async (req, res) => {
    let newBlog = await prisma.blogs.create({
        data: {
            title: req.body.title,
            body: req.body.body,
            written_by: req.body.written_by
        }
    })

    res.send(newBlog)
})
router.get('/getblogs', async (_req, res) => {
    res.send(await prisma.blogs.findMany())
})

router.post('/createblog', async (req, res) => {
    let newBlog = await prisma.blogs.create({
        data: {
            title: req.body.title,
            body: req.body.body,
            written_by: req.body.written_by
        }
    })

    res.send(newBlog)
})

router.get('/getkeywords', async (_req, res) => {
    res.send(await prisma.keywords.findMany())
})

router.post('/createkeywords', async (req, res) => {
    let newKeyword = await prisma.keywords.create({
        data: {
            keyword: req.body.keyword
        }
    })

    res.send(newKeyword)
})

module.exports = router