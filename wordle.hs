-- CPSC 312 - 2023 - Games in Haskell
module Wordle where

import Data.List
import Data.String (String)
import System.IO
import System.IO.Unsafe
import System.Random

------ Wordle Game -------
-- To run it, try:
-- ghci
-- :load wordle
-- play

-- Troubleshooting
-- If 'Could not find module `System.Random`
--    brew install haskell-stack
--    stack install random
--    stack ghci --package random
--    :load wordle
--    play

--- Retrieving a random word from our words.txt ---
wordFilePath = "./words.txt"

randomWord :: FilePath -> IO [String]
randomWord path = do
  contents <- readFile path
  return $ words contents

--- Check correctness of word and give feedback ---
--- Given the wordToGuess and the userGuess
--- Return "Correct" if the string is an exact match
--- Otherwise, append # to correct letters, append * to partial correct, append ! to incorrect
--- E.g.
---   about apple --> "a# p! p! l! e!"
---   apple apple --> "Correct"
stringsMatch :: String -> String -> String
stringsMatch wordToGuess userGuess
  | wordToGuess == userGuess = "Correct"
  | otherwise = stringsCompare wordToGuess userGuess (wordToGuess `intersect` userGuess)

-- Recursive helper function to give feedback
-- Given the wordToGuess, the userGuess, and the intersect of those two words
-- Append # to correct letters, append * to partial correct, append ! to incorrect
stringsCompare :: String -> String -> String -> String
stringsCompare [] [] _ = []
stringsCompare (w : ws) (u : us) intersection
  | w == u = u : '#' : ' ' : stringsCompare ws us intersection
  | u `elem` intersection = u : '*' : ' ' : stringsCompare ws us intersection
  | otherwise = u : '!' : ' ' : stringsCompare ws us intersection

--- Implement this part according to the spec above

--- Main game function, creates a game object with a random word, enters into a while loop of guessing until correct ---
play :: IO ()
play = do
  putStrLn "Welcome to Wordle++, created by Andrew, Keira, and Philly for CPSC 312!"

  -- Retrieve a random word from the wordlist --
  wordList <- randomWord wordFilePath
  let wordListLen = 12792
  let randomIndex = unsafePerformIO (getStdRandom (randomR (0, wordListLen - 1)))
  let wordToGuess = (wordList !! randomIndex)
  let guessHistory = []

  -- FOR DEBUGGING AND DEVELOPING ONLY, REMOVE LATER
  putStrLn ("The word to guess is: " ++ show wordToGuess)

  wordle wordToGuess guessHistory

  putStrLn "Thank you for playing!"

wordle :: String -> [String] -> IO ()
wordle wordToGuess guessHistory = do
  -- Initiate the game
  putStrLn "Enter 1 to guess a word"
  putStrLn "Enter 2 to see guess history"
  putStrLn "Enter 3 to get a hint"
  userChoice <- getLine
  if userChoice == "1"
    then do
      putStrLn "Please guess a five letter word"
      guess <- getLine
      let result = stringsMatch wordToGuess guess
      if result == "Correct"
        then do
          putStrLn "Congrats, you have solved the wordle!"
        else do
          -- Add result to guessHistory
          putStrLn result
          wordle wordToGuess (updateHistory result guessHistory) -- Recursive call
    else
      if userChoice == "2"
        then do
          putStrLn "Here are your previous guesses"
          -- TODO:
          -- Loop through guessHistory, print each guess.
          -- Everytime we guess something, add the result (e.g. a* b# o! u! t!) to guessHistory
          mapM_ putStrLn guessHistory
          wordle wordToGuess guessHistory -- Recursive call
        else do
          putStrLn "Here is your hint"
          -- TODO:
          -- Implement hints
          generateHints wordToGuess
          wordle wordToGuess guessHistory -- Recursive call

--- Function to update the guess history
updateHistory :: String -> [String] -> [String]
updateHistory result [] = [result]
updateHistory result guessHistory = guessHistory ++ [result]

vowels = ['a','e','i','o','u']
isVowel::Char -> Bool
isVowel c = foldr (\ currentLetter prev -> prev || currentLetter == c) False vowels

countVowels :: String -> IO Int
countVowels word = do
  let count = foldr (\ currentLetter prev -> if isVowel currentLetter then prev + 1 else prev) 0 word
  return count
countConsonants :: String -> IO Int
countConsonants word = do
  let count = foldr (\currentLetter prev -> if isVowel currentLetter then prev else prev + 1) 0 word
  return count

-- TODO: Give the user a hint depending on the word to guess
generateHints :: String -> IO ()
generateHints wordToGuess = do
  vowels <- countVowels wordToGuess
  consonants <- countConsonants wordToGuess
  if vowels > consonants
    then do
      putStrLn ("Your Hint: There are " ++ (show vowels ++ " vowels in the word."))
    else do
      putStrLn ("Your Hint: There are " ++ (show consonants ++ " consonants in the word."))
