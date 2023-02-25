-- CPSC 312 - 2023 - Games in Haskell
module Wordle where

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
--    stack ghci 
--    :load wordle
--    play

--- Retrieving a random word from our words.txt ---
wordFilePath = "/Users/andrew/Documents/GitHub/cpsc312-project-1/words.txt"
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
stringsMatch wordToGuess userGuess = do
   if wordToGuess == userGuess
      then "Correct"
      else "TODO TEST"
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

  -- FOR DEBUGGING AND DEVELOPING ONLY, REMOVE LATER 
  putStrLn "The word to guess is"
  putStrLn wordToGuess

  wordle wordToGuess

  putStrLn "Thank you for playing!"

wordle :: String -> IO()
wordle wordToGuess = do
  let guessHistory = ["Test Guess 1", "Test Guess 2", "Test Guess 3"]
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
               -- TODO: Add result to guessHistory
               wordle wordToGuess -- Recursive call
      else if userChoice == "2"
         then do
            putStrLn "Here are your previous guesses"
            -- TODO: 
            -- Loop through guessHistory, print each guess. 
            -- Everytime we guess something, add the result (e.g. a* b# o! u! t!) to guessHistory
            mapM_ print guessHistory
            wordle wordToGuess -- Recursive call
         else do
            putStrLn "Here is your hint"
            -- TODO:
            -- Implement hints
            generateHints wordToGuess
            wordle wordToGuess -- Recursive call


-- TODO: Give the user a hint depending on the word to guess
generateHints :: String -> IO()
generateHints wordToGuess = do
  putStrLn "TODO ADD HINTS"

