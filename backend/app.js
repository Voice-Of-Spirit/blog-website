// blog-website/backend/app.js
// Entry point for the backend server

const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');

dotenv.config();

const app = express();
const PORT = process.env.APP_PORT || 3000;

// Middlewares
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.use('/api/posts', require('./src/routes/posts'));
app.use('/api/auth', require('./src/routes/auth'));
app.use('/api/comments', require('./src/routes/comments'));
app.use('/api/admin', require('./src/routes/admin'));

// Health check
app.get('/', (req, res) => {
    res.json({ status: 'Blog API is running 🚀' });
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
