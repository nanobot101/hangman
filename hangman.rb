require 'ruby2d'
set width: 500, height: 500, background: 'white', title: "Hangman Game!"

# below are the PNG's necessary to draw the hangman. after importing each, I removed it so they would only show up when I called them down below.
hangman = Image.new(
    'hangman 1.png',
    x: 35, y: 50,
    width: 190, height: 350,
)

head = Image.new(
    'head.png',
    x: 140, y: 75,
    width: 80, height: 80,
)
head.remove

body = Image.new(
  'body.png',
  x: 155, y: 90,
  width: 80, height: 200,
  bold: 50
)
body.remove

arms = Image.new(
  'arms.png',
  x: 80, y: 90,
  width: 225, height: 200,
)
arms.remove

legs = Image.new(
  'legs.png',
  x: 80, y: 180,
  width: 225, height: 200,
)
legs.remove

# the counter needed to count the incorrect guesses and draw the hangman
incorrect_answers = 0

#the set of words that is randomly chosen from for each game
wordlist = ["birch", "anger", "editor", "twig", "family", "stripe", "finger", "maple", "garden", "leaf", "island", "leaf", "angel", "pale", "sword", "oak", "stem", "dreams", "devil"  ]
chosen_word = wordlist.sample
print chosen_word

#both of these arrays are necessary for the key_down function and the wordwriter function
chosen_array = chosen_word.split("")
word_array = chosen_word.split("")
oldvers = Text.new("")

#this function draws the hangman based on the number of incorrect guesses the user has inputted
def hangmandraw(incorrect_answers, head, body, arms, legs)
  puts incorrect_answers
  if incorrect_answers == 1
     head.add
  end
  if incorrect_answers == 2
      body.add
  end
  if incorrect_answers == 3
      legs.add
  end
  if incorrect_answers == 4
      arms.add
  end
  if incorrect_answers == 5
      clear
      Text.new(
          'Game Over!',
          x: 100, y: 150,
          style: 'bold',
          size: 50,
          color: 'black',
      )
    end
end



# this function draws the spaces showing how many letters are in the word
def spacedrawer(word)
    space_number = word.length
    for a in 0...space_number do
         Text.new(
            '_',
            x: 250 + a*40, y: 150,
            style: 'bold',
            size: 50,
            color: 'black',
        )
    end
end
spacedrawer(chosen_word)

# this function displays the correct letters a user has chosen over the corresponding space
def wordwriter(word_array, letter)
  for a in 0...word_array.length do
    if word_array[a] == letter
      Text.new(
        letter,
        x: 250 + a*40, y: 150,
        style: 'bold',
        size: 40,
        color: 'black',
    )
      break
    end
  end
end

# this function calls all other functions in time with the user input
on :key_down do |event|
    result =
      if chosen_array.include?(event.key.downcase)
        "Correct!"
      else
        "Wrong"
      end
  if result == "Correct!"
    chosen_array.delete(event.key.downcase)
    oldvers.remove
    rightans = Text.new(
      result,
          style: 'bold',
          size: 50,
          color: 'black'
    )
    oldvers = rightans
    wordwriter(word_array, event.key.downcase)
  end
  if result == "Wrong" 
    hangman.add
    incorrect_answers += 1
    oldvers.remove
    wrongans = Text.new(
      "Guesses left: " + (5 - incorrect_answers).to_s,
          style: 'bold',
          size: 50,
          color: 'black'
    )
    oldvers = wrongans
    hangmandraw(incorrect_answers, head, body, legs, arms)
    end
end

show


