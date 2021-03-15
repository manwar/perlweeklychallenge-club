#!/usr/bin/env runghc

-- run <script>

import System.Environment (getArgs,)
import Control.Monad (liftM,)
import Data.Maybe (fromMaybe,fromJust,)
import Data.Stack (Stack,stackIsEmpty,stackNew,stackPop,stackPush,stackPeek,)

maybeMin :: Ord a => Maybe a -> Maybe a -> Maybe a
maybeMin (Just x) (Just y) = Just (min x y)
maybeMin (Just x) _ = Just x
maybeMin _ (Just x) = Just x
maybeMin _ _ = Nothing

stackMinimum :: Ord a => Stack a -> Maybe a
stackMinimum stack
  |stackIsEmpty stack = Nothing
  |otherwise = maybeMin (stackMinimum rest) (Just popped) where
     (rest,popped) = fromJust $ stackPop stack
     
main = do  
  let
    stack :: Stack Int
    stack = foldl stackPush (stackNew) [0,-1,3,10,4]
  putStrLn $ "Initial stack: " ++ (show stack)
  let (rest,popped) = fromJust $ stackPop stack
  putStrLn $ "Popped: " ++ (show popped)
  putStrLn $ "New stack: " ++ (show rest)
  putStrLn $ "Peeking: " ++ (show $ fromJust $ stackPeek rest)
  putStrLn $ "Current stack: " ++ (show rest)
  putStrLn $ "Smallest value: " ++ (show $ fromJust $ stackMinimum rest)
