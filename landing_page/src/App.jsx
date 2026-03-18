import React, { useState } from 'react';
import axios from 'axios';
import { motion } from 'framer-motion';
import { 
  CheckCircle2, 
  Layout, 
  Smartphone, 
  ShieldCheck, 
  Zap, 
  Mail, 
  User, 
  MessageSquare,
  ArrowRight
} from 'lucide-react';

const API_BASE_URL = 'https://fullstack-me1i.onrender.com/api';

const App = () => {
    const [formData, setFormData] = useState({ name: '', email: '', message: '', phone: '' });
    const [status, setStatus] = useState({ loading: false, success: false, error: null });

    const handleInputChange = (e) => {
        setFormData({ ...formData, [e.target.name]: e.target.value });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setStatus({ loading: true, success: false, error: null });
        try {
            await axios.post(`${API_BASE_URL}/contact`, formData);
            setStatus({ loading: false, success: true, error: null });
            setFormData({ name: '', email: '', message: '', phone: '' });
        } catch (err) {
            setStatus({ loading: false, success: false, error: err.response?.data?.message || 'Something went wrong' });
        }
    };

    return (
        <div className="app">
            {/* Navbar */}
            <nav>
                <div className="logo">TaskFlow</div>
                <div className="nav-links">
                    <button className="btn btn-primary">Download App</button>
                </div>
            </nav>

            {/* Hero Section */}
            <header className="hero">
                <motion.div 
                    className="badge"
                    initial={{ opacity: 0, y: 10 }}
                    animate={{ opacity: 1, y: 0 }}
                >
                    Premium Productivity Suite
                </motion.div>
                <motion.h1 
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.8 }}
                >
                    Master Your Day with <span style={{ color: 'var(--primary)' }}>TaskFlow</span>
                </motion.h1>
                <motion.p
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.8, delay: 0.2 }}
                >
                    The modern task manager designed for peak productivity. Organize, track, and complete tasks with ease.
                </motion.p>
                <motion.div
                    className="cta-group"
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.8, delay: 0.4 }}
                >
                    <button className="btn btn-primary" onClick={() => document.getElementById('contact').scrollIntoView({ behavior: 'smooth' })}>
                        Get Started Free <ArrowRight size={18} style={{ marginLeft: '8px', verticalAlign: 'middle' }} />
                    </button>
                    <button className="btn btn-secondary">
                        View Demo
                    </button>
                </motion.div>
            </header>

            {/* Features Section */}
            <section className="features">
                <div className="section-header">
                    <h2>Why Choose TaskFlow?</h2>
                    <p style={{ color: 'var(--text-muted)' }}>Experience the most intuitive task management system.</p>
                </div>
                <div className="feature-grid">
                    <FeatureCard 
                        icon={<Layout size={28} />} 
                        title="Intuitive Design" 
                        desc="Clean and minimal interface that keeps you focused on what matters most." 
                    />
                    <FeatureCard 
                        icon={<Smartphone size={28} />} 
                        title="Cross-Platform" 
                        desc="Seamlessly sync across your mobile devices and stay productive on the go." 
                    />
                    <FeatureCard 
                        icon={<ShieldCheck size={28} />} 
                        title="Secure & Private" 
                        desc="Your data is encrypted and secure with industry-standard authentication." 
                    />
                    <FeatureCard 
                        icon={<Zap size={28} />} 
                        title="Real-time Stats" 
                        desc="Track your progress with beautiful dashboards and task statistics." 
                    />
                </div>
            </section>

            {/* Screenshots Section */}
            <section className="screenshots-section">
                <div className="section-header">
                    <h2>Everything in One Place</h2>
                    <p style={{ color: 'var(--text-muted)' }}>Meticulously designed for a seamless user experience.</p>
                </div>
                <div className="screenshots">
                    <ScreenshotCard 
                        title="Modern Login" 
                        image="https://raw.githubusercontent.com/Aman1945/fullstack/main/landing_page/src/assets/login_mockup.png" 
                        fallback="./assets/login_mockup.png"
                    />
                    <ScreenshotCard 
                        title="Smart Dashboard" 
                        image="https://raw.githubusercontent.com/Aman1945/fullstack/main/landing_page/src/assets/dashboard_mockup.png" 
                        fallback="./assets/dashboard_mockup.png"
                    />
                    <ScreenshotCard 
                        title="Task Management" 
                        image="https://raw.githubusercontent.com/Aman1945/fullstack/main/landing_page/src/assets/tasks_mockup.png" 
                        fallback="./assets/tasks_mockup.png"
                    />
                </div>
            </section>

            {/* Contact Form Section */}
            <section className="contact" id="contact">
                <div className="contact-container">
                    <div className="section-header" style={{ textAlign: 'left', marginBottom: '40px' }}>
                        <h2>Get in Touch</h2>
                        <p style={{ color: 'var(--text-muted)' }}>
                            Have questions? We'd love to hear from you.
                        </p>
                    </div>
                    <form onSubmit={handleSubmit}>
                        <div className="form-group">
                            <label>Full Name</label>
                            <input 
                                type="text" 
                                name="name" 
                                className="form-input" 
                                placeholder="John Doe" 
                                required 
                                value={formData.name}
                                onChange={handleInputChange}
                            />
                        </div>
                        <div className="form-group">
                            <label>Email Address</label>
                            <input 
                                type="email" 
                                name="email" 
                                className="form-input" 
                                placeholder="john@example.com" 
                                required 
                                value={formData.email}
                                onChange={handleInputChange}
                            />
                        </div>
                        <div className="form-group">
                            <label>Phone Number (Optional)</label>
                            <input 
                                type="tel" 
                                name="phone" 
                                className="form-input" 
                                placeholder="+91 98765 43210" 
                                value={formData.phone}
                                onChange={handleInputChange}
                            />
                        </div>
                        <div className="form-group">
                            <label>Your Message</label>
                            <textarea 
                                name="message" 
                                className="form-input" 
                                rows="5" 
                                placeholder="How can we help you?" 
                                required
                                value={formData.message}
                                onChange={handleInputChange}
                            ></textarea>
                        </div>
                        <button type="submit" className="btn btn-primary" style={{ width: '100%', marginTop: '16px' }} disabled={status.loading}>
                            {status.loading ? 'Sending Request...' : 'Send Message'}
                        </button>
                        {status.success && (
                            <motion.div 
                                initial={{ opacity: 0, scale: 0.9 }}
                                animate={{ opacity: 1, scale: 1 }}
                                style={{ color: '#059669', marginTop: '24px', textAlign: 'center', background: '#ECFDF5', padding: '16px', borderRadius: '12px' }}
                            >
                                <CheckCircle2 size={20} style={{ verticalAlign: 'middle', marginRight: '8px' }} /> 
                                <strong>Success!</strong> Your message has been sent.
                            </motion.div>
                        )}
                        {status.error && (
                            <p style={{ color: '#EF4444', marginTop: '16px', textAlign: 'center' }}>
                                {status.error}
                            </p>
                        )}
                    </form>
                </div>
            </section>

            {/* Footer */}
            <footer>
                <p>&copy; 2024 TaskFlow Premium. All rights reserved.</p>
            </footer>
        </div>
    );
};

const FeatureCard = ({ icon, title, desc }) => (
    <motion.div 
        className="feature-card"
        whileHover={{ y: -10 }}
    >
        <div className="feature-icon">{icon}</div>
        <h3>{title}</h3>
        <p style={{ color: 'var(--text-muted)', marginTop: '1rem' }}>{desc}</p>
    </motion.div>
);

const ScreenshotCard = ({ title, image, fallback }) => (
    <motion.div 
        className="screenshot-card"
        whileHover={{ y: -5 }}
    >
        <div className="screenshot-img-container">
            <img 
                src={image} 
                onError={(e) => { e.target.src = fallback; }} 
                alt={title} 
                className="screenshot-img" 
                style={{ width: '100%', borderRadius: '24px' }}
            />
        </div>
        <h4 style={{ marginTop: '1.5rem', textAlign: 'center', fontWeight: '700' }}>{title}</h4>
    </motion.div>
);

export default App;
