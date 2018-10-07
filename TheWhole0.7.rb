class Char
	attr_accessor :codename, :details, :location, :knowndetails
	def initialize(codename, firstname, hasmiddlename, middlename, lastname, age, gender, vitality, strength, wits, loyalty)
		@codename = codename
		@details = {}
		@details[:firstname] = firstname
		if hasmiddlename == 1
			@details[:middlename] = middlename
		else
			@details[:middlename] = nil
		end
		@details[:lastname] = lastname
		@details[:age] = age.to_i
		@details[:gender] = gender
		@details[:bd] = {}
		@details[:bd][:month_of_birth]
		@rand1 = rand(0..($w[:maxmonths] - 1))
		@details[:bd][:month_of_birth] = ($w[:months][@rand1])
		@details[:bd][:day_of_birth] = (rand(1..$w[:daysinmonths][@rand1]))
		@details[:bd][:year_of_birth] = ($w[:current_year] - @details[:age])
		if @rand1 > $w[:current_month]
			@details[:age] -= 1
		elsif @rand1 == $w[:current_month]
			if @details[:bd][:day_of_birth] >= $w[:current_day]
				@details[:age] -= 1		
			end
		end
		@details[:country] = (rand(0..($countries.count - 1)))
		@details[:maxvit] = vitality
		@details[:vit] = rand(0..vitality)
		@details[:str] = strength
		@details[:wit] = wits
		@details[:loy] = loyalty
		if @details[:age] >= 50
			@details[:maxvit] -= rand(2..5)
			@details[:vit] = @details[:maxvit]
			@details[:str] -= 1
			@details[:loy] += 1
			if @details[:str] <= 0
				@details[:str] = 1
			end
			if @details[:loy] >= 6
				@details[:loy] = 5
			end
		end
		if @details[:age] <= 15
			@details[:maxvit] -= rand(2..5)
			@details[:vit] = @details[:maxvit]
			@details[:str] -= 1
			@details[:wit] -= 1
			if @details[:str] <= 0
				@details[:str] = 1
			end
			if @details[:wit] <= 0
				@details[:wit] = 1
			end
		end
		@details[:expertise] = []
		if @details[:str] >= 4 and @details[:wit] <= 3
			@details[:expertise].push("Combat Expert")
		elsif @details[:wit] >= 4 and @details[:str] <= 3
			@details[:expertise].push("Medical Expert")
		elsif @details[:str] >= 4 and @details[:wit] >= 4
			@details[:expertise].push("Reconnaissance Expert")
			if @details[:str] > @details[:wit]
				@details[:expertise].push("Combat Expert")
			elsif @details[:str] < @details[:wit]
				@details[:expertise].push("Medical Expert")
			end
		end
		if @details[:str] >= 3 and @details[:wit] >= 3
			@rand1 = rand(0..2)
			if @rand1 == 2
				@details[:expertise].push("Weapons Expert")
			elsif @rand1 == 1
				@details[:expertise].push("Diplomat")
			end
		end
		if @details[:wit] >= 5
			@rand1 = rand(0..1)
			if @rand1 == 1
				@details[:expertise].push("Science Expert")
			end
		end
		if @details[:expertise].count <= 1
			if @details[:age] > 27
				@details[:expertise].push("Leadership")
			elsif @details[:age] <= 27
				@details[:expertise].push("Potential")
			end
		end
		@location = ["current country", "current building", "Unknown", "Unknown"]
		@knowndetails = [1, 1, 1, 1, 1]
	end
	
	def birthday
		@details[:age] += 1
	end
end

class Country
	attr_accessor :details, :events
	def initialize(codename, name, slogan, direction)
		@details = {}
		@details[:codename] = codename
		@details[:name] = name
		@details[:slogan] = slogan
		@details[:latitude] = direction
		@details[:sq_mi] = (rand(2500..4500000))
		@details[:pop] = 0
		10.times do |z|
			@details[:pop] += ((@details[:sq_mi] / 10) * rand(1.0..100.0)).round.to_i
		end
		@details[:strong] = 0
		@details[:value] = 0
		@details[:oil] = 0
		@rand1 = [rand(0.2..8.0), rand(0.2..8.0), rand(0.2..8.0)]
		3.times do |z|
			if z == 0
				@rand2 = :strong
			elsif z == 1
				@rand2 = :value
			elsif z == 2
				@rand2 = :oil
			end
			if @details[:latitude] == $w[:resource_sat][@rand2]
				80.times do |z2|
					@details[@rand2] += ((@details[:sq_mi] / 80) * rand(10000.0 * @rand1[z]..1000000.0 * @rand1[z])).round.to_i
				end			
			else
				80.times do |z2|
					@details[@rand2] += ((@details[:sq_mi] / 80) * rand(1.0 * @rand1[z]..100000.0 * @rand1[z])).round.to_i
				end	
			end
		end
		rand1 = @details[:name]
		rand2 = rand1[rand1.length - 1]
		rand3 = rand(0..2)
		if rand2 == "a" or rand2 == "e" or rand2 == "i" or rand2 == "o" or rand2 == "u"
			if rand3 == 0
				@details[:person_name] = ("#{rand1}n")
			elsif rand3 == 1
				@details[:person_name] = ("#{rand1}sh")
			elsif rand3 == 2
				@details[:person_name] = ("#{rand1}k")
			end
		else
			if rand3 == 0
				@details[:person_name] = ("#{rand1}ese")
			elsif rand3 == 1
				@details[:person_name] = ("#{rand1}ian")
			elsif rand3 == 2
				@details[:person_name] = ("#{rand1}ish")
			end	
		end
		@details[:born] = {}
		@details[:died] = {}
		@details[:born][:hourly] = 0
		@details[:born][:daily] = 0
		@details[:born][:monthly] = 0
		@details[:born][:yearly] = 0
		@details[:died][:hourly] = 0
		@details[:died][:daily] = 0
		@details[:died][:monthly] = 0
		@details[:died][:yearly] = 0
		@events = []
	end
	def born(amount = 0)
		@details[:pop] += amount
		@details[:born][:hourly] += amount
		@details[:born][:daily] += amount
		@details[:born][:monthly] += amount
		@details[:born][:yearly] += amount
	end
	def died(amount = 0)
		@details[:pop] -= amount
		@details[:died][:hourly] += amount
		@details[:died][:daily] += amount
		@details[:died][:monthly] += amount
		@details[:died][:yearly] += amount		
	end
end

class String
def black;          "\e[30m#{self}\e[0m" end
def red;            "\e[31m#{self}\e[0m" end
def green;          "\e[32m#{self}\e[0m" end
def yellow;         "\e[33m#{self}\e[0m" end
def blue;           "\e[34m#{self}\e[0m" end
def magenta;        "\e[35m#{self}\e[0m" end
def cyan;           "\e[36m#{self}\e[0m" end
def gray;           "\e[37m#{self}\e[0m" end

def bg_black;       "\e[40m#{self}\e[0m" end
def bg_red;         "\e[41m#{self}\e[0m" end
def bg_green;       "\e[42m#{self}\e[0m" end
def bg_brown;       "\e[43m#{self}\e[0m" end
def bg_blue;        "\e[44m#{self}\e[0m" end
def bg_magenta;     "\e[45m#{self}\e[0m" end
def bg_cyan;        "\e[46m#{self}\e[0m" end
def bg_gray;        "\e[47m#{self}\e[0m" end

def bold;           "\e[1m#{self}\e[0m" end
def italic;         "\e[3m#{self}\e[0m" end
def underline;      "\e[4m#{self}\e[0m" end
def blink;          "\e[5m#{self}\e[0m" end
def reverse_color;  "\e[7m#{self}\e[0m" end
end

def gen_name(type, cust_start = "none", cust_end = "none")

	name_array = []
	consonants = ["b", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "r", "s", "t", "v", "w", "y", "z", "ch", "th", "sh", "zh"]
	after_cons = ["l", "r", "w"]
	vowels = ["a", "e", "i", "o", "u"]

	loop do

		name = ""
		syllables = 0
		total_parts = 0
		rand1 = 0
		first = false
		tempart = ""
		temp = ""
		symbol = false
		generate = ""
		
		if generate == ""
			if type == 0
				syllables = rand(1..2)
			elsif type == 1
				syllables = rand(2..3)
			elsif type == 2
				syllables = rand(3..4)
			elsif type == "1 syll"
				syllables = 1
			end
			loop do
				if syllables > 0
					if first == false
						rand1 = rand(0..1)
						if cust_start == "none"
							if rand1 == 0
								name_array.push("con")
								rand1 = 1
							elsif rand1 == 1
								name_array.push("vow")
								syllables -= 1
								rand1 = 0
							end
						elsif cust_start == "con"
							name_array.push("con")
							rand1 = 1
						elsif cust_start == "vow"
							name_array.push("vow")
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
				elsif syllables <= 0
					if cust_end == "con"
						if name_array[-1] == "con"
							name_array.push("vow")
							cust_end = "check"
						else
							cust_end = "check"
						end
					elsif cust_end == "vow"
						if name_array[-1] == "vow"
							name_array.push("con")
							cust_end = "none"
						else
							cust_end = "none"
						end
					else
						break
					end
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
							if cust_end != "check"
								tempart = "#{consonants[rand(0..(consonants.count - 1))]}"
								name += tempart
							end
						end
					end
				end
			end
			if not name.include?("-") and not name.include?("'")
				name.downcase.capitalize
			end
			return name
		else
			break
		end
	end
end

def gen_gender(weight, name)
	if weight == false
		rand1 = rand(0..1)
		if rand1 == 0
			return "Male"
		elsif rand1 == 1
			return "Female"
		end
	elsif weight == true
		if name[name.length - 1] == "a" or name[name.length - 1] == "i" or name[name.length - 1] == "u"
			return "Female"
		elsif name[name.length - 1] == "e" or name[name.length - 1] == "o"
			return "Male"
		else
			rand1 = rand(0..1)
			if rand1 == 0
				return "Male"
			elsif rand1 == 1
				return "Female"
			end		
		end
	end
end

def gen_age(type)
	if type == 0
		return rand(11..15)
	elsif type == 1
		return rand(16..20)
	elsif type == 2
		return rand(21..29)
	elsif type == 3
		return rand(30..49)
	elsif type == 4
		return rand(50..70)
	end
end

$w = {}
$tw = []
$p = []
$pa = []
$countries = []
$infos = [1, 1, 1, 1, 1, 1]
$tracking = [-1, -1, -1]
$d = "$"

def gen_country(codename, slogan, direction)
	$countries.push(Country.new(codename, "#{gen_name(2)}", slogan, direction))
end

def whole_char(codename, firstname, hasmiddlename, middlename, lastname, age, gender, vitality, strength, wits, loyalty)
	$tw.push(Char.new(codename, firstname, hasmiddlename, middlename, lastname, age, gender, vitality, strength, wits, loyalty))
end

def show_the_world
	puts "\n\t\tPlanet " + "#{$w[:name]}".yellow.bold
	puts "\tHome of the " + "#{$w[:person_name]}".yellow.bold + "."
	puts "\n\t\tPlanet Information:".yellow
	puts "\t#{$w[:water]}%".yellow.bold + " of the surface is salt water."
	puts "\tThe planet tilts at " + "#{$w[:tilt]}".yellow.bold + " degrees."
	puts "\n\t\tChronological Information:".yellow
	puts "\tThere are " + "#{$w[:maxhours]}".yellow.bold + " hours in a day."
	puts "\tThere are " + "#{$w[:maxdays]}".yellow.bold + " days in a year."
	puts "\tThere are " + "#{$w[:maxmonths]}".yellow.bold + " unique months in a single year. These months are:"
	rand1 = 0
	$w[:months].each do |month_name|
		if month_name.length > rand1
			rand1 = month_name.length
		end
	end
	rand1 += 1
	$w[:maxmonths].times do |z|
		puts "\t\tMonth " + "#{$w[:months][z]}".yellow.bold + "," + (" " * (rand1 - $w[:months][z].length)) + "has " + "#{$w[:daysinmonths][z]}".yellow.bold + " calendar days."
	end
end

def show_the_whole
	rand3 = 0
	$tw.each do |whole|
		if whole.codename.length > rand3
			rand3 = whole.codename.length
		end
	end
	$tw.count.times do |z|
		rand1 = $tw[z].codename.split(" ")
		rand2 = true
		if z == 0
			puts "\nThe Overlord Triad"
			if $tw[z].knowndetails[0] == 0
				rand2 = false
			end
		elsif z >= 1 and z <= 2
			if $tw[z].knowndetails[0] == 0
				rand2 = false
			end		
		elsif z == 3
			puts "\nThe Silent Overlord"
			if $tw[z].knowndetails[0] == 0
				rand2 = false
			end
		elsif z >= 4
			if $tw[z - (z % 4)].knowndetails[0] == 1 or $tw[z - (z % 4) + 1].knowndetails[0] == 1 or $tw[z - (z  % 4) + 2].knowndetails[0] == 1 or $tw[z - (z % 4) + 3].knowndetails[0] == 1
				if z % 4 == 0
					puts ""
					puts "The #{rand1[0]} Order"
				end
			else
				if z % 4 == 0
					puts ""
					puts "The #{"?" * rand1[0].length} Order"
				end
				rand2 = false
			end
		end
		if rand2 == true
			if $tw[z].knowndetails[0] == 0
				print "\t" + "#{rand1[0]}" + " " + ("?" * rand1[1].length) + (" " * (rand3 + 5 - $tw[z].codename.length))

			elsif $tw[z].knowndetails[0] == 1
				dr_puts_whole($tw[z], "print", rand3 + 5)
			end
		elsif rand2 == false
			print "\t" + ("?" * rand1[0].length) + " " + ("?" * rand1[1].length)	 + (" " * (rand3 + 5 - $tw[z].codename.length))	
		end
		if z % 4 == 0 and z >= 4
			print "\n"
		end
	end
	puts " "
end

def show_the_countries
	rand1 = [0, 0, 0, 0, 0]
	$countries.each do |country|
		if country.details[:latitude] == "Far-North"
			rand1[0] += 1
		elsif country.details[:latitude] == "Mid-North"
			rand1[1] += 1
		elsif country.details[:latitude] == "Equatorial"
			rand1[2] += 1
		elsif country.details[:latitude] == "Mid-South"
			rand1[3] += 1
		elsif country.details[:latitude] == "Far-South"
			rand1[4] += 1
		end
	end
	if rand1[0] > 0
		puts "\nFar Northern Countries:".yellow
		$countries.each do |country|
			if country.details[:latitude] == "Far-North"
				puts "\t[#{country.details[:codename]}] " + "#{country.details[:name]}".yellow.bold + ", the #{country.details[:slogan]} country."
			end
		end
	end
	if rand1[1] > 0
		puts "\nMid Northern Countries:".yellow
		$countries.each do |country|
			if country.details[:latitude] == "Mid-North"
				puts "\t[#{country.details[:codename]}] " + "#{country.details[:name]}".yellow.bold + ", the #{country.details[:slogan]} country."
			end
		end
	end
	if rand1[2] > 0
		puts "\nEquatorial Countries:".yellow
		$countries.each do |country|
			if country.details[:latitude] == "Equatorial"
				puts "\t[#{country.details[:codename]}] " + "#{country.details[:name]}".yellow.bold + ", the #{country.details[:slogan]} country."
			end
		end
	end
	if rand1[3] > 0
		puts "\nMid Southern Countries:".yellow
		$countries.each do |country|
			if country.details[:latitude] == "Mid-South"
				puts "\t[#{country.details[:codename]}] " + "#{country.details[:name]}".yellow.bold + ", the #{country.details[:slogan]} country."
			end
		end
	end
	if rand1[4] > 0
		puts "\nFar Southern Countries:".yellow
		$countries.each do |country|
			if country.details[:latitude] == "Far-South"
				puts "\t[#{country.details[:codename]}] " + "#{country.details[:name]}".yellow.bold + ", the #{country.details[:slogan]} country."
			end
		end
	end
end

def show_the_missions
	if true
		puts "\n[M0] " + "Gather Information: ".yellow.bold + "Acquire exploitable information about members of the Whole."
	else
		puts "[M0] " + "Gather Information: ".black.bold + "Acquire exploitable information about members of the Whole."
	end
end

def show_mission_info(mission)
	if mission == "m0"
		puts "\n[M0] " + "Gather Information".yellow.bold
		puts "\tRequirements: ".yellow + "1+".yellow.bold + " Units, " + "?? ".yellow.bold + "hours, and " + "$2,000 ".yellow.bold + "equipment costs."
		puts "\tGoal:         ".yellow + "Acquire exploitable information about members of the Whole."
		puts "\tRewards:      ".yellow
		puts "\t              [" + "1".yellow.bold + " + " + "RR".magenta.bold + " + " + "Risk".red.bold + " / " + "6".yellow.bold + "] = " + "3-8 ".yellow.bold + "pieces of useful information."
	end
end

def show_whole_info(whole)
	if whole.knowndetails[3] == 1
		if whole.details[:vit] == (whole.details[:maxvit] * 1.0).round.to_i
			puts "\n\t\t#{whole.codename}".green.bold
		elsif whole.details[:vit] < (whole.details[:maxvit]* 1.0).round.to_i and whole.details[:vit] >= (whole.details[:maxvit] * 0.5).round.to_i
			puts "\n\t\t#{whole.codename}".yellow.bold
		elsif whole.details[:vit] < (whole.details[:maxvit] * 0.5).round.to_i and whole.details[:vit] > (whole.details[:maxvit] * 0.0).round.to_i
			puts "\n\t\t#{whole.codename}".red.bold
		elsif whole.details[:vit] <= (whole.details[:maxvit] * 0.0).round.to_i
			puts "\n\t\t#{whole.codename} - Deceased".black.bold
		end
	else
		puts "\n\t\t#{whole.codename}"		
	end
	puts "\n\tBirth Name:".yellow
	print "\t\t   "
	if whole.knowndetails[1] == 1
		print whole.details[:firstname] + " "
		if whole.details[:middlename] != nil
		print whole.details[:middlename] + " "
		end
		puts whole.details[:lastname]
	else
		print ("?" * whole.details[:firstname].length) + " "
		if whole.details[:middlename] != nil
		print ("?" * whole.details[:middlename].length) + " "
		end
		puts ("?" * whole.details[:lastname].length)
	end
	if whole.knowndetails[2] == 1
		rand1 = " I don't get it "
		rand2 = whole.details[:bd][:day_of_birth].to_s
		rand2 = rand2[rand2.length - 1]
		if whole.details[:bd][:day_of_birth] < 11 or whole.details[:bd][:day_of_birth] > 20
			if rand2 == "1"
				rand1 = "st"
			elsif rand2 == "2"
				rand1 = "nd"
			elsif rand2 == "3"
				rand1 = "rd"
			else
				rand1 = "th"
			end
		else
			rand1 = "th"
		end
		puts "\n\tBirthdate:     ".yellow + "#{whole.details[:bd][:month_of_birth]} #{whole.details[:bd][:day_of_birth]}#{rand1}, #{whole.details[:bd][:year_of_birth]}"
		puts "\tBirth Country: ".yellow + "#{$countries[whole.details[:country]].details[:name]}"
		puts "\tAge:           ".yellow + "#{whole.details[:age]}"
		puts "\tGender:        ".yellow + "#{whole.details[:gender]}"
	else
		puts "\n\tBirthdate:     ".yellow + "Unknown"
		puts "\tBirth Country: ".yellow + "Unknown"
		puts "\tAge:           ".yellow + "Unknown"
		puts "\tGender:        ".yellow + "Unknown"
	end
	if whole.knowndetails[3] == 1
		puts "\n\tVitality:".yellow + "  [" + ("♥".red.bold * whole.details[:vit]) + ("♥".black.bold * (whole.details[:maxvit] - whole.details[:vit])) + "] " + "#{whole.details[:vit]}".red.bold + "/#{whole.details[:maxvit]}"
		puts "\tStrength:".yellow + "  [" + ("♠".magenta.bold * whole.details[:str]) + "] #{whole.details[:str]}"
		puts "\tWits:".yellow + "      [" + ("♦".green.bold * whole.details[:wit]) + "] #{whole.details[:wit]}"
		puts "\tLoyalty:".yellow + "   [" + ("♣".cyan.bold * whole.details[:loy]) + ("♣".black.bold * (5 - whole.details[:loy])) + "] " + "#{whole.details[:loy]}".cyan.bold + "/5"
	else
		puts "\n\tVitality:".yellow + "  [Unknown]"
		puts "\tStrength:".yellow + "  [Unknown]"
		puts "\tWits:".yellow + "      [Unknown]"
		puts "\tLoyalty:".yellow + "   [Unknown]"
	end
	if whole.knowndetails[4] == 1
		puts "\n\tExpertise:".yellow
		whole.details[:expertise].count.times do |z|
			puts "\t\t   #{whole.details[:expertise][z]}".yellow.bold
		end
	else
		puts "\n\tExpertise:".yellow
		puts "\t\t   Unknown"
	end
end

def show_country_info(country)
	puts "\n\t\t#{country.details[:name]}".yellow.bold + ", #{country.details[:latitude]}"
	puts "\tThe #{country.details[:slogan]} country."
	puts ""
	puts "\tPopulation:     ".yellow + "#{country.details[:pop].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
	rand1 = 0
	rand2 = 0
	rand3 = [:hourly, :daily, :monthly, :yearly]
	4.times do |z|
		if country.details[:born][rand3[z]].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.length
			rand1 = country.details[:born][rand3[z]].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.length
		end
		if country.details[:died][rand3[z]].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.length > rand2
			rand2 = country.details[:died][rand3[z]].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.length
		end
	end
	puts "\t\tChange, Current Hour:  ".yellow + "Births:".yellow + " #{country.details[:born][:hourly].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}" + (" " * (rand1 - country.details[:born][:hourly].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.length)) + " Deaths:".yellow + " #{country.details[:died][:hourly].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}" + (" " * (rand2- country.details[:died][:hourly].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.length)) + " Difference:".yellow + " #{(country.details[:born][:hourly] - country.details[:died][:hourly]).round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
	puts "\t\tChange, Current Day:   ".yellow + "Births:".yellow + " #{country.details[:born][:daily].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}" + (" " * (rand1 - country.details[:born][:daily].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.length)) + " Deaths:".yellow + " #{country.details[:died][:daily].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}" + (" " * (rand2 - country.details[:died][:daily].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.length)) + " Difference:".yellow + " #{(country.details[:born][:daily] - country.details[:died][:daily]).round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
	puts "\t\tChange, Current Month: ".yellow + "Births:".yellow + " #{country.details[:born][:monthly].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}" + (" " * (rand1 - country.details[:born][:monthly].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.length)) + " Deaths:".yellow + " #{country.details[:died][:monthly].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}" + (" " * (rand2 - country.details[:died][:monthly].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.length)) + " Difference:".yellow + " #{(country.details[:born][:monthly] - country.details[:died][:monthly]).round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
	puts "\t\tChange, Current Year:  ".yellow + "Births:".yellow + " #{country.details[:born][:yearly].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}" + (" " * (rand1 - country.details[:born][:yearly].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.length)) + " Deaths:".yellow + " #{country.details[:died][:yearly].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}" + (" " * (rand2 - country.details[:died][:yearly].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.length)) + " Difference:".yellow + " #{(country.details[:born][:yearly] - country.details[:died][:yearly]).round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
	puts "\tResource Value: ".yellow + "#{$d}#{(country.details[:strong] + country.details[:value] + country.details[:oil]).round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
	puts "\t\tStrong Metals:     ".yellow + "#{$d}#{country.details[:strong].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
	puts "\t\tPrecious Metals:   ".yellow + "#{$d}#{country.details[:value].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
	puts "\t\tOil and Petroleum: ".yellow + "#{$d}#{country.details[:oil].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
	puts "\tSquare Mileage: ".yellow + "#{country.details[:sq_mi].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
end

def sort_whole_info(type)
	rand1 = [0, 0, 0, 0, 0, 0, 0, 0]
	rand3 = ["Combat Expert", "Medical Expert", "Reconnaissance Expert", "Weapons Expert", "Science Expert", "Diplomat", "Leadership", "Potential"]
	8.times do |z|
		rand2 = rand3[z]
		$tw.each do |whole|
			if whole.details[:expertise].include?(rand2) and whole.knowndetails[4] == 1
				rand1[z] += 1
			end
		end
	end
	if type == "expertise"
		puts "\nSorting the Whole by Expertise"
		if rand1[0] > 0
			puts "\nCombat Experts:"
			$tw.each do |whole|
				if whole.details[:expertise].include?("Combat Expert") and whole.knowndetails[4] == 1
					dr_puts_whole(whole)
				end
			end
		else
			puts "\nCombat Experts:" + " None".red.bold
		end
		if rand1[1] > 0
			puts "\nMedical Experts:"
			$tw.each do |whole|
				if whole.details[:expertise].include?("Medical Expert") and whole.knowndetails[4] == 1
					dr_puts_whole(whole)
				end
			end
		else
			puts "\nMedical Experts:" + " None".red.bold
		end
		if rand1[2] > 0
			puts "\nReconnaissance Experts:"
			$tw.each do |whole|
				if whole.details[:expertise].include?("Reconnaissance Expert") and whole.knowndetails[4] == 1
					dr_puts_whole(whole)
				end
			end
		else
			puts "\nReconnaissance Experts:" + " None".red.bold
		end
		if rand1[3] > 0
			puts "\nWeapons Experts:"
			$tw.each do |whole|
				if whole.details[:expertise].include?("Weapons Expert") and whole.knowndetails[4] == 1
					dr_puts_whole(whole)
				end
			end
		else
			puts "\nWeapons Experts:" + " None".red.bold
		end
		if rand1[4] > 0
			puts "\nScience Experts:"
			$tw.each do |whole|
				if whole.details[:expertise].include?("Science Expert") and whole.knowndetails[4] == 1
					dr_puts_whole(whole)
				end
			end
		else
			puts "\nScience Experts:" + " None".red.bold
		end
		if rand1[5] > 0
			puts "\nDiplomats:"
			$tw.each do |whole|
				if whole.details[:expertise].include?("Diplomat") and whole.knowndetails[4] == 1
					dr_puts_whole(whole)
				end
			end
		else
			puts "\nDiplomats:" + " None".red.bold
		end
		if rand1[6] > 0
			puts "\nLeaders:"
			$tw.each do |whole|
				if whole.details[:expertise].include?("Leadership") and whole.knowndetails[4] == 1
					dr_puts_whole(whole)
				end
			end
		else
			puts "\nLeaders:" + " None".red.bold
		end
		if rand1[7] > 0
			puts "\nHave Much Potential:"
			$tw.each do |whole|
				if whole.details[:expertise].include?("Potential") and whole.knowndetails[4] == 1
					dr_puts_whole(whole)
				end
			end
		else
			puts "\nHave Much Potential:" + " None".red.bold
		end
	end
end

def sort_country_info(type)
	if type == "size"
		rand1 = []
		rand3 = 0
		$countries.each do |country|
			if (country.details[:name].length + country.details[:codename].length) > rand3
				rand3 = (country.details[:name].length + country.details[:codename].length)
			end
			if rand1.count == 0
				rand1.push(country)
			else
				rand2 = 0
				rand1.count.times do |z|
					if country.details[:sq_mi] > rand1[z].details[:sq_mi] and rand2 == 0
						rand1.insert(z, country)
						rand2 = 1
					elsif country.details[:sq_mi] < rand1[z].details[:sq_mi] and rand2 == 0
						if z == rand1.count - 1
						rand1.push(country)
						rand2 = 1
						end
					end
				end
			end
		end
		puts "\nSorting the countries by Square Mileage"
		puts ""
		rand1.each do |country|
			puts "\t[#{country.details[:codename]}] " + "#{country.details[:name]}".yellow.bold + (" " * (rand3 + 1 - (country.details[:name].length + country.details[:codename].length))) + "#{country.details[:sq_mi].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
		end
	elsif type == "population"
		rand1 = []
		rand3 = 0
		$countries.each do |country|
			if (country.details[:name].length + country.details[:codename].length) > rand3
				rand3 = (country.details[:name].length + country.details[:codename].length)
			end
			if rand1.count == 0
				rand1.push(country)
			else
				rand2 = 0
				rand1.count.times do |z|
					if country.details[:pop] > rand1[z].details[:pop] and rand2 == 0
						rand1.insert(z, country)
						rand2 = 1
					elsif country.details[:pop] < rand1[z].details[:pop] and rand2 == 0
						if z == rand1.count - 1
						rand1.push(country)
						rand2 = 1
						end
					end
				end
			end
		end
		puts "\nSorting the countries by Population"
		puts ""
		rand1.each do |country|
			puts "\t[#{country.details[:codename]}] " + "#{country.details[:name]}".yellow.bold + (" " * (rand3 + 1 - (country.details[:name].length + country.details[:codename].length))) + "#{country.details[:pop].round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
		end
	elsif type == "resources"
		rand1 = []
		rand3 = 0
		$countries.each do |country|
			if (country.details[:name].length + country.details[:codename].length) > rand3
				rand3 = (country.details[:name].length + country.details[:codename].length)
			end
			if rand1.count == 0
				rand1.push(country)
			else
				rand2 = 0
				rand1.count.times do |z|
					if (country.details[:strong] + country.details[:value] + country.details[:oil]) > (rand1[z].details[:strong] + rand1[z].details[:value] + rand1[z].details[:oil]) and rand2 == 0
						rand1.insert(z, country)
						rand2 = 1
					elsif (country.details[:strong] + country.details[:value] + country.details[:oil]) < (rand1[z].details[:strong] + rand1[z].details[:value] + rand1[z].details[:oil]) and rand2 == 0
						if z == rand1.count - 1
						rand1.push(country)
						rand2 = 1
						end
					end
				end
			end
		end
		puts "\nSorting the countries by Resource Value"
		puts ""
		rand1.each do |country|
			puts "\t[#{country.details[:codename]}] " + "#{country.details[:name]}".yellow.bold + (" " * (rand3 + 1 - (country.details[:name].length + country.details[:codename].length))) + "#{$d}#{(country.details[:strong] + country.details[:value] + country.details[:oil]).round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
		end
	end
end

def set_tracking(trackslot, wholeindex)
	$tracking[trackslot] = wholeindex.to_i
end

def dr_puts_whole(whole, type = "puts", spacer = 0)
	if type == "puts"
		rand1 = whole.codename.split(' ')
		if whole.knowndetails[3] == 1
			if whole.details[:vit] == (whole.details[:maxvit] * 1.0).round.to_i
				puts "\t[#{rand1[0][0]}#{rand1[1][0]}] " + "#{whole.codename}".green.bold
			elsif whole.details[:vit] < (whole.details[:maxvit] * 1.0).round.to_i and whole.details[:vit] >= (whole.details[:maxvit] * 0.5).round.to_i
				puts "\t[#{rand1[0][0]}#{rand1[1][0]}] " + "#{whole.codename}".yellow.bold
			elsif whole.details[:vit] < (whole.details[:maxvit] * 0.5).round.to_i and whole.details[:vit] > (whole.details[:maxvit] * 0.0).round.to_i
				puts "\t[#{rand1[0][0]}#{rand1[1][0]}] " + "#{whole.codename}".red.bold
			elsif whole.details[:vit] <= (whole.details[:maxvit] * 0.0).round.to_i
				puts "\t[" + "#{rand1[0][0]}#{rand1[1][0]}".red.bold + "] " + "#{whole.codename}".black.bold
			end
		else
			puts "\t[#{rand1[0][0]}#{rand1[1][0]}] " + "#{whole.codename}"
		end
	elsif type == "print"
		rand1 = whole.codename.split(' ')
		if whole.knowndetails[3] == 1
			if whole.details[:vit] == (whole.details[:maxvit] * 1.0).round.to_i
				print "\t[#{rand1[0][0]}#{rand1[1][0]}] " + "#{whole.codename}".green.bold
			elsif whole.details[:vit] < (whole.details[:maxvit] * 1.0).round.to_i and whole.details[:vit] >= (whole.details[:maxvit] * 0.5).round.to_i
				print "\t[#{rand1[0][0]}#{rand1[1][0]}] " + "#{whole.codename}".yellow.bold
			elsif whole.details[:vit] < (whole.details[:maxvit] * 0.5).round.to_i and whole.details[:vit] > (whole.details[:maxvit] * 0.0).round.to_i
				print "\t[#{rand1[0][0]}#{rand1[1][0]}] " + "#{whole.codename}".red.bold
			elsif whole.details[:vit] <= (whole.details[:maxvit] * 0.0).round.to_i
				print "\t[" + "#{rand1[0][0]}#{rand1[1][0]}".red.bold + "] " + "#{whole.codename}".black.bold
			end
		else
			print "\t[#{rand1[0][0]}#{rand1[1][0]}] " + "#{whole.codename}"
		end
		print (" " * (spacer - "[AA] #{whole.codename}".length))
	elsif type == "print_no_tab"
		rand1 = whole.codename.split(' ')
		if whole.knowndetails[3] == 1
			if whole.details[:vit] == (whole.details[:maxvit] * 1.0).round.to_i
				print "[#{rand1[0][0]}#{rand1[1][0]}] " + "#{whole.codename}".green.bold
			elsif whole.details[:vit] < (whole.details[:maxvit] * 1.0).round.to_i and whole.details[:vit] >= (whole.details[:maxvit] * 0.5).round.to_i
				print "[#{rand1[0][0]}#{rand1[1][0]}] " + "#{whole.codename}".yellow.bold
			elsif whole.details[:vit] < (whole.details[:maxvit] * 0.5).round.to_i and whole.details[:vit] > (whole.details[:maxvit] * 0.0).round.to_i
				print "[#{rand1[0][0]}#{rand1[1][0]}] " + "#{whole.codename}".red.bold
			elsif whole.details[:vit] <= (whole.details[:maxvit] * 0.0).round.to_i
				print "[" + "#{rand1[0][0]}#{rand1[1][0]}".red.bold + "] " + "#{whole.codename}".black.bold
			end
		else
			print "[#{rand1[0][0]}#{rand1[1][0]}] " + "#{whole.codename}"		
		end
	end
end

def show_quick_info
	if $infos[0] == 1
		rand1 = " I don't get it "
		rand2 = $w[:current_day].to_s
		rand2 = rand2[rand2.length - 1]
		if $w[:current_day] < 11 or $w[:current_day] > 20
			if rand2 == "1"
				rand1 = "st"
			elsif rand2 == "2"
				rand1 = "nd"
			elsif rand2 == "3"
				rand1 = "rd"
			else
				rand1 = "th"
			end
		else
			rand1 = "th"
		end
		print "  |  ".yellow + "Today's Date: ".yellow + "#{$w[:months][$w[:current_month]]} #{$w[:current_day]}#{rand1}, #{$w[:current_year]}".yellow.bold
	end
	if $infos[1] == 1
		print "  |  ".yellow + "Current Hour: ".yellow + "#{$w[:current_hour]} of #{$w[:maxhours]}".yellow.bold
	else
		print ""
	end
	if $infos[2] == 1
		rand1 = 0
		$w[:current_month].times do |z|
			rand1 += $w[:daysinmonths][z]
		end
		rand1 += $w[:current_day]
		rand2 = $w[:maxdays] - rand1
		print "  |  ".yellow + " Days until New Year: ".yellow + "#{rand2} days".yellow.bold
	else
		print ""
	end
	if $infos[0] == 1 or $infos[1] == 1 or $infos[2] == 1
		puts "  |  ".yellow
	end
	if $infos[3] == 1
		print "  |  ".yellow + "Upcoming Months: ".yellow
		rand1 = $w[:current_month]
		rand2 = rand1 - 1
		if rand2 < 0
			print "#{$w[:months][$w[:maxmonths] + rand2]} ".black.bold
		elsif rand2 >= 0
			print "#{$w[:months][rand2]} ".black.bold
		end
		print "#{$w[:months][$w[:current_month]]} ".yellow.bold + "-[" + "#{$w[:daysinmonths][$w[:current_month]].to_i - $w[:current_day]}".yellow.bold + "]> "
		rand3 = 0
		3.times do |z|
			rand1 = $w[:current_month]
			rand2 = rand1 + z + 1
			if rand2 > $w[:maxmonths] - 1
				print "#{$w[:months][0 + (z - rand3)]}".yellow
			elsif rand2 <= $w[:maxmonths] - 1
				print "#{$w[:months][$w[:current_month] + z + 1]}".yellow	
				rand3 += 1
			end
			if z < 2
				print " "
			end
		end
		puts "  |  ".yellow
	end
	if $infos[4] == 1
		$infos[5].times do |z|
			print "  |  ".yellow + "Tracking: ".yellow
			if $tracking[z] == -1
				print "[??]" + " You are not currently tracking anyone. Type 'track #{z.to_s} ' with a codename to track that person.".yellow
			else
				dr_puts_whole($tw[$tracking[z]], "print_no_tab")
				print " was last known to be in".yellow + " #{$tw[$tracking[z]].location[2]}".yellow.bold + ", at the".yellow + " #{$tw[$tracking[z]].location[3]}".yellow.bold
			end
			puts "  |  ".yellow
		end
	end
end

def check_for_birthdays
	$tw.each do |whole|
		if whole.knowndetails[0] == 1 and whole.knowndetails[2] == 1
			rand1 = "they"
			if whole.details[:gender] == "Male"
				rand1 = "he"
			elsif whole.details[:gender] == "Female"
				rand1 = "she"
			end
			if whole.details[:bd][:month_of_birth] == $w[:months][$w[:current_month]] and whole.details[:bd][:day_of_birth] == $w[:current_day]
				if $w[:current_year] - whole.details[:age] - whole.details[:bd][:year_of_birth] > 0
					print "  |  "
					dr_puts_whole(whole, "print_no_tab")
					puts " has a birthday today! #{rand1.capitalize} is now #{whole.details[:age] + 1} years old."
					whole.birthday
				else
					print "  |  "
					dr_puts_whole(whole, "print_no_tab")
					puts " has a birthday today! #{rand1.capitalize} is now #{whole.details[:age]} years old."	
				end
			end
		end
	end
end

def hourly_country_update
	$countries.each do |country|
		rand1 = rand(0..(((country.details[:pop] / 1000) / 24).round.to_i))
		rand2 = rand(0..(((country.details[:pop] / 3000) / 24).round.to_i))
		country.born(rand1)
		country.died(rand2)
	end
end

def next_day
	$w[:current_day] += 1
	$countries.each do |country|
		country.details[:born][:daily] = 0
		country.details[:died][:daily] = 0
	end
	if $w[:current_day] > $w[:daysinmonths][$w[:current_month]]
		$w[:current_day] = 1
		$w[:current_month] += 1
		$countries.each do |country|
			country.details[:born][:monthly] = 0
			country.details[:died][:monthly] = 0
		end
	end
	if $w[:current_month] > $w[:maxmonths] - 1
		$w[:current_month] = 0
		$w[:current_year] += 1
		$countries.each do |country|
			country.details[:born][:yearly] = 0
			country.details[:died][:yearly] = 0
		end
	end
end

def pass_time(amount = 1)
	loop do
		if amount > 0
			amount -= 1
			$w[:current_hour] += 1
			if $w[:current_hour] > $w[:maxhours]
				$w[:current_hour] = 1
				next_day
			end
			$countries.each do |country|
				country.details[:born][:hourly] = 0
				country.details[:died][:hourly] = 0
			end
			hourly_country_update
		else
			break
		end
	end
end

adjectives = [

	"Arc", "Angled", "Appropriate", "Accurate",
	"Belled", "Boring", "Blind", "Bloody",
	"Cool", "Crazy", "Catastrophic", "Casted",
	"Dangerous", "Docked", "Dizzy", "Deadly",
	"Electric", "Energetic", "Evil", "Everlasting",
	"Frilled", "Fancy", "Frightened", "Fell",
	"Great", "Giant", "Greeted", "Gorgeous",
	"High", "Hindered", "Hollow", "Horrid",
	"Inked", "Isle", "Inconsiderate", "Ill",
	"Jealous", "Jumpy", "Just", "Jelly",
	"Killer", "Known", "Keen", "Knight",
	"Lean", "Lying", "Lost", "Lucrative",
	"Miraculous", "Monstrous", "Malign", "Mega",
	"Needy", "Nautical", "Norse", "Night",
	"Open", "Original", "Oaken", "Omen",
	"Prosperous", "Poor", "Planted", "Plume",
	"Quiet", "Quaint", "Quite", "Query",
	"Realistic", "Random", "Rolled", "Ridiculous",
	"Silly", "Soothing", "Serious", "Sorry",
	"Timid", "Triangular", "Treated", "Time",
	"Underpowered", "Ultimate", "Ugly", "Ultra",
	"Vivid", "Violent", "Vouched", "Vantage",
	"Wired", "Wonderful", "Windy", "Wild",
	"Xeno", "Xenial", "Xiphophyllous", "Xerosis",
	"Yielding", "Yearly", "Yucky", "Yore-wise",
	"Zealous", "Zeroed", "Zesty", "Zephyr"
	
	]

adj_per_letter = 4
	
nouns = [

	"Animal", "Atrocity", "Ace", "Anti",
	"Bank", "Buzz", "Blank", "Bead",
	"Cash", "Coral", "Class", "Cord",
	"Drag", "Duplicate", "Drought", "Dance",
	"Electricity", "Elevation", "Everything", "Earnings",
	"Fan", "Flare", "Ferocity", "Font",
	"Glass", "Ghost", "Greens", "Gore",
	"Hall", "Hatred", "Heart", "Hallow",
	"Ion", "Icon", "Internet",  "Inch",
	"Jewel", "Jack", "Jump", "Jealousy",
	"Killer", "Kaleidescope", "Key", "King",
	"Liar", "Light", "Land", "Loathing",
	"Monopoly", "Moon", "Might", "Mach",
	"Night", "Null", "Necromancy", "Notoriety",
	"Opal", "Oracle", "Oak", "Ocean",
	"Pearl", "Pile", "Plight", "Personality",
	"Quail", "Queen", "Quasi", "Quad",
	"Reality", "Roll", "Rack", "Retaliation",
	"Sail", "Sand", "Silver", "Stance",
	"Tale", "Truth", "Tyrant", "Tenant",
	"Underdog", "Use", "Ultra", "Urgency",
	"Violence", "Vent", "Vaccine", "Volt",
	"Whack", "Wall", "Word", "Well",
	"Yarn", "Yawn", "Youth", "Yule",
	"Zero", "Zinc", "Zodiac", "Zone"
	
	]

nou_per_letter = 4

#--
#	Generate World
#--

rand1 = "#{gen_name(1)}"
$w[:name] = rand1																	# 0  - Planet's name
rand2 = rand1[rand1.length - 1]
rand3 = rand(0..2)
if rand2 == "a" or rand2 == "e" or rand2 == "i" or rand2 == "o" or rand2 == "u"		# 1  - Planet's residences' adjective
	if rand3 == 0
		$w[:person_name] = "#{rand1}n"												# "
	elsif rand3 == 1
		$w[:person_name] = "#{rand1}sh"												# "
	elsif rand3 == 2
		$w[:person_name] = "#{rand1}k"												# "
	end
else
	if rand3 == 0
		$w[:person_name] = "#{rand1}ese"											# "
	elsif rand3 == 1
		$w[:person_name] = "#{rand1}ian"											# "
	elsif rand3 == 2
		$w[:person_name] = "#{rand1}ish"											# "
	end	
end
$w[:water] = rand(62.0..88.0).round(2)												# 2  - Planet's water percentage
$w[:tilt] = rand(0.0..48.0).round(2)												# 3  - Planet's tilt
rand1 = rand(12..60)
$w[:maxhours] = rand1																# 4  - Hours in a day
rand2 = rand(245..490)
rand3 = rand2 * 24.0
rand3 = (rand3 / rand1).round.to_i
$w[:maxdays] = rand3																# 5  - Days in a year
rand2 = 0
rand3 = 0
if rand1 <= 24
	rand2 + 2
elsif rand1 > 24
	rand3 - 2
end
$w[:maxmonths] = rand((8 + rand2)..(16 + rand3))									# 6  - Number of months
$w[:common_fix] = gen_name("1 syll").downcase										#    - Common Prefix/Suffix for month names
rand1 = rand(0..8)
$w[:fix_format] = 1																	#    - Prefix(0) or Suffix(1)?
$w[:months] = []                                                                    # 7  - Month name array
$w[:daysinmonths] = []																# 8  - Month number of days array
rand1 = 0                                                                 		 	
$w[:maxmonths].times do |z|
	rand2 = rand(-1..6)
		if rand2 > 0
			rand3 = $w[:common_fix][-1]
			rand4 = $w[:common_fix][0]
			if $w[:fix_format] == 0
				if rand3 == "a" or rand3 == "e" or rand3 == "i" or rand3 == "o" or rand3 == "u"
					$w[:months].push("#{$w[:common_fix].capitalize}#{gen_name(1, "con").downcase}")
				else
					$w[:months].push("#{$w[:common_fix].capitalize}#{gen_name(1, "vow").downcase}")
				end
			elsif $w[:fix_format] == 1
				if rand4 == "a" or rand4 == "e" or rand4 == "i" or rand4 == "o" or rand4 == "u"
					$w[:months].push("#{gen_name(1, "none", "vow")}#{$w[:common_fix]}")
				else
					$w[:months].push("#{gen_name(1, "none", "con")}#{$w[:common_fix]}")
				end
			end
		else
			$w[:months].push("#{gen_name(1)}")
		end
	$w[:daysinmonths].push(($w[:maxdays] / $w[:maxmonths]).round.to_i)				# "
	rand1 += $w[:daysinmonths][z]
end
loop do
	if rand1 > $w[:maxdays]
		rand1 -= 1
		$w[:daysinmonths][rand(0..($w[:maxmonths] - 1))] -= 1						# "
	elsif rand1 < $w[:maxdays].to_i
		rand1 += 1
		$w[:daysinmonths][rand(0..($w[:maxmonths] - 1))] += 1						# "
	elsif rand1 == $w[:maxdays].to_i
		break
	end
end
$w[:current_year] = (rand(350..5400))												# 9  - Current Year
$w[:current_month] = 0																# 10 - Current Month
$w[:current_day] = 1																# 11 - Current Day
$w[:current_hour] = 1																# 12 - Current Hour
rand2 = ["Far-North", "Mid-North", "Equatorial", "Mid-South", "Far-South"]
$w[:resource_sat] = {}																# 13 - Strong metals, Precious metals and Petroleum/Oil saturations
rand1 = rand(0..(rand2.count - 1))
$w[:resource_sat][:strong] = (rand2[rand1])
rand2.delete_at(rand1)
rand1 = rand(0..(rand2.count - 1))
$w[:resource_sat][:value] = (rand2[rand1])
rand2.delete_at(rand1)
rand1 = rand(0..(rand2.count - 1))
$w[:resource_sat][:oil] = (rand2[rand1])
rand2.delete_at(rand1)

#--
#	Generate Countries
#--

rand4 = rand((12 - (5 * ($w[:water] / 100)).round.to_i)..(17 - (5 * ($w[:water] / 100)).round.to_i))

rand4.times do |z|
	rand1 = rand(0..adjectives.count - 1)
	rand2 = rand(-1..1)
	rand3 = ""
	if (z + rand2) % 5 == 0
		rand3 = "Far-North"
	elsif (z + rand2) % 5 == 1
		rand3 = "Mid-North"
	elsif (z + rand2) % 5 == 2
		rand3 = "Equatorial"
	elsif (z + rand2) % 5 == 3
		rand3 = "Mid-South"
	elsif (z + rand2) % 5 == 4
		rand3 = "Far-South"
	end
	gen_country("C#{z}", "#{adjectives[rand1].downcase}", rand3)
	adjectives.delete_at(rand1)
end

#--
#	Generate the Whole members
#--

4.times do |z|
	rand1 = rand(0..adjectives.count - 1)
	rand2 = rand(0..nouns.count - 1)
	gen_first_name = "#{gen_name(1)}"
	rand3 = rand(0..($w[:maxmonths] - 1))
	whole_char("#{adjectives[rand1]} #{nouns[rand2]}", gen_first_name, rand(0..1), "#{gen_name(0)}", "#{gen_name(rand(1..2))}", "#{gen_age(rand(0..4))}", "#{gen_gender(true, gen_first_name)}", rand(20..35), rand(3..7), rand(3..7), 5)
	rand3 = rand1 % adj_per_letter
	adj_per_letter.times do |z2|
		adjectives.delete_at(rand1 - rand3)
	end
end

7.times do |z|
	rand1 = rand(0..adjectives.count - 1)
	temp_nouns = nouns.clone
	4.times do |z2|
		rand2 = rand(0..temp_nouns.count - 1)
		gen_first_name = "#{gen_name(rand(0..1))}"
		whole_char("#{adjectives[rand1]} #{temp_nouns[rand2]}", gen_first_name, rand(0..1), "#{gen_name(0)}", "#{gen_name(rand(1..2))}", "#{gen_age(rand(0..4))}", "#{gen_gender(true, gen_first_name)}", rand(10..25), rand(1..5), rand(1..5), rand(1..5))	
		rand3 = rand2 % nou_per_letter
		nou_per_letter.times do |z3|
			temp_nouns.delete_at(rand2 - rand3)
		end
	end
	rand3 = rand1 % adj_per_letter
	adj_per_letter.times do |z2|
		adjectives.delete_at(rand1 - rand3)
	end
end

pass_time(rand(0..($w[:maxdays] * $w[:maxhours])))

loop do
	puts " "
	show_quick_info
	check_for_birthdays
	print "[Input]> ".yellow.bold
	input = gets.chomp.downcase
	input_array = input.split(" ")
	if input_array.count == 0
		puts "\tError".red.bold + ": No input."
	elsif input_array.count == 1
		if input_array[0] == "end"
			break
		elsif input_array[0] == "help"
			puts "\n\thelp: Show this page."
		elsif input_array[0] == "nd"
			next_day
		else
			puts "\tError".red.bold + ": Unrecognized command."
		end
	elsif input_array.count == 2
		if input_array[0] == "info" or input_array[0] == "i"
			rand2 = 0
			$tw.each do |whole|
				rand1 = whole.codename.split(" ")
				if input_array[1][0] == "#{rand1[0].downcase[0]}" and input_array[1][1] == "#{rand1[1].downcase[0]}" and input_array[1].length == 2
					if whole.knowndetails[0] == 1
						show_whole_info(whole)
						rand2 = 1
					end
				end		
			end
			$countries.each do |country|
				if input_array[1] == country.details[:codename].downcase or input_array[1] == country.details[:name].downcase
					show_country_info(country)
					rand2 = 1
				end
			end
			if input_array[1][0] == "m"
				show_mission_info(input_array[1])
				rand2 = 1
			end
			if rand2 == 0
				puts "\tError".red.bold + ": Unknown entity."
			end
		elsif input_array[0] == "view" or input_array[0] == "v"
			if input_array[1] == "world" or input_array[1] == "planet" or input_array[1] == "p"
				show_the_world
			elsif input_array[1] == "whole" or input_array[1] == "w"
				show_the_whole
			elsif input_array[1] == "countries" or input_array[1] == "c"
				show_the_countries
			elsif input_array[1] == "missions" or input_array[1] == "m"
				show_the_missions			
			end
		elsif input_array[0] == "nh"
			pass_time(input_array[1].to_i)
		else
			puts "\tError".red.bold + ": Unrecognized command."			
		end
	elsif input_array.count == 3
		if input_array[0] == "info" or input_array[0] == "i"
			rand2 = 0
			$tw.each do |whole|
				rand1 = whole.codename.split(" ")
				if input_array[1] == "#{rand1[0].downcase}" and input_array[2] == "#{rand1[1].downcase}"
					if whole.knowndetails[0] == 1
						show_whole_info(whole)	
					else
						puts "\tError".red.bold + ": Unknown entity."
					end
				else
					rand2 += 1
				end
				if rand2 == $tw.count
					puts "\tError".red.bold + ": Unknown entity."
				end
			end
		elsif input_array[0] == "sort" or input_array[0] == "s"
			if input_array[1] == "whole" or input_array[1] == "w"
				if input_array[2] == "expertise" or input_array[2] == "e"
					sort_whole_info("expertise")
				else
					puts "\tError".red.bold + ": Unknown method to sort the Whole."						
				end
			elsif input_array[1] == "countries" or input_array[1] == "c"
				if input_array[2] == "size" or input_array[2] == "s"
					sort_country_info("size")
				elsif input_array[2] == "population" or input_array[2] == "p"
					sort_country_info("population")
				elsif input_array[2] == "resources" or input_array[2] == "r"
					sort_country_info("resources")
				else
					puts "\tError".red.bold + ": Unknown method to sort the countries."
				end
			else
				puts "\tError".red.bold + ": Entity cannot be sorted, or does not exist."			
			end
		elsif input_array[0] == "track" or input_array[0] == "t"
			rand2 = $tw.count
			$tw.count.times do |z|
				rand1 = $tw[z].codename.split(" ")
				if input_array[2][0] == "#{rand1[0].downcase[0]}" and input_array[2][1] == "#{rand1[1].downcase[0]}" and input_array[2].length == 2
					if $tw[z].knowndetails[0] == 1
						if input_array[1].to_i >= 0 and input_array[1].to_i <= 2
							set_tracking(input_array[1].to_i, z)
						else
							puts "\tError".red.bold + ": No such tracking number."
						end
					end
				else
					rand2 -= 1
				end
			end
			if rand2 == 0
				puts "\tError".red.bold + ": Entity cannot be tracked, or does not exist."
			end
		else
			puts "\tError".red.bold + ": Unrecognized command."
		end	
	else
		puts "\tError".red.bold + ": Unrecognized command."	
	end
end