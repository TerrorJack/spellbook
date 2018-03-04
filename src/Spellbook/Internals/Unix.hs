module Spellbook.Internals.Unix
  ( getParentProcessArgs
  ) where

import qualified Data.ByteString.Char8 as CBS
import System.Posix.ByteString

getParentProcessArgs :: IO [String]
getParentProcessArgs = do
  ppid <- getParentProcessID
  r <- CBS.readFile $ "/proc/" ++ show ppid ++ "/cmdline"
  pure $ map CBS.unpack $ filter (not . CBS.null) . tail $ CBS.split '\0' r
