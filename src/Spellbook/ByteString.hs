{-# LANGUAGE TemplateHaskell #-}

module Spellbook.ByteString
  ( liftByteString
  , liftLazyByteString
  , liftBinary
  ) where

import Data.Binary
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as LBS
import qualified Data.ByteString.Unsafe as BS
import Language.Haskell.TH.Syntax
import System.IO.Unsafe

liftByteString :: BS.ByteString -> Q Exp
liftByteString bs =
  [|unsafePerformIO
      (BS.unsafePackAddressLen
         $(lift (BS.length bs))
         $(pure (LitE (StringPrimL (BS.unpack bs)))))|]

liftLazyByteString :: LBS.ByteString -> Q Exp
liftLazyByteString lbs = [|LBS.fromStrict $(liftByteString (LBS.toStrict lbs))|]

liftBinary :: Binary a => a -> Q Type -> Q Exp
liftBinary a t = [|decode $(liftLazyByteString (encode a)) :: $(t)|]
