/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.symposium;

/**
 *
 * @author Venka
 */



import com.symposium.EventDAO;
import com.symposium.Event;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/events")
public class EventServlet extends HttpServlet {
    private final EventDAO eventDAO = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch events and send them to the JSP page
        List<Event> eventList = eventDAO.getAllEvents();
        request.setAttribute("events", eventList);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle form submission to add a new event
        String name = request.getParameter("eventName");
        String category = request.getParameter("category");
        int teamSize = Integer.parseInt(request.getParameter("maxTeamSize"));
        double prize = Double.parseDouble(request.getParameter("prizePool"));

        eventDAO.addEvent(name, category, teamSize, prize);
        response.sendRedirect("events"); // Refresh page
    }
}
