import copy
import enum
import random


print('CPSC 312 Project 1 -- Andrew Huang, Keira Moore, Philly Tan')

# We can import from a different file, this is just a sample
words = ['aback', 'abase', 'abate', 'abbey', 'abbot', 'abhor', 'abide', 'abled', 'abode', 'abort', 'about', 'above', 'abuse', 'abyss', 'acorn', 'acrid', 'actor', 'acute', 'adage']

# in haskell, when we import all the words, we can hard code this
lenWords = len(words) - 1

# create an enumeration for the different states of each letter
class guessState(enum.Enum):
    Empty = '_'
    Wrong = '!'
    Partial = '*'
    Correct = '#'

# create a game state using an object
# TODO: add check to show all letters used
class gamestate(object):
    def __init__(self):
        self.guesses = 0
        self.wordToGuess = words[random.randint(0, lenWords)]
        self.states = [guessState.Empty] * 5

def startGame():
    # initialize a new game
    initialState = gamestate()
    guessHistory = []
    showGameState(initialState, guessHistory)

# print out the game information
def showGameState(initialState, guessHistory):
    print('Guesses so far: ', initialState.guesses)
    userGuess = input('Please guess a new five letter word!\n')
    # TODO: insert word validity checks and a check if someone guesses something that isnt in the word set
    currentGuess = list(userGuess)
    # print(currentGuess, initialState.wordToGuess)

    # Check if the guesses are right and label the letters according to their guesses
    # currently the enumeration has no use but can be used in the future
    for i in range(5):
        letter = currentGuess[i]
        if letter == initialState.wordToGuess[i]:
            initialState.states[i] = guessState.Correct
            currentGuess[i] = '#' + currentGuess[i]
        else:
            if letter in initialState.wordToGuess:
                initialState.states[i] = guessState.Partial
                currentGuess[i] = '*' + currentGuess[i]
            else:
                initialState.states[i] = guessState.Wrong
                currentGuess[i] = '!' + currentGuess[i]
        # print('hi', initialState.states[i])
    
    print('You guessed:', userGuess)
    print('# indicates a correct letter placement, * represents that the letter is in the word but not in that spot, and ! means the letter isn\'t in the word')
    print(currentGuess)
    guessHistory.append(currentGuess)

# start a new game
startGame()
        