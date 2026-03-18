const Contact = require('../models/Contact');

// @desc    Submit contact form
// @route   POST /api/contact
// @access  Public
exports.submitContactForm = async (req, res) => {
    try {
        const contact = await Contact.create(req.body);

        res.status(201).json({
            success: true,
            message: 'Message sent successfully',
            data: contact,
        });
    } catch (err) {
        res.status(400).json({
            success: false,
            message: err.message,
        });
    }
};
// @desc    Get all contact messages
// @route   GET /api/contact
// @access  Private
exports.getContactMessages = async (req, res) => {
    try {
        const contacts = await Contact.find().sort('-createdAt');

        res.status(200).json({
            success: true,
            count: contacts.length,
            data: contacts,
        });
    } catch (err) {
        res.status(400).json({
            success: false,
            message: err.message,
        });
    }
};
