/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.symposium;

/**
 *
 * @author Venka
 */
import java.util.Scanner;

public class main {
    public static void main(String[] args) {
        EventDAO eventDAO = new EventDAO();
        try (Scanner scanner = new Scanner(System.in)) {
            while (true) {
                System.out.println("\n=== Department Symposium Portal ===");
                System.out.println("1. View All Events");
                System.out.println("2. Add New Event");
                System.out.println("3. Exit");
                System.out.print("Choose an option: ");
                
                int choice = scanner.nextInt();
                scanner.nextLine(); // Consume newline
                
                if (choice == 1) {
                    eventDAO.viewEvents();
                } else if (choice == 2) {
                    System.out.print("Enter Event Name: ");
                    String name = scanner.nextLine();
                    System.out.print("Enter Category (e.g., Coding, Gaming): ");
                    String category = scanner.nextLine();
                    System.out.print("Enter Max Team Size: ");
                    int teamSize = scanner.nextInt();
                    System.out.print("Enter Prize Pool (₹): ");
                    double prize = scanner.nextDouble();
                    
                    eventDAO.addEvent(name, category, teamSize, prize);
                } else if (choice == 3) {
                    System.out.println("Exiting portal. Good luck with your project!");
                    break;
                } else {
                    System.out.println("Invalid choice. Please try again.");
                }
            }
        }
    }
}

