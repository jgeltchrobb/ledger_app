# A group of friends have just finished lunch. Write an app to work out how much each person owes.

# Parameters:
# - Your app should ask "Enter a customer's name"
# - Your first line of code is:
# items = [{ customer: "John", item: "Soup", cost: 8.50}, {customer: "Sarah", item: "Pasta", cost: 12}, {customer: "John", item: "Coke", cost: 2.50}]
# - Your app should output, for example: "John owes $11.0"

# Bonus:
# 1. Format your total so it always shows two deciaml places, e.g. $11.00
# 2. The list of items makes our code messy. Instead, see if you can read the items from a file. (Google will help here!)
# 3. Allow items to be added to the list. E.g. "Press 1 to add items, press 2 to work out a total".
# 4. Store these new items to the file.

# ledger = [
#     {
#         Customer: "John",
#         Product: "Soup",
#         Cost: 8.50
#     },
#     {
#         Customer: "Sarah",
#         Product: "Pasta",
#         Cost: 12
#     },
#     {
#         Customer: "John",
#         Product: "Coke",
#         Cost: 2.50
#     },
# ]

require 'yaml'

from_file = YAML.load_file('ledger.yml')
# File.write('ledger.yml', ledger.to_yaml)


puts "Ledger App"
puts "\nEnter Username"
userName = gets.chomp.downcase.capitalize
total_cost = 0
found = false
name_found = false
active_account = false

from_file.each do |check|
    if check[:Customer] == userName
    active_account = true
    name_found = true
    puts "found"
    elsif name_found
        break
    end
end
if !name_found
    puts "Name not found"
end
if active_account
    puts "account active"
end


while active_account

puts "\nChoose option:\n[1] Add new entry\n[2] Calculate amount owing\n[3] View current ledger\n[4] Delete entry\n[5] Exit"    
options = gets.chomp

    case options
        
        when "1"
            puts "Add new entry\n"
            puts "\nEnter food item"
            food = gets.chomp.downcase.capitalize
            puts "\nEnter cost"
            price = gets.chomp.downcase.capitalize        
            from_file.push({Customer: userName, Product: food, Cost: price}) 
            File.write('ledger.yml', from_file.to_yaml)
            puts from_file

        when "2"
            from_file.each do |item|
                if item[:Customer] == userName
                    total_cost += item[:Cost].to_f
                    found = true
                end
            end
            if !found
                puts "Customer not found"
            else
                puts "#{userName} owes $#{total_cost}"        
            end    
        
        when "3"
            puts "Current ledger"
            from_file.each do |item|
                puts ""
                item.each do |key, value|
                    puts "#{key}: #{value}\n"
                end
            end
            
        when "4"
            puts "Delete an entry"
            puts "\nEnter food item"
            food = gets.chomp.downcase.capitalize
            puts "\nEnter cost"
            price = gets.chomp.downcase.capitalize
            found = false
            from_file.each do |item|
                if item[:Customer] == userName && item[:Product] == food && item[:Cost] == price
                    from_file.delete(item)
                    File.write('ledger.yml', from_file.to_yaml)                
                    found = true
                end
            end  
            if !found
                puts "Ledger:\n"
                puts "Item: [#{food}] for $#{price} not found"
            else
                puts "Item: [#{food}] Deleted"
            end

        when "5"
            active_account = false
            puts "Exiting"
    end 
end
# # add option to view users ledger entries
# # add option to delete entries if they've paid (recalculate amount owing)
# # change ledger array into empty array with nothing in it to begin with? no neccesary
