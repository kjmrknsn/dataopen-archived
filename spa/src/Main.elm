import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Model.Model exposing (Model)
import Model.Msg exposing (Msg(..))
import Model.Page exposing (Page(..))
import Navigation exposing (Location)
import UrlParser exposing ((</>))
import View.MainContent as MainContent
import View.Modal.SignIn as SignIn
import View.Nav as Nav


main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


init : Location -> (Model, Cmd Msg)
init location =
    ( { page = Home }
    , Cmd.none
    )


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UrlChange location -> urlUpdate location model
        SignIn -> (model, Cmd.none)


urlUpdate : Navigation.Location -> Model -> ( Model, Cmd Msg )
urlUpdate location model =
    case decode location of
        Nothing ->
            ( { model | page = Home }, Cmd.none )

        Just route ->
            ( { model | page = route }, Cmd.none )


decode : Location -> Maybe Page
decode location =
    UrlParser.parseHash routeParser location


routeParser : UrlParser.Parser (Page -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map Home UrlParser.top
        ]


-- VIEW

view : Model -> Html Msg
view model =
    div [ class "h-100" ]
        [ Nav.view model
        , MainContent.view model
        , SignIn.view model
        ]
