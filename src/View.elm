module View exposing (view)

import Html exposing (Html, div, p, button, h1, input, span, select, label, table, tr, td)
import Html.Attributes exposing (class, classList, style, placeholder, value)
import Html.Events exposing (onInput, onClick)
import Dict

import Model exposing (..)
import Model.Ui exposing (..)
import Model.Resource exposing (..)
import Msg exposing (..)

import Json.Encode as Json
import Debug exposing (log)


view : Model -> Html Msg
view ({ui} as model) =
  case ui.screen of
    MainScreen ->
      renderMainScreen model


renderMainScreen : Model -> Html Msg
renderMainScreen model =
  [ renderNotification model
  , renderPageHeader
  , renderSearchResults model ]
  |> div [ class "PageContainer" ]


renderPageHeader : Html Msg
renderPageHeader =
  let
      fakeSearchTextField =
        Html.img [ Html.Attributes.src "images/fakeSearchTextField.png" ] []
      children =
        [ fakeSearchTextField ]
  in
      div [ class "PageHeader" ] children

renderSearchResults : Model -> Html Msg
renderSearchResults model =
  let
      heading = p [ class "SearchResults__NumberOfResults" ] [ Html.text ("About " ++ (model.resources |> List.length |> toString) ++ " results") ]
      resources = model.resources |> List.map renderResource |> div []
  in
     div [] [ heading, resources ]


renderResource : Resource -> Html Msg
renderResource ({annotations} as resource) =
  let
      title =
        Html.h3 [] [ Html.a [ Html.Attributes.href resource.url ] [ resource.title |> Html.text ] ]
      url =
        Html.cite [] [ Html.text resource.url ]
      resourceType =
        case annotations |> Dict.get "type" of
          Nothing ->
            []

          Just str ->
            [ span [] [ str |> Html.text] ]
      urlLine =
        div [] (resourceType ++ [ url ])
      children =
        [ title, urlLine ]
  in
      div [ class "SearchListView__Item" ] children


renderNotification : Model -> Html Msg
renderNotification model =
  case model.errorMsg of
    Nothing ->
      div [] []

    Just msg ->
      div [ class "Notification" ] [ Html.text msg ]
