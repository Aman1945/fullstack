const express = require('express');
const { submitContactForm, getContactMessages } = require('../controllers/contactController');
const { protect } = require('../middleware/authMiddleware');

const router = express.Router();

router.post('/', submitContactForm);
router.get('/', protect, getContactMessages);

module.exports = router;
