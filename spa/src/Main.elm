import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Http
import Model.Model exposing (Model, SignInForm)
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
    (
    { page = Home
    , signInForm = { userID = "", password = "" }
    }
    , Cmd.none
    )


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UrlChange location -> urlUpdate location model
        SignInFormUserID userID ->
            let
                signInForm = model.signInForm
                newSignInForm = { signInForm | userID = userID }
            in
                ({ model | signInForm = newSignInForm }, Cmd.none)
        SignInFormPassword password ->
            let
                signInForm = model.signInForm
                newSignInForm = { signInForm | password = password }
            in
                ({ model | signInForm = newSignInForm }, Cmd.none)
        SignIn ->
            (model, Http.send SignInResult (signIn model.signInForm))
        SignInResult result ->
            case result of
                Ok _ ->
                    (model, Cmd.none)
                Err _ ->
                    (model, Cmd.none)


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


signInFormEncoder : SignInForm -> Encode.Value
signInFormEncoder signInForm =
    Encode.object
        [ ("userID", Encode.string signInForm.userID)
        , ("password", Encode.string signInForm.password)
        ]


signIn : SignInForm -> Http.Request Decode.Value
signIn signInForm =
    let
        body =
            signInForm
                |> signInFormEncoder
                |> Http.jsonBody
    in
        Http.post "/web/sign_in" body Decode.value


-- VIEW

view : Model -> Html Msg
view model =
    div [ class "h-100" ]
        [ Nav.view model
        , MainContent.view model
        , SignIn.view model
        ]
