{-# LANGUAGE CPP #-}

module Spellbook.Internals
  ( getParentProcessArgs
  ) where
#if defined(mingw32_HOST_OS)
import Spellbook.Internals.Windows
#else
import Spellbook.Internals.Unix
#endif
