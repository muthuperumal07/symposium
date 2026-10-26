/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.symposium;

/**
 *
 * @author Venka
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Databaseconnection {
    private static final String URL = "jdbc:mysql://mysql-30f5004a-muthuselvavenkatesh-6306.e.aivencloud.com:27960/defaultdb?useSSL=true&requireSSL=true";
    private static final String USER = "avnadmin";      // Replace with your MySQL username
    private static final String PASSWORD = System.getenv("DB_PASSWORD");      // Replace with your MySQL password

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
