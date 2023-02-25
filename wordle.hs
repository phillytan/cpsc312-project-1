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
wordle :: String -> String
wordle = reverse


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

  -- Initiate the game

  putStrLn "Done for now"

