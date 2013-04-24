
import qualified Data.ByteString.Lazy as L

import qualified Network.Bitstamp as Bitstamp

main = do
  print Bitstamp.ticker
--  Bitstamp.ticker >>= L.putStr
  --Bitstamp.order_book >>= L.putStr
