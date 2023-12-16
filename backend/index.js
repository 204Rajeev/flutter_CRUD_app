import express from 'express'
import mysql from 'mysql2'
import cors from 'cors'
import dotenv from 'dotenv';
dotenv.config();

const app = express()

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE
});


app.use(express.json())
app.use(cors())

// root of the application
app.get("/", (req, res) => {
    res.json("hello world i am here")
})

//students route
//only for testing purpose
app.get("/student", (req, res) => {
    const q="SELECT * FROM student"
    db.query(q,(err,data)=>{
        if(err) return res.json(err)
        return res.json(data)
    })
})

app.get("/books", (req, res) => {
    const q="SELECT * FROM books"
    db.query(q,(err,data)=>{
        if(err) return res.json(err)
        return res.json(data)
    })
})

app.post('/books',(req,res)=>{
    const q="INSERT INTO books (title, description,cover,price) VALUES (?)"
    const values=[req.body.title,req.body.description,req.body.cover,req.body.price]
    db.query(q,[values],(err,data)=>{
        if(err) return res.json(err)
        return res.json("book added !")
    })
})

app.delete("/books/:id", (req, res) => {
    const bookId = req.params.id;
    const q = " DELETE FROM books WHERE id = ? ";
  
    db.query(q, [bookId], (err, data) => {
      if (err) return res.send(err);
      return res.json(data);
    });
  })

  app.put("/books/:id", (req, res) => {
    const bookId = req.params.id;
    const q = "UPDATE books SET title= ?, description= ?, price= ?, cover= ? WHERE id = ?";
  
    const values = [
      req.body.title,
      req.body.description,
      req.body.price,
      req.body.cover,
    ];
  
    db.query(q, [...values,bookId], (err, data) => {
      if (err) return res.send(err);
      return res.json(data);
    });
  });


app.listen(8800,()=>{
    console.log("connected to server")
})