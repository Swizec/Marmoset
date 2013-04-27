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
              { high :: Double,
                last :: Double,
                bid :: Double,
                volume :: Double,
                low :: Double,
                ask :: Double
              } deriving Show

instance FromJSON Ticker where
  parseJSON (Object v) = Ticker <$>
                         (read <$> v .: "high") <*>
                         (read <$> v .: "last") <*>
                         (read <$> v .: "bid") <*>
                         (read <$> v .: "volume") <*>
                         (read <$> v .: "low") <*>
                         (read <$> v .: "ask")

ticker::(MonadIO m) => m (Maybe Ticker)
ticker = get "ticker" >>= return . decode

order_book = get "order_book"

get::(MonadIO m) => String -> m ByteString
get url = simpleHttp $ "https://www.bitstamp.net/api/"++url
