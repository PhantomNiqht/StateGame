name_array = []
consonants = ["b", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "r", "s", "t", "v", "w", "y", "z", "ch", "th", "sh", "zh"]
after_cons = ["l", "r", "w"]
vowels = ["a", "e", "i", "o", "u"]

name = ""
syllables = 0
total_parts = 0
rand1 = 0
first = false
tempart = ""
temp = ""
symbol = false

puts "\nWelcome to Random Name Generator V3 by Tim Anfilofieff"
puts "\nJust push 'enter' to generate a completely random name. Type anything and press 'enter' to leave."

loop do

	name = ""
	syllables = 0
	total_parts = 0
	rand1 = 0
	first = false
	tempart = ""
	temp = ""
	symbol = false
	
	generate = gets.chomp.downcase
	if generate == ""
		syllables = rand(2..4)
		loop do
			if syllables > 0
				if first == false
					rand1 = rand(0..1)
					if rand1 == 0
						name_array.push("con")
						rand1 = 1
					elsif rand1 == 1
						name_array.push("vow")
						syllables -= 1
						rand1 = 0
					end
					first = true
				else
					if rand1 == 0
						name_array.push("con")
						rand1 = 1
					elsif rand1 == 1
						name_array.push("vow")
						syllables -= 1
						rand1 = 0
					end						
				end
			else
				break
			end
		end
		total_parts = name_array.count
		name_array.count.times do |z|
			tempart = ""
			temp = ""
			if name_array[0] == "con"
				if symbol == false and name_array.count > 2 and name_array.count < total_parts - 2
					rand1 = rand(-10..1)
				else
					rand1 = 0
				end
				if rand1 != 1
					tempart = "#{consonants[rand(0..(consonants.count - 1))]}"
					if tempart != "l" and tempart != "r" and tempart != "w"
						rand1 = rand(-10..2)
						if rand1 >= 0 and rand1 <= 2
							tempart += "#{after_cons[rand1]}"
						end
					end
				else
					tempart = "-"
					symbol = true
				end
				if name[name.length - 1] == "'"
					name += tempart.capitalize
					name_array.delete_at(0)					
				elsif name.length == 0
					name += tempart.capitalize
					name_array.delete_at(0)				
				else
					name += tempart
					name_array.delete_at(0)
				end
			elsif name_array[0] == "vow"
				if symbol == false and name_array.count > 2 and name_array.count < total_parts - 2
					rand1 = rand(-10..1)
				else
					rand1 = 0
				end
				if rand1 != 1
					tempart = "#{vowels[rand(0..(vowels.count - 1))]}"
					rand1 = rand(-3..1)
					if rand1 == 1
						temp = "#{vowels[rand(0..(vowels.count - 1))]}"
						tempart += temp
					end
				else
					tempart = "'"
					symbol = true
					if name[name.length - 1] == "l" or name[name.length - 1] == "r" or name[name.length - 1] == "w"
						name = name[0...-1]
					end
					rand1 = rand(-2..0)
					if rand1 == 0 and name.length > 2
						name = name[0...-1]			
					end
				end
				if name[name.length - 1] == "-"
					rand1 = rand(-2..0)
					if rand1 == 0
						name = name[0...-1]
						name += tempart.capitalize
						name_array.delete_at(0)
					else
						name += tempart.capitalize
						name_array.delete_at(0)
					end
				elsif name.length == 0
					name += tempart.capitalize
					name_array.delete_at(0)				
				else
					name += tempart
					name_array.delete_at(0)
				end
				if name_array.count <= 0
					rand1 = rand(0..1)
					if rand1 == 1
						tempart = "#{consonants[rand(0..(consonants.count - 1))]}"
						name += tempart
					end
				end
			end
		end
		print "#{name} "
	else
		break
	end
end