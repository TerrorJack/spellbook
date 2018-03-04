module Spellbook.Internals.Windows
  ( getParentProcessArgs
  ) where

import Data.Foldable
import System.Process
import System.Win32

getParentProcessArgs :: IO [String]
getParentProcessArgs = do
  pes <- withTh32Snap tH32CS_SNAPPROCESS Nothing th32SnapEnumProcesses
  pid <- getCurrentProcessId
  let Just (_, _, ppid, _, _) = find (\(x, _, _, _, _) -> x == pid) pes
  r <-
    readProcess
      "wmic"
      ["process", "where", "processid=" ++ show ppid, "get", "commandline"]
      ""
  pure $ tail $ words $ lines r !! 1
