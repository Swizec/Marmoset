{-# LANGUAGE NoMonomorphismRestriction #-}

module Network.Bitstamp (
  ticker,
  order_book
  ) where

import Network.HTTP.Conduit


ticker = get "https://www.bitstamp.net/api/ticker/"

order_book = get "https://www.bitstamp.net/api/ticker/"


get url = simpleHttp url
