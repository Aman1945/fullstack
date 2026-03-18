const express = require('express');
const {
    getTasks,
    getStats,
    createTask,
    updateTask,
    deleteTask,
} = require('../controllers/taskController');
const { protect } = require('../middleware/authMiddleware');

const router = express.Router();

router.use(protect);

router.route('/').get(getTasks).post(createTask);
router.get('/stats', getStats);
router.route('/:id').put(updateTask).delete(deleteTask);

module.exports = router;
