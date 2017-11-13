module Model.FakeData exposing (..)

import Dict exposing (Dict)

import Model.Resource exposing (..)

hardcodedResources : List Resource
hardcodedResources =
  [ Resource "https://www.coursera.org/learn/machine-learning" "Machine Learning | Coursera" (Dict.singleton "type" "mooc")
  , Resource "http://ocdevel.com/podcasts/machine-learning" "OCDevel" (Dict.singleton "type" "podcast") ]
