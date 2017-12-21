import Html exposing (Attribute, Html, a, button, div, h1, li, nav, span, text, ul)
import Html.Attributes exposing (attribute, class, href, id, type_)
import Navigation


main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


-- MODEL

type alias Model =
    { history : List Navigation.Location
    }


init : Navigation.Location -> ( Model, Cmd Msg)
init location =
    ( Model [ location ]
    , Cmd.none
    )


-- UPDATE

type Msg = UrlChange Navigation.Location


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UrlChange location ->
            ( { model | history = location :: model.history }
            , Cmd.none
            )


-- VIEW

view : Model -> Html msg
view model =
    div []
        [ nav [ class "navbar navbar-expand-lg navbar-dark bg-dark" ]
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
        ]
