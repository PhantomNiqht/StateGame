package com.sfsd.statesgame;

import javax.swing.JFrame;

public class Game
{
	
	private final JFrame window = new JFrame();
	
	public Game(int windowX, int windowY, String title)
	{
		window.setSize(windowX, windowY);
		window.setTitle(title);
		window.setResizable(false);
		window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		window.setFocusable(true);
		window.setLocationRelativeTo(null);
		window.setVisible(true);
	}
	
	public JFrame getWindow()
	{
		return window;
	}
}