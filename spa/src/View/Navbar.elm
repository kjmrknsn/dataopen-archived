module View.Navbar exposing (view)

import Html exposing (Html, a, button, div, nav, span, text, ul)
import Html.Attributes exposing (attribute, class, hidden, href, id, type_)
import Html.Events exposing (onClick)
import Model.Model exposing (Model)
import Model.Msg exposing (Msg(..))
import Version exposing (version)


view : Model -> Html Msg
view model =
    nav [ class "navbar navbar-expand-sm navbar-dark bg-dark" ]
        [ div []
            [ a [ class "navbar-brand", href "#" ] [ text "Data Open" ]
            , span [ class "small text-secondary" ] [ text ("version " ++ version) ]
            ]
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
                , type_ "button"
                , attribute "data-toggle" "modal"
                , attribute "data-target" "#signInModal"
                , hidden model.navbarConf.signInHidden
                ]
                [ text "Sign In" ]
            , span
                [ class "text-white"
                , hidden model.navbarConf.userIdHidden
                ]
                [ text model.userId ]
            ]
        ]
