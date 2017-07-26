#!/usr/bin/env stack
-- stack runghc --install-ghc --package split
import System.Environment
import System.FilePath.Glob
import System.FilePath
import System.Directory
import Data.List.Split
import Data.Char

main :: IO ()
main = do
  [pattern] <- getArgs
  paths <- glob pattern
  renamed <- mapM (\p -> renameFile p $ capitalizeFileInPath p) paths
  print renamed

capitalizeFileInPath :: FilePath -> FilePath
capitalizeFileInPath path = replaceFileName path (kebabToCamel $ takeFileName path)

kebabToCamel :: String -> String
kebabToCamel str = concatMap capitalize $ splitOn "-" str

capitalize :: String -> String
capitalize (x:xs) = toUpper x : xs
