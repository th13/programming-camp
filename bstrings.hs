-- Calculate number of binary strings of a given length that do not
-- contain the specified substrings.

import Data.List
import Data.Maybe

bits :: [Char]
bits = ['0', '1']

invalid :: [String]
invalid = ["111", "101"]

prependBit :: Char -> String -> String
prependBit bit str = bit : str

checkValid :: String -> String -> Bool
checkValid rule str = not . isInfixOf rule $ str

prependNotInvalid :: Char -> String -> String -> Maybe String
prependNotInvalid b rule str
  | valid = Just theStr
  | otherwise = Nothing
  where
    theStr = prependBit b str
    valid = checkValid rule theStr

maybeStrings :: [Char] -> String -> String -> [Maybe String]
maybeStrings bits rule str = map (\b -> prependNotInvalid b rule str) bits

removeNothings :: [Maybe String] -> [Maybe String]
removeNothings = filter $ not . isNothing

justStrings :: [Maybe String] -> [String]
justStrings = map (\str -> fromJust str)

validStrings :: String -> String -> [String]
validStrings rule = justStrings . removeNothings . maybeStrings bits rule

allValidStrings :: [String] -> String -> [[String]]
allValidStrings rules str = map (\rule -> validStrings rule str) rules

reduceStrings :: [String] -> String -> [String]
reduceStrings rules = foldr1 (\curr acc -> intersect acc curr) . allValidStrings rules

reduceAllStrings :: [String] -> [String] -> [String]
reduceAllStrings rules strs = concatMap reduceStrings' strs
  where reduceStrings' = reduceStrings rules

getTheStrings :: [String] -> [String] -> Int -> [String]
getTheStrings rules strs n
  | n == 1 = strs
  | otherwise = getTheStrings rules nextStrings $ n - 1
  where nextStrings = reduceAllStrings rules strs

numValidStrings :: [String] -> Int -> Int
numValidStrings rules n = length theStrings
  where theStrings = getTheStrings rules ["0", "1"] n
