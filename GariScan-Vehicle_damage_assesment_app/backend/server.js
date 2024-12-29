require('dotenv').config(); // Load environment variables
const express = require('express');
const http = require('http'); // Required for Socket.IO integration
const mongoose = require('mongoose');
const cors = require('cors');
const { init } = require('./socket'); // WebSocket initialization
const authRoutes = require('./routes/auth'); // Authentication routes
const uploadRoutes = require('./routes/upload'); // Upload route
const profileRoutes = require('./routes/profile'); // Profile photo routes


const app = express();
const server = http.createServer(app); // Create HTTP server for Express and WebSocket

// Enable CORS
app.use(cors({
  origin: '*', // Allow all origins (adjust for production)
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));

// Middleware to parse JSON requests
app.use(express.json());

// Initialize WebSocket server
const io = init(server); // Initialize and get the Socket.IO instance

// MongoDB Atlas Connection
mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
  .then(() => console.log('MongoDB connected successfully'))
  .catch((error) => {
    console.error('MongoDB connection error:', error);
    process.exit(1); // Exit the app if MongoDB connection fails
  });

// Log MongoDB connection events
mongoose.connection.on('connected', () => console.log('Mongoose connected to MongoDB'));
mongoose.connection.on('error', (error) => console.error('Mongoose connection error:', error));

// Define routes
app.use('/api/auth', authRoutes); // Authentication 
app.use('/api/upload', uploadRoutes); // Upload route
app.use('/api/profile', profileRoutes); // Profile pic route

// Only include /api/process if it serves public API endpoints

// Start the server
const PORT = process.env.PORT || 5000;
server.listen(PORT, () => console.log(`Server running on port ${PORT}`));

// Export the MongoDB connection for reuse
module.exports = mongoose.connection;
