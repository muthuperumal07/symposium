/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.symposium;

/**
 *
 * @author Venka
 */


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteEvent")
public class DeleteEventServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int eventId = Integer.parseInt(idStr);
                
                try (Connection conn = Databaseconnection.getConnection()) {
                    // 1. Delete associated registrations first to prevent foreign key errors
                    String deleteRegSql = "DELETE FROM registrations WHERE event_id = ?";
                    try (PreparedStatement psReg = conn.prepareStatement(deleteRegSql)) {
                        psReg.setInt(1, eventId);
                        psReg.executeUpdate();
                    }
                    
                    // 2. Delete the event itself
                    String deleteEventSql = "DELETE FROM events WHERE id = ?";
                    try (PreparedStatement psEvent = conn.prepareStatement(deleteEventSql)) {
                        psEvent.setInt(1, eventId);
                        psEvent.executeUpdate();
                    }
                }
            } catch (NumberFormatException | SQLException e) {
                e.printStackTrace();
            }
        }
        
        // Redirect back to the schedule page
        response.sendRedirect("scheduleevents.jsp");
    }
}
