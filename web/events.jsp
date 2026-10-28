<%@ page import="java.sql.*, com.symposium.Databaseconnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Symposium Portal - Event Management</title>
    <style>
        :root {
            --primary: #4f46e5;
            --primary-dark: #4338ca;
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

        header {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 2.5rem 2rem;
            text-align: center;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        header h1 {
            margin: 0;
            font-size: 2.5rem;
            letter-spacing: 1px;
        }

        header p {
            margin-top: 0.5rem;
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1.5rem;
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 2rem;
        }

        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr;
            }
        }

        .card {
            background: var(--card-bg);
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
            height: fit-content;
        }

        .card h2 {
            margin-top: 0;
            color: var(--primary);
            font-size: 1.5rem;
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 0.75rem;
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--text-main);
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }

        input[type="text"]:focus, textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        button {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.2s;
        }

        button:hover {
            background-color: var(--primary-dark);
        }

        .events-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.5rem;
        }

        .event-card {
            background: var(--card-bg);
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            border-left: 5px solid var(--primary);
            transition: transform 0.2s;
        }

        .event-card:hover {
            transform: translateY(-3px);
        }

        .event-card h3 {
            margin: 0 0 0.5rem 0;
            color: var(--text-main);
            font-size: 1.25rem;
        }

        .event-card p {
            margin: 0;
            color: var(--text-muted);
            line-height: 1.5;
        }

        .no-events {
            color: var(--text-muted);
            font-style: italic;
            text-align: center;
            padding: 2rem;
        }
    </style>
</head>
<body>

    <header>
        <h1>TechSymp '26 Portal</h1>
        <p>Explore technical & non-technical events and register your team</p>
    </header>

    <div class="container">
        <!-- Left Column: Form to Add Event -->
        <div class="card">
            <h2>Add New Event</h2>
            <form action="events.jsp" method="POST">
                <div class="form-group">
                    <label>Event Title</label>
                    <input type="text" name="title" placeholder="e.g., Code Debugging" required>
                </div>
                <div class="form-group">
                    <label>Description & Rules</label>
                    <textarea name="description" rows="4" placeholder="Enter event details, timings, and rules..." required></textarea>
                </div>
                <button type="submit">Publish Event</button>
            </form>
        </div>

        <!-- Right Column: Live Event Cards from Database -->
        <div class="card">
            <h2>Scheduled Events</h2>
            <div class="events-grid">
                <%
                    try (Connection conn = Databaseconnection.getConnection();
                         Statement stmt = conn.createStatement()) {
                        
                        // 1. Ensure table exists automatically
                        stmt.executeUpdate("CREATE TABLE IF NOT EXISTS events (" +
                                           "id INT AUTO_INCREMENT PRIMARY KEY, " +
                                           "title VARCHAR(255) NOT NULL, " +
                                           "description TEXT NOT NULL)");

                        // 2. Insert new event if form was submitted
                        String title = request.getParameter("title");
                        String description = request.getParameter("description");
                        if (title != null && !title.trim().isEmpty()) {
                            String insertSql = "INSERT INTO events (title, description) VALUES ('" + title.replace("'", "''") + "', '" + description.replace("'", "''") + "')";
                            stmt.executeUpdate(insertSql);
                        }

                        // 3. Query and display all events
                        ResultSet rs = stmt.executeQuery("SELECT title, description FROM events ORDER BY id DESC");
                        boolean hasEvents = false;
                        
                        while(rs.next()) {
                            hasEvents = true;
                %>
                            <div class="event-card">
                                <h3><%= rs.getString("title") %></h3>
                                <p><%= rs.getString("description") %></p>
                            </div>
                <%
                        }
                        
                        if(!hasEvents) {
                %>
                            <div class="no-events">No events added yet. Use the form to publish your first event!</div>
                <%
                        }
                    } catch(Exception e) {
                %>
                        <div class="no-events" style="color: red;">Error loading events: <%= e.getMessage() %></div>
                <%
                    }
                %>
            </div>
        </div>
    </div>

</body>
</html>