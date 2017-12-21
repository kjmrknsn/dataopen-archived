module View.Nav exposing (view)

import Html exposing (Html, a, button, div, nav, span, text, ul)
import Html.Attributes exposing (attribute, class, href, id, type_)
import Model.Model exposing (Model)


-- VIEW

view : Model -> Html msg
view model =
    nav [ class "navbar navbar-expand-lg navbar-dark bg-dark" ]
        [ a [ class "navbar-brand", href "#" ] [ text "Data Open" ]
        , button
            [ class "navbar-toggler"
            , type_ "button"
            , attribute "data-toggle" "collapse"
            , attribute "data-target" "#navbarNav"
            , attribute "aria-controls" "navbarNav"
            , attribute "aria-expanded" "false"
            , attribute "aria-label" "Toggle navigation"
            ]
            [ span [ class "navbar-toggler-icon" ] [] ]
        , div [ class "collapse navbar-collapse", id "navbarNav" ]
            [ ul [ class "navbar-nav mr-auto" ] []
            , button
                [ class "btn btn-outline-success"
                , type_ "button" ]
                [ text "Sign In" ]
            ]
        ]
