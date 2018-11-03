#This is a shopping list project 
#written by Jason Baker

#All methods are listed below
def construction
	loop do
		system "clear" or system "cls"
		print "This part of the menu is still under construction press <ENTER> to continue: "
		cont=gets.chomp.to_s
		break if cont==""
	end
end

def add_shopping(list)
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
		
		if list.include? "shopping list is empty"
			list.delete("shopping list is empty")
			list << add
			puts "#{add} has been added"
		elsif list.include? add
			puts "This item is already in your shopping list"
			puts ""
		else
			list << add
			puts "#{add} has been added"
		end
		
		loop do
			print "Would you like to add another item (Y/N)"
			ans=gets.chomp.capitalize!
			ans.strip
			break if ans=="Y"
			if ans=="N"
				return(list)
			end
		end
	end
end

def remove_shopping(list)
	system "clear" or system "cls"
	ans=""
	remove_again=""
	
	loop do
		print "Are you sure you want to remove an item from your shopping list (Y/N)? "
		ans=gets.chomp.capitalize!
		ans.strip!
		puts ""
		break if ans=="Y" 
		break if ans=="N"
	end
	
	if ans=="N" then return; end
	
	if ans=="Y"
		loop do
			print "Would you like to view the shopping list (Y/N)? "
			ans=gets.chomp.capitalize!
			ans.strip!
			puts ""
			break if ans=="Y" 
			break if ans=="N"
		end

		if ans=="Y" then puts list; end

		loop do
			puts ""
			print "Which item would you like to remove from your shopping list: "
			remove_item=gets.chomp.capitalize!
			remove_item.strip!
			puts ""

			if list.include? remove_item then
				list.delete(remove_item)
				print "#{remove_item} has been removed from your shopping list"
			else
				print "#{remove_item} is not in your shopping list"
			end
			puts ""

			loop do
				print "Would you like to remove another item (Y/N)? "
				remove_again=gets.chomp.capitalize!
				remove_again.strip!
				break if remove_again=="Y"
				break if remove_again=="N"
			end
			break if remove_again=="N"
		end
	end
end

def view_list(list)
	loop do
		system "clear" or system "cls"
		puts "** Your current shopping list has the below contents **"
		puts ""
		puts list
		puts ""
		print "Press <ENTER> to continue to the main menu: "
		choice=gets.chomp
		break if choice==""
	end
end

def delete_file
	ans=""
	loop do
		system "clear" or system "cls"
		print "Are you sure you want to delete your shopping list? "
		ans=gets.chomp.capitalize!
		ans.strip!
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

def print_list
	construction
end

def save_list(list)
	system "clear" or system "cls"
	list.sort!
	File.open("shopping.txt", "w+") {|x| x << "#{list.join("\n")}"}
	puts "Your shopping list has now been save!"
	loop do 
		print "Press <ENTER> to continue: "
		ans=gets.chomp
		break if ans == ""
	end
end

def exits(xit)
	loop do
		puts ""
		print "Are you sure you want to exit (Y/N): "
		xit=gets.chomp.capitalize!
		xit.strip!
		break if xit=="Y"
		break if xit=="N"
	end
	return xit
end

def menu(choice)
	loop do
		system "clear" or system"cls"
		puts "        *MAIN MENU*"
		puts ""
		puts "[1] Add items to the shopping list"
		puts "[2] Remove items from the shopping list"
		puts "[3] View the shopping list"
		puts "[4] Delete the shopping list"
		puts "[5] Print the shopping list"
		puts "[6] Save the shopping list"
		puts "[7] Exit"
		puts ""
		print "Please enter your selection: "
		choice=gets.chomp.to_i
		break if choice==1
		break if choice==2
		break if choice==3
		break if choice==4
		break if choice==5
		break if choice==6
		break if choice==7
	end
	return choice
end

#********************************************************************
#Core code
system "clear" or system "cls"
list = []
if File.file?("shopping.txt")
	
	list=IO.readlines("shopping.txt")
	list.map{|x| x.strip!}
	view_list(list)
end

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
			delete_file
		when 5 
			print_list
		when 6 
			save_list(list)
		when 7 
			xit=exits(xit)
			if xit=="Y"
				system "clear" or system "cls"
				print "Thank you for using the shopping list created by Jason Baker"
				exit
			end
	end
end
