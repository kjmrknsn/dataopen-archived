port module Main exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Http
import Model.Model exposing (Model)
import Model.Msg exposing (Msg(..))
import Model.Page exposing (Page(..))
import Model.SignInForm exposing (SignInForm)
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
    , signInForm = Model.SignInForm.new
    , userId = Nothing
    }
    , Cmd.none
    )


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UrlChange location -> urlUpdate location model
        SignInFormUserId userId ->
            ({ model | signInForm = Model.SignInForm.updateUserId model.signInForm userId }, Cmd.none)
        SignInFormPassword password ->
            ({ model | signInForm = Model.SignInForm.updatePassword model.signInForm password }, Cmd.none)
        SignIn ->
            (model, Http.send SignInResult (signIn model.signInForm))
        SignInResult result ->
            case result of
                Ok userId ->
                    ({ model | signInForm = Model.SignInForm.new, userId = Just userId }, click "closeSignInModal")
                Err _ ->
                    ({ model | signInForm = Model.SignInForm.updateAlertHidden model.signInForm False }, Cmd.none)


urlUpdate : Location -> Model -> ( Model, Cmd Msg )
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
        [ ("userId", Encode.string signInForm.userId)
        , ("password", Encode.string signInForm.password)
        ]


signIn : SignInForm -> Http.Request String
signIn signInForm =
    let
        body =
            signInForm
                |> signInFormEncoder
                |> Http.jsonBody
    in
        Http.post "/web/sign_in" body decodeSession


decodeSession: Decode.Decoder String
decodeSession=
  Decode.at ["userId"] Decode.string


view : Model -> Html Msg
view model =
    div [ class "h-100" ]
        [ Nav.view model
        , MainContent.view model
        , SignIn.view model
        ]

port click : String -> Cmd msg
