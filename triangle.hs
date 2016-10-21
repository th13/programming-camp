import Data.List
import Data.Maybe

rowStart :: Int -> Int
rowStart 1 = 1
rowStart row = rowStart (row - 1) + (row - 1)

triangle :: Int -> [[Int]]
triangle 0 = []
triangle n = triangle (n-1) ++ [[startn..lastn]]
  where startn = rowStart (n)
        lastn = startn + n - 1

whichRow :: Int -> [[Int]] -> Int
whichRow p [] = 0
whichRow p triangle = if elem p (head triangle) then 1 else 1 + whichRow p (tail triangle)

whichIndex :: Int -> [[Int]] -> Int
whichIndex p triangle = fromJust $ elemIndex p row
  where rowNumber = whichRow p triangle
        row = triangle !! (rowNumber - 1)

sideLength :: [[Int]] -> [Int] -> Int
sideLength triangle [p1, p2]
  | p1Row == p2Row = abs (p1 - p2)
  | indexDiff == 0 || indexDiff == rowDiff = rowDiff
  | otherwise = -1
  where p1Row = whichRow p1 triangle
        p2Row = whichRow p2 triangle
        p1Index = whichIndex p1 triangle
        p2Index = whichIndex p2 triangle
        indexDiff = p1Index - p2Index
        rowDiff = abs (p1Row - p2Row)

isEdge :: [Int] -> [[Int]] -> Bool
isEdge pts triangle = edgeLength > 0
  where edgeLength = sideLength triangle pts

pairs :: [Int] -> [[Int]]
pairs xs = [[x1, x2] | (x1:xs1) <- tails xs, x2 <- xs1]

edgeLengths :: [[Int]] -> [Int] -> [Int]
edgeLengths triangle pts = map (sideLength triangle) (pairs pts)

removeNonEdges :: [Int] -> [Int]
removeNonEdges = filter (>0)

sameItems :: (Eq a) => [a] -> Bool
sameItems xs = all (== head xs) (tail xs)

whichShape :: [[Int]] -> [Int] -> String
whichShape triangle pts =
  if allSame
    then do
      case length pts of
        3 -> "triangle"
        4 -> "parallelagram"
        6 -> "hexagon"
        otherwise -> "NaS" -- not a shape
    else "NaS"
  where edges = removeNonEdges $ edgeLengths triangle pts
        allSame = sameItems edges
