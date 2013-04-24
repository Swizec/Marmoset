
import qualified Data.ByteString.Lazy as L

import qualified Network.Bitstamp as Bitstamp

main = do
  Bitstamp.ticker >>= L.putStr
  Bitstamp.order_book >>= L.putStr
