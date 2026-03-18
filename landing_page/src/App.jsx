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
    const [formData, setFormData] = useState({ name: '', email: '', message: '' });
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
            setFormData({ name: '', email: '', message: '' });
        } catch (err) {
            setStatus({ loading: false, success: false, error: err.response?.data?.message || 'Something went wrong' });
        }
    };

    return (
        <div className="landing-page">
            {/* Navbar */}
            <nav className="nav">
                <div className="logo">TaskFlow</div>
                <div className="nav-links">
                    <button className="btn btn-primary">Download App</button>
                </div>
            </nav>

            {/* Hero Section */}
            <section className="hero">
                <motion.h1 
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.8 }}
                >
                    Master Your Day with <span className="gradient-text">TaskFlow</span>
                </motion.h1>
                <motion.p
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.8, delay: 0.2 }}
                >
                    The modern task manager designed for peak productivity. Organize, track, and complete tasks with ease.
                </motion.p>
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.8, delay: 0.4 }}
                >
                    <button className="btn btn-primary" onClick={() => document.getElementById('contact').scrollIntoView({ behavior: 'smooth' })}>
                        Get Started <ArrowRight size={18} style={{ marginLeft: '8px', verticalAlign: 'middle' }} />
                    </button>
                </motion.div>
            </section>

            {/* Features Section */}
            <section className="section">
                <h2 className="section-title">Why Choose TaskFlow?</h2>
                <div className="features-grid">
                    <FeatureCard 
                        icon={<Layout size={32} />} 
                        title="Intuitive Design" 
                        desc="Clean and minimal interface that keeps you focused on what matters most." 
                    />
                    <FeatureCard 
                        icon={<Smartphone size={32} />} 
                        title="Cross-Platform" 
                        desc="Seamlessly sync across your mobile devices and stay productive on the go." 
                    />
                    <FeatureCard 
                        icon={<ShieldCheck size={32} />} 
                        title="Secure & Private" 
                        desc="Your data is encrypted and secure with industry-standard authentication." 
                    />
                    <FeatureCard 
                        icon={<Zap size={32} />} 
                        title="Real-time Stats" 
                        desc="Track your progress with beautiful dashboards and task statistics." 
                    />
                </div>
            </section>

            {/* Screenshots Section */}
            <section className="section" style={{ background: 'rgba(255,255,255,0.02)' }}>
                <h2 className="section-title">App Preview</h2>
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
            <section className="section" id="contact">
                <div className="glass-card contact-container">
                    <h2 style={{ marginBottom: '1rem' }}>Contact Us</h2>
                    <p style={{ color: 'var(--text-muted)', marginBottom: '2rem' }}>
                        Have questions? We'd love to hear from you.
                    </p>
                    <form onSubmit={handleSubmit}>
                        <div className="form-group">
                            <label><User size={16} /> Name</label>
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
                            <label><Mail size={16} /> Email</label>
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
                            <label><MessageSquare size={16} /> Message</label>
                            <textarea 
                                name="message" 
                                className="form-input" 
                                rows="4" 
                                placeholder="Your message here..." 
                                required
                                value={formData.message}
                                onChange={handleInputChange}
                            ></textarea>
                        </div>
                        <button type="submit" className="btn btn-primary" style={{ width: '100%' }} disabled={status.loading}>
                            {status.loading ? 'Sending...' : 'Send Message'}
                        </button>
                        {status.success && (
                            <p style={{ color: '#10b981', marginTop: '1rem', textAlign: 'center' }}>
                                <CheckCircle2 size={16} /> Message sent successfully!
                            </p>
                        )}
                        {status.error && (
                            <p style={{ color: '#f43f5e', marginTop: '1rem', textAlign: 'center' }}>
                                {status.error}
                            </p>
                        )}
                    </form>
                </div>
            </section>

            {/* Footer */}
            <footer style={{ padding: '3rem 5%', textAlign: 'center', borderTop: '1px solid var(--glass-border)' }}>
                <p style={{ color: 'var(--text-muted)' }}>&copy; 2024 TaskFlow Application. Built with React &amp; Node.js.</p>
            </footer>
        </div>
    );
};

const FeatureCard = ({ icon, title, desc }) => (
    <motion.div 
        className="glass-card feature-card"
        whileHover={{ y: -10 }}
        transition={{ type: 'spring', stiffness: 300 }}
    >
        <div className="feature-icon">{icon}</div>
        <h3>{title}</h3>
        <p style={{ color: 'var(--text-muted)', marginTop: '1rem' }}>{desc}</p>
    </motion.div>
);

const ScreenshotCard = ({ title, image, fallback }) => (
    <motion.div 
        className="screenshot-card"
        whileHover={{ scale: 1.05 }}
        transition={{ type: 'spring', stiffness: 300 }}
    >
        <div className="screenshot-img-container">
            <img 
                src={image} 
                onError={(e) => { e.target.src = fallback; }} 
                alt={title} 
                className="screenshot-img" 
            />
        </div>
        <h4 style={{ marginTop: '1rem', textAlign: 'center' }}>{title}</h4>
    </motion.div>
);

export default App;
