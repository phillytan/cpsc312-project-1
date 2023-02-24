-- CPSC 312 - 2023 - Games in Haskell
module Wordle where

-- To run it, try:
-- ghci
-- :load wordle

------ Wordle Game -------

data State = State InternalState [Action]  -- internal_state available_actions
         deriving (Ord, Eq)

-- EndOfGame is when the correct word is guessed
-- Otherwise, continue the game and update the state
data Result = EndOfGame Double State    -- end of game: value, starting state
            | ContinueGame State        -- continue with new state
         deriving (Eq)

type Game = Action -> State -> Result

type Player = State -> Action

data Action = Action String                   -- a move for a player is just a String
         deriving (Ord,Eq)
type InternalState = ([Action],[Action])   -- (self,other)
