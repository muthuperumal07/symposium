<%@ page import="java.sql.*, com.symposium.Databaseconnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scheduled Events - TechSymp '26</title>
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
            position: relative;
        }

        header h1 {
            margin: 0;
            font-size: 2.5rem;
        }

        header p {
            margin-top: 0.5rem;
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .nav-link {
            position: absolute;
            top: 25px;
            right: 30px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.2s;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .container {
            max-width: 1100px;
            margin: 2.5rem auto;
            padding: 0 1.5rem;
        }

        .events-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 1.5rem;
        }

        .event-card {
            background: var(--card-bg);
            padding: 1.75rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            border-left: 5px solid var(--primary);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .event-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }

        .event-card h3 {
            margin: 0 0 0.75rem 0;
            color: var(--text-main);
            font-size: 1.35rem;
        }

        .event-card p {
            margin: 0;
            color: var(--text-muted);
            line-height: 1.6;
        }

        .no-events {
            grid-column: 1 / -1;
            background: white;
            text-align: center;
            padding: 3rem;
            border-radius: 12px;
            color: var(--text-muted);
            font-style: italic;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
        .delete-btn {
    display: inline-block;
    margin-top: 1rem;
    background-color: #fee2e2;
    color: #dc2626;
    padding: 0.4rem 0.8rem;
    border-radius: 6px;
    text-decoration: none;
    font-size: 0.85rem;
    font-weight: 600;
    transition: background 0.2s;
}
.delete-btn:hover {
    background-color: #fecaca;
}
    </style>
</head>
<body>

    <header>
        <a href="events.jsp" class="nav-link">+ Add New Event</a>
        <h1>? Scheduled Symposium Events</h1>
        <p>Browse all technical and non-technical events lined up for TechSymp '26</p>
    </header>

    <div class="container">
        <div class="events-grid">
            <%
                try (Connection conn = Databaseconnection.getConnection();
     Statement stmt = conn.createStatement()) {
    
    // Automatically creates the table if it's missing!
    stmt.executeUpdate("CREATE TABLE IF NOT EXISTS events (" +
                       "id INT AUTO_INCREMENT PRIMARY KEY, " +
                       "title VARCHAR(255) NOT NULL, " +
                       "description TEXT NOT NULL)");

    // Your original query
    ResultSet rs = stmt.executeQuery("SELECT title, description FROM events ORDER BY id DESC");
     {
                    
                    boolean hasEvents = false;
                    while(rs.next()) {
                        hasEvents = true;
            %>
                      <div class="event-card">
                        <h3><%= rs.getString("title") %></h3>
                        <p><%= rs.getString("description") %></p>
                        <a href="deleteEvent?id=<%= rs.getInt("id") %>" class="delete-btn" onclick="return confirm('Are you sure you want to delete this event?');">Delete Event</a>
                       </div>
            <%
                    }
                    if(!hasEvents) {
            %>
                        <div class="no-events">No events scheduled yet. Use the "+ Add New Event" button to publish one!</div>
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
