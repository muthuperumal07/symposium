/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.symposium;

/**
 *
 * @author Venka
 */


public class Event {
    private final int id;
    private final String name;
    private final String category;
    private final int maxTeamSize;
    private final double prizePool;

    // Constructor, Getters, and Setters
    public Event(int id, String name, String category, int maxTeamSize, double prizePool) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.maxTeamSize = maxTeamSize;
        this.prizePool = prizePool;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getCategory() { return category; }
    public int getMaxTeamSize() { return maxTeamSize; }
    public double getPrizePool() { return prizePool; }
}
