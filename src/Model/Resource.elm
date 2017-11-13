module Model.Resource exposing (..)

import Dict exposing (Dict)

type alias Resource =
  { url : String
  , title : String
  , annotations : Dict String String }
