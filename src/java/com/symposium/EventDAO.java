/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.symposium;

/**
 *
 * @author Venka
 */
import com.symposium.Databaseconnection;
import com.symposium.Event;
import java.sql.*;
import java.util.List;

public class EventDAO {
    
    public void addEvent(String name, String category, int maxTeamSize, double prizePool) {
        String query = "INSERT INTO events (event_name, category, max_team_size, prize_pool) VALUES (?, ?, ?, ?)";
        try (Connection conn = Databaseconnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, name);
            pstmt.setString(2, category);
            pstmt.setInt(3, maxTeamSize);
            pstmt.setDouble(4, prizePool);
            pstmt.executeUpdate();
            System.out.println("Event successfully added to the portal!");
            
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void viewEvents() {
        String query = "SELECT * FROM events";
        try (Connection conn = Databaseconnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            System.out.println("\n--- Available Symposium Events ---");
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("event_id") + 
                                   " | Name: " + rs.getString("event_name") + 
                                   " | Category: " + rs.getString("category") + 
                                   " | Prize: ₹" + rs.getDouble("prize_pool"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    List<Event> getAllEvents() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    
}

