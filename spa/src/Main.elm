import Html exposing (Attribute, Html, a, button, div, h1, li, nav, span, text, ul)
import Html.Attributes exposing (attribute, class, href, id, type_)
import Model.Model exposing (Model)
import Navigation
import View.Nav as Nav


main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


init : Navigation.Location -> (Model, Cmd Msg)
init location =
    ( Model
    , Cmd.none
    )


-- UPDATE

type Msg = UrlChange Navigation.Location


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UrlChange location ->
            ( model
            , Cmd.none
            )


-- VIEW

view : Model -> Html msg
view model =
    div []
        [ Nav.view model
        ]
