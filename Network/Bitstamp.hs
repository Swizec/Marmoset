{-# LANGUAGE NoMonomorphismRestriction, OverloadedStrings #-}

module Network.Bitstamp (
  ticker,
  order_book
  ) where

import Network.HTTP.Conduit
import Control.Monad.IO.Class
import Data.ByteString.Lazy
import qualified Data.ByteString.Lazy.Char8 as BS
import Data.Aeson
import Data.Attoparsec.Number
import Control.Applicative
import Control.Monad.Trans

data Ticker = Ticker
              { high :: String,
                last :: String,
                bid :: String,
                volume :: String,
                low :: String,
                ask :: String
              } deriving Show

instance FromJSON Ticker where
  parseJSON (Object v) = Ticker <$>
                         v .: "high" <*>
                         v .: "last" <*>
                         v .: "bid" <*>
                         v .: "volume" <*>
                         v .: "low" <*>
                         v .: "ask"

ticker::(MonadIO m) => m (Maybe Ticker)
ticker = get "ticker" >>= return . decode

order_book = get "order_book"

get::(MonadIO m) => String -> m ByteString
get url = simpleHttp $ "https://www.bitstamp.net/api/"++url
