
import Network.HTTP.Conduit
import qualified Data.ByteString.Lazy as L

main = do
  rsp <- simpleHttp "https://www.bitstamp.net/api/ticker/"

  L.putStr rsp
