

balance_deck = []

suits = ['Hearts', 'Clubs', 'Diamonds', 'Spades']
cards = ['Aces', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten', 'Jack', 'Queen', 'King']
points = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
#points = {'Aces'=>1, 'Two'=>2, 'Three'=>3, 'Four'=>4, 'Five'=>5, 'Six'=>6, 'Seven'=>7, 'Eight'=>8, 'Nine'=>9, 'Ten'=>10, 'Jack'=>10, 'Queen'=>10, 'King'=>10}

i = 1
while i <= 4 
  suits.each do |suits| 
    x = -1
    cards.each do |cards| 
      x += 1
      balance_deck << [suits,cards, points[x]]
    end
  end
  i += 1
end

balance_deck.shuffle!

def calculate_total(hand)
  total = 0 
  hand.each do |hands|
    total = total + hands[2]
  end
  if total > 21
    hand.each do |hands|
      if hands[1] == 'Aces' && total >21
        total -= 10
      end
    end
  end
  return total
end

player_hand = []
dealer_hand = []
player_total = 0
player_response = 'Y'

puts ''
puts ''
puts '<=== Welcome to gotealeaf blackjack table ===>'
puts '----------------------------------------------'
puts ''
player_hand << balance_deck.pop << balance_deck.pop
puts "Here are your first two cards =>"
player_hand.map {|hand| puts "#{hand[1]} of #{hand[0]}"}
puts ''
if calculate_total(player_hand) == 21
  puts 'It\'s a BLACKJACK, you WIN!!!'
  exit
else
  puts "Your total is #{calculate_total(player_hand)}"
  puts ''
end

dealer_hand << balance_deck.pop << balance_deck.pop
puts 'Here are dealer\'s first two cards =>'
dealer_hand.map {|hand| puts "#{hand[1]} of #{hand[0]}"}
puts ''
if calculate_total(dealer_hand) == 21
  puts 'Sorry, dealer\'s got a BLACKJACK, you LOSE!!!'
  puts ''
  exit
else
  puts "Dealer's total is #{calculate_total(dealer_hand)}"
end

game_on = 1
while game_on == 1 
  while (player_response == 'Y' || player_response == 'y') && calculate_total(player_hand) <=21
    puts ''
    puts ' ==> Do you want a card? Press Y for yes and press enter'
    player_response = gets.chomp
    if player_response == 'Y' || player_response == 'y'
      player_hand << balance_deck.pop
      puts ''
      puts "You got a => #{player_hand.last.fetch(1)} of #{player_hand.last.fetch(0)}"
      puts ''
      puts "Here is your hand =>"
      player_hand.map {|hand| puts "#{hand[1]} of #{hand[0]}"}
      puts ''
      puts "Your total is #{calculate_total(player_hand)}"
      puts "Dealer's total is #{calculate_total(dealer_hand)}"
      puts ''
      if calculate_total(player_hand) == 21
        puts ''
        puts 'It\'s a BLACKJACK, you WIN!!!'
        puts ''
        exit
      elsif calculate_total(player_hand) > 21
        puts ''
        puts 'Sorry, you are busted, dealer wins!!!'
        puts ''
        exit
      end
    else
      puts ''
      puts "You chose to stay"
      puts ''
      puts "Here is your hand =>"
      player_hand.map {|hand| puts "#{hand[1]} of #{hand[0]}"}
      puts ''
      puts "Your total is #{calculate_total(player_hand)}"
      game_on = 0 # player does not want further cards
    end
  end
end

while calculate_total(dealer_hand) <= 17 || calculate_total(dealer_hand) < calculate_total(player_hand) 
  dealer_hand << balance_deck.pop
  puts ''
  puts "Dealer got a => #{dealer_hand.last.fetch(1)} of #{player_hand.last.fetch(0)}"
  puts ''
  puts 'Here is the dealer\'s hand =>'
  dealer_hand.map {|hand| puts "#{hand[1]} of #{hand[0]}"}
  puts ''
  puts "Dealer's total is #{calculate_total(dealer_hand)}"
  puts ''
  if calculate_total(dealer_hand) == 21
    puts 'Sorry, dealer\'s got a BLACKJACK, you LOSE'
    puts 'Here is the dealer\'s hand =>'
    dealer_hand.map {|hand| puts "#{hand[1]} of #{hand[0]}"}
    puts ''
    exit
  elsif calculate_total(dealer_hand) > 21
    puts 'Dealer busted, you WIN!!!'
    puts ''
    exit
  end
end



# end game
puts 'Your total is ' + (calculate_total(player_hand)).to_s
puts ''
puts 'Dealer\'s total is ' + (calculate_total(dealer_hand)).to_s
puts ''

if calculate_total(player_hand) > calculate_total(dealer_hand)
  puts 'Congratulations, you win'
  exit
elsif calculate_total(player_hand) < calculate_total(dealer_hand)
  puts 'Sorry, you lose'
  exit
else
  puts 'It\'s a tie!!!!'
  exit
end
