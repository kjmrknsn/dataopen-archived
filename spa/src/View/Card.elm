module View.Card exposing (view)

import Html exposing (Html, div, h2, main_, p, text)
import Html.Attributes exposing (class)
import Model.Model exposing (Model)


-- VIEW

view : Model -> List(Html msg) -> Html msg
view model body =
    div [ class "card rounded-0" ]
        [ div [ class "card-body" ]
            body
        ]
