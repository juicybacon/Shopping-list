#This is a shopping list project 
#written by Jason Baker 03/11 2018

def empty_list(empty,list)
#This is code to check to see if the shopping list is empty
#returns empty as true if empty	
	if list.include?("shopping list is empty")
		puts ""
		puts "Currently your shopping list is empty"
		puts ""
			loop do
				print "Press <ENTER> to return to the main menu: "
				ans=gets.chomp
				break if ans==""
			end
		empty = true
		return empty
	end
end

def add_shopping(list)
#Will check to see if empty list marker is in place and will remove
#Will check to see if item already exists before adding
	add=""

	system "clear" or system "cls"
	loop do
		loop do
			puts ""
			print "What would you like to add to the shopping list? "
			add=gets.chomp.capitalize!
			break if add != nil
		end
		add.strip!
		if list.include? "shopping list is empty" 									#Checks to see if empty list marker exists
			list.delete("shopping list is empty") 										#Removes marker and adds new item
			list << add
			puts "#{add} has been added"
		elsif list.include? add 																		#Check to see if item already exists
			puts "This item is already in your shopping list"
			puts ""
		else
			list << add 																							
			puts "#{add} has been added"
		end
		list.sort!
		loop do
			print "Would you like to add another item (Y/N)"
			ans=gets.chomp.capitalize!
			if ans != nil then ans.strip!;end
			break if ans=="Y"
			if ans=="N"
				return(list)
			end
		end
	end
end

def remove_shopping(list)
#Checks to see if the list is empty, lists current items
#Determine which item to remove
	system "clear" or system "cls"
	ans=""
	remove_again=""
	remove=""
	remove_item=""
	
	empty=empty_list(empty,list)
	if empty then return;end
	loop do
	puts "** Your current shopping list has the below contents **"
	puts ""	
	puts list
		loop do
			puts ""
			print "Which item would you like to remove from your shopping list: "
			remove_item=gets.chomp.capitalize!
			if remove_item != nil then remove_item.strip!;end
			puts ""
			if list.include? remove_item then
				loop do
					print "Are you sure you want to remove #{remove_item} (Y/N)? "
					remove=gets.chomp.capitalize!
					if remove != nil then remove.strip!;end
					break if remove=="Y"
					break if remove=="N"
				end
				if remove=="Y"
					list.delete(remove_item)
					print "#{remove_item} has been removed from your shopping list"
				else 
					print "#{remove_item} has not been removed from your shopping list"
				end
			else
				print "#{remove_item} is not in your shopping list"
			end
			puts ""
			loop do
				print "Would you like to remove another item (Y/N)? "
				remove_again=gets.chomp.capitalize!
				if remove_again != nil then remove_again.strip!;end
				break if remove_again=="Y"
				break if remove_again=="N"
			end
		if remove_again=="N" then return;end
		end
	end
end

def view_list(list)
#Checks to see if list is empty and displays current list
	system "clear" or system "cls"
	empty=empty_list(empty,list)
	if empty then return;end
	loop do
		puts "** Your current shopping list has the below contents **"
		puts ""
		puts list
		puts ""
		print "Press <ENTER> to continue to the main menu: "
		choice=gets.chomp
		break if choice==""
	end
end

def delete_file(list)
#Checks to see if list is empty and then deletes file
	ans=""
	system "clear" or system "cls"
	empty=empty_list(empty,list)
	if empty then return;end
	loop do
		print "Are you sure you want to delete your shopping list (Y/N)? "
		ans=gets.chomp.capitalize!
		if ans != nil then ans.strip!;end
		puts ""
		break if ans=="Y"
		break if ans=="N"
	end
	if ans=="Y"
		File.delete("shopping.txt")
		print "Your shopping list has been deleted!"
		loop do
			print "Press <ENTER> to return to the menu"
			ans=gets.chomp
			break if ans==""
		end
	else
		return
	end
end

def save_list(list)
#Checks to see if list is empty and then saves list
	system "clear" or system "cls"
	empty=empty_list(empty,list)
	if empty then return;end
	File.open("shopping.txt", "w+") {|x| x << "#{list.join("\n")}"}
	puts "Your shopping list has now been save!"
	loop do 
		print "Press <ENTER> to continue: "
		ans=gets.chomp
		break if ans == ""
	end
end

def exits(xit,list)
#Loads shopping file into a new array, compares to current list
#To see if changes have been save, give options then exit
	save=""
	if File.file?("shopping.txt")	
		compare=IO.readlines("shopping.txt")
		compare.map{|x| x.strip!}
	end
	if list == compare
		loop do
			puts ""
			print "Are you sure you want to exit (Y/N): "
			xit=gets.chomp.capitalize!
			if xit != nil then xit.strip;end
			break if xit=="Y"
			break if xit=="N"
		end
		return xit
	else
		puts ""
		puts "Your changes to the shopping list have not been saved"
		loop do
			print "Would you like to save your changes (Y/N)? "
			save=gets.chomp.capitalize!
			if save != nil then save.strip!;end
			break if save=="Y"
			break if save=="N"
		end
		if save=="Y"
			save_list(list)
		else
			xit="Y"
			return xit
		end
	end
end

def menu(choice)
#Main menu screen
	loop do
		system "clear" or system"cls"
		puts "        *MAIN MENU*"
		puts ""
		puts "[1] Add items to the shopping list"
		puts "[2] Remove items from the shopping list"
		puts "[3] View the shopping list"
		puts "[4] Delete the shopping list"
		puts "[5] Save the shopping list"
		puts "[6] Exit"
		puts ""
		print "Please enter your selection: "
		choice=gets.chomp.to_i
		break if choice==1
		break if choice==2
		break if choice==3
		break if choice==4
		break if choice==5
		break if choice==6
	end
	return choice
end

#********************************************************************
#Core code
system "clear" or system "cls"

#Check to see if file exists and loads into list array
list = []
if File.file?("shopping.txt")	
	list=IO.readlines("shopping.txt")
	list.map{|x| x.strip!}
	view_list(list)
end

#If the list array is empty add a empty marker, used to
#call empty_list method
if list.empty?
	list << "shopping list is empty"
end

loop do
	choice=menu(choice)
	case choice
		when 1 
			add_shopping(list)
		when 2 
			remove_shopping(list)
		when 3 
			view_list(list)
		when 4 
			delete_file(list)
		when 5
			save_list(list)
		when 6 
			xit=exits(xit,list)
			if xit=="Y"
				system "clear" or system "cls"
				print "Thank you for using the shopping list created by Jason Baker"
				exit
			end
	end
end
