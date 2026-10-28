<%@ page import="java.sql.*, com.symposium.Databaseconnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechSymp '26 - Annual Technical Symposium</title>
    <style>
        :root {
            --primary: #4f46e5;
            --primary-dark: #4338ca;
            --accent: #f43f5e;
            --bg-color: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            margin: 0;
            padding: 0;
        }

        /* Hero Section */
        hero {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 5rem 2rem;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .hero-content {
            max-width: 800px;
            margin: 0 auto;
        }

        .hero h1 {
            margin: 0;
            font-size: 3rem;
            letter-spacing: 1px;
            font-weight: 800;
        }

        .hero p {
            margin-top: 1rem;
            font-size: 1.25rem;
            opacity: 0.9;
            line-height: 1.6;
        }

        .badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            padding: 0.35rem 1rem;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 1rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Main Container & Navigation Hub */
        .container {
            max-width: 1100px;
            margin: -3rem auto 4rem auto;
            padding: 0 1.5rem;
            position: relative;
            z-index: 10;
        }

        .hub-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }

        .hub-card {
            background: var(--card-bg);
            padding: 2.5rem 2rem;
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.08);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-top: 5px solid var(--primary);
        }

        .hub-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 30px -10px rgba(0, 0, 0, 0.12);
        }

        .hub-card.admin-card {
            border-top-color: var(--accent);
        }

        .hub-card h3 {
            margin-top: 0;
            font-size: 1.5rem;
            color: var(--text-main);
        }

        .hub-card p {
            color: var(--text-muted);
            font-size: 0.95rem;
            line-height: 1.5;
            margin-bottom: 2rem;
        }

        .btn {
            display: inline-block;
            background-color: var(--primary);
            color: white;
            padding: 0.85rem 2rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: background 0.2s;
            box-shadow: 0 4px 6px rgba(79, 70, 229, 0.2);
        }

        .btn:hover {
            background-color: var(--primary-dark);
        }

        .btn-accent {
            background-color: var(--accent);
            box-shadow: 0 4px 6px rgba(244, 63, 94, 0.2);
        }

        .btn-accent:hover {
            background-color: #e11d48;
        }

        /* Features / Info Section */
        .info-section {
            max-width: 1100px;
            margin: 0 auto 4rem auto;
            padding: 0 1.5rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .info-box {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.03);
            text-align: center;
        }

        .info-box h4 {
            margin: 0 0 0.5rem 0;
            color: var(--primary);
            font-size: 1.2rem;
        }

        .info-box span {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-main);
        }

        footer {
            text-align: center;
            padding: 2rem;
            color: var(--text-muted);
            font-size: 0.9rem;
            border-top: 1px solid #e2e8f0;
            background: white;
        }
    </style>
</head>
<body>

    <header class="hero">
        <div class="hero-content">
            <span class="badge">National Level Symposium</span>
            <h1>TechSymp '26</h1>
            <p>Showcase your coding prowess, technical acumen, and innovative ideas. Compete with the best minds across institutions!</p>
        </div>
    </header>

    <div class="container">
        <div class="hub-grid">
            <!-- View Events Card -->
            <div class="hub-card">
                <h3>Scheduled Events</h3>
                <p>Explore technical challenges, debugging contests, paper presentations, and non-technical gaming events.</p>
                <a href="scheduleevents.jsp" class="btn">View All Events</a>
            </div>

            <!-- Add Event Card -->
            <div class="hub-card admin-card">
                <h3>Publish New Event</h3>
                <p>Are you an organizer? Add new symposium competitions, schedules, rules, and guidelines instantly.</p>
                <a href="events.jsp" class="btn btn-accent">+ Add Event</a>
            </div>
        </div>
    </div>

    <div class="info-section">
        <div class="info-box">
            <h4>Active Categories</h4>
            <span>Coding & Web</span>
        </div>
        <div class="info-box">
            <h4>Prizes & Perks</h4>
            <span>Exciting Cash Pools</span>
        </div>
        <div class="info-box">
            <h4>Platform</h4>
            <span>Spring & JDBC</span>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 TechSymp Portal. Built with Java, JSP, and MySQL.</p>
    </footer>

</body>
</html>