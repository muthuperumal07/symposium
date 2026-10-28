<%@ page import="java.sql.*, com.symposium.Databaseconnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechSymp '26 - Scheduled Events</title>
    <style>
        :root {
            --primary: #4f46e5;
            --primary-dark: #4338ca;
            --danger: #ef4444;
            --danger-dark: #dc2626;
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
            max-width: 900px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        .nav-links {
            margin-bottom: 1.5rem;
        }

        .nav-links a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
        }

        .nav-links a:hover {
            text-decoration: underline;
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
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            transition: transform 0.2s;
        }

        .event-card:hover {
            transform: translateY(-3px);
        }

        .event-info h3 {
            margin: 0 0 0.5rem 0;
            color: var(--text-main);
            font-size: 1.25rem;
        }

        .event-info p {
            margin: 0;
            color: var(--text-muted);
            line-height: 1.5;
        }

        .btn-delete {
            background-color: var(--danger);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            font-size: 0.85rem;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-delete:hover {
            background-color: var(--danger-dark);
        }

        .no-events {
            background: var(--card-bg);
            color: var(--text-muted);
            font-style: italic;
            text-align: center;
            padding: 3rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body>

    <header>
        <h1>Scheduled Events</h1>
        <p>Explore all active competitions and technical challenges at TechSymp '26</p>
    </header>

    <div class="container">
        <div class="nav-links">
            <a href="index.jsp">&larr; Back to Home</a> &nbsp;|&nbsp; <a href="events.jsp">+ Publish New Event</a>
        </div>

        <div class="events-grid">
            <%
                try (Connection conn = Databaseconnection.getConnection();
                     Statement stmt = conn.createStatement()) {
                    
                    // 1. Ensure table exists automatically
                    stmt.executeUpdate("CREATE TABLE IF NOT EXISTS events (" +
                                       "id INT AUTO_INCREMENT PRIMARY KEY, " +
                                       "title VARCHAR(255) NOT NULL, " +
                                       "description TEXT NOT NULL)");

                    // 2. Handle deletion if requested
                    String deleteId = request.getParameter("deleteId");
                    if (deleteId != null && !deleteId.trim().isEmpty()) {
                        stmt.executeUpdate("DELETE FROM events WHERE id = " + deleteId);
                    }

                    // 3. Query and display all events including their id
                    ResultSet rs = stmt.executeQuery("SELECT id, title, description FROM events ORDER BY id DESC");
                    boolean hasEvents = false;
                    
                    while(rs.next()) {
                        hasEvents = true;
            %>
                        <div class="event-card">
                            <div class="event-info">
                                <h3><%= rs.getString("title") %></h3>
                                <p><%= rs.getString("description") %></p>
                            </div>
                            <form action="scheduleevents.jsp" method="POST" onsubmit="return confirm('Are you sure you want to delete this event?');">
                                <input type="hidden" name="deleteId" value="<%= rs.getInt("id") %>">
                                <button type="submit" class="btn-delete">Delete</button>
                            </form>
                        </div>
            <%
                    }
                    
                    if(!hasEvents) {
            %>
                        <div class="no-events">No events scheduled yet. Use the "+ Publish New Event" button to add one!</div>
            <%
                    }
                } catch(Exception e) {
            %>
                    <div class="no-events" style="color: red;">Error loading scheduled events: <%= e.getMessage() %></div>
            <%
                }
            %>
        </div>
    </div>

</body>
</html>