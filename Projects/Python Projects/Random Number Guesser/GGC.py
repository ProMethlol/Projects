# Guess the number challenge.

import random

secrect_number=random.randint(0,101)

#print(secrect_number)

guess = 0
guess_counter = 0

while guess != secrect_number:
    
    guess = int(input('Guess a number 1-100:    '))
    guess_counter += 1

    if guess <1 or guess >100:
        print('Out of bounds\nPlease try again')
           
    elif abs (secrect_number - guess) <= 5:
        print ('You are WARMER')
    
    elif abs (secrect_number - guess) <= 10:
        print ('You are WARM')
      
    else:
        print ('You are COLD')
            
print (f'Yay, you have guessed the correct number {secrect_number} in {guess_counter} guesses')


    
    
    
    
    
