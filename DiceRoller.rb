def roll_dice
    print "Do you want to roll the dice ? (yes/no): "
    response = gets.chomp.downcase
    if response == "yes"

        #find how many dice to roll
        print "How many dice ?: "
        amount_response = gets.chomp.to_i

        #if more than 0, enter loop
        if amount_response > 0
            puts "Rolling #{amount_response} dice"
            roll_result_total = 0


            #run loop amount of times entered and return result
            amount_response.times do |index|
                roll_result = rand(1..6)
                roll_result_total += roll_result
            end
            return roll_result_total

        #if amount was 0 or non-integer, terminate
        else puts "No dice"
        end


    #If response was no, terminate  
    else
        puts "No dice"
    end
end


result = roll_dice
if result
    puts "Your rolls totalled to: #{result}"
end