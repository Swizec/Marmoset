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
              { last::Number,
                high::Number,
                low::Number,
                volume::Number,
                bid::Number,
                ask::Number
              } deriving Show

instance FromJSON Ticker where
  parseJSON (Object v) = Ticker <$>
                         v .: "last" <*>
                         v .: "high" <*>
                         v .: "low" <*>
                         v .: "volume" <*>
                         v .: "bid" <*>
                         v .: "ask"

ticker::Maybe (Maybe Ticker)
ticker = fmap decode $ get "ticker"

order_book = get "order_book"

get::(MonadIO m) => String -> m ByteString
get url = simpleHttp $ "https://www.bitstamp.net/api/"++url
