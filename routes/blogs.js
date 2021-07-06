const express = require("express");
const router = express.Router();
const { PrismaClient } = require("@prisma/client");
var conn = require("../config.js");
const prisma = new PrismaClient();

// Shoud be used by doctor
router.post("/createblog", async (req, res) => {
  let newBlog = await prisma.blogs.create({
    data: {
      title: req.body.title,
      body: req.body.body,
      written_by: req.body.written_by,
    },
  });
  res.send(newBlog);
});

// to be used by users
router.get("/getblogs", async (_req, res) => {
  conn.query(
    `SELECT title, written_by, blog_id FROM blogs ORDER BY RAND() LIMIT 10;`,
    (_err, rows, _fields) => {
      res.send(rows);
    }
  );
});

// to search for blogs with keywords as well as title
router.get("/search/:text", async (req, res) => {
  res.send(
    await prisma.blogs.findMany({
      select: {
        blog_id: true,
        written_by: true,
        title: true,
        // Uncomment if you want to show the keywords in blog search
        // blogs_has_keywords: {
        //   select: {
        //     keyword_name: true
        //   }
        // }
      },
      where: {
        OR: [
          {
            title: {
              contains: req.params.text,
            },
          },
          {
              blogs_has_keywords: {
                every: {
                    keyword_name: {
                        contains: req.params.text
                    }
                }
              }
          }
        ],
      },
    })
  );
});

router.get('/getblogsbyid/:blogId', async (req, res) => {
  res.send(await prisma.blogs.findUnique({
    where: {
      blog_id: parseInt(req.params.blogId)
    },
    include: {
      blogs_has_keywords: {
        select: {
          keyword_name: true
        }
      }
    }
  }))
})

// to be used by doctor
router.get("/getkeywords", async (_req, res) => {
  res.send(await prisma.keywords.findMany());
});

// used by doctors
router.post("/createkeywords", async (req, res) => {
  let newKeyword = await prisma.keywords.create({
    data: {
      keyword: req.body.keyword,
    },
  });

  res.send(newKeyword);
});

module.exports = router;
