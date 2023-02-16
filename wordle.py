import enum
import random


print('CPSC 312 Project 1 -- Andrew Huang, Keira Moore, Philly Tan')

# We can import from a different file, this is just a sample
words = ['aback', 'abase', 'abate', 'abbey', 'abbot', 'abhor', 'abide', 'abled', 'abode', 'abort', 'about', 'above', 'abuse', 'abyss', 'acorn', 'acrid', 'actor', 'acute', 'adage']

# in haskell, when we import all the words, we can hard code this
lenWords = len(words) - 1

# create an enumeration for the different states of each letter
class guessState(enum.Enum):
    Empty = 0
    Wrong = 1
    Partial = 2
    Correct = 3

# create a game state using an object
class gamestate(object):
    def __init__(self, l1=None, l1state=None, l2=None, l2state=None, l3=None, l3state=None, l4=None, l4state=None, l5=None, l5state=None):
        self.guesses = 0
        self.wordToGuess = words[random.randint(0, lenWords)]
        self.l1 = l1
        self.l1state = guessState(guessState.Empty)
        self.l2 = l2
        self.l2state = guessState(guessState.Empty)
        self.l3 = l3
        self.l3state = guessState(guessState.Empty)
        self.l4 = l4
        self.l4state = guessState(guessState.Empty)
        self.l5 = l5
        self.l6state = guessState(guessState.Empty)

# initialize a new game
initialState = gamestate()

# print out the game information
def showGameState():
    print(initialState.guesses)
    print(initialState.wordToGuess)

showGameState()
        