package com.sfsd.statesgame.names;

import java.util.Scanner;

public class NamesGenerator
{
	public static void main(String[] args)
	{
		//Scanner in = new Scanner(System.in);
        //String s = in.nextLine();
        //System.out.println("You entered string "+s);
        
		String name = "";
		int syllables = 0;
		int rand1 = 0;
		boolean first = false;
		String temp = "";
		boolean symbol = false;
		boolean breakLoop = false;
	}
	
	public static void generateName(int type, String customStart, String customEnd)
	{
		type = 0;
		customStart = "none";
		customEnd = "none";
		
		String[] nameArray;
		String[] consonants = {"b", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "r", "s", "t", "v", "w", "y", "z", "ch", "th", "sh", "zh"};
		String[] afterConsonants = {"l", "r", "w"};
		String[] vowels = {"a", "e", "i", "o", "u"};
		
		
		
		boolean breakLoop0 = false;
		while (breakLoop0 == false)
		{
			String name = "";
			int syllables = 0;
			int totalParts = 0;
			int rand1 = 0;
			boolean first = false;
			String tempArt = "";
			String temp = "";
			boolean symbol = false;
			String generate = "";
			
			if (generate == "")
			{
				if (type == 0)
				{
					syllables = (int) (Math.random() * ((2 - 1) + 1)) + 1;
					System.out.print(syllables);
				}
				else if (type == 1)
				{
					syllables = (int) (Math.random() * ((3 - 2) + 1)) + 2;
				}
				else if (type == 2)
				{
					syllables = (int) (Math.random() * ((4 - 3) + 1)) + 3;
				}
				else
				{
					syllables = 1;
				}
				boolean breakLoop1 = false;
				while (breakLoop1 == false)
				{
					if (syllables > 0)
					{
						if (first == false)
						{
							rand1 = (int) Math.random();
							if (customStart == "none")
							{
								if (rand1 == 0)
								{
									//String[] nameArray = new String[0];
								}
							}
						}
					}
				}
			}
		}
		
	}
}
