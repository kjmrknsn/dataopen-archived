module Model.Msg exposing (Msg(..))

import Json.Decode as Decode exposing (..)
import Http
import Model.Model exposing (Model)
import Navigation exposing (Location)


type Msg
    = UrlChange Location
    | SignInFormUserId String
    | SignInFormPassword String
    | SignIn
    | SignInResult (Result Http.Error String)
    | GetSessionResult (Result Http.Error String)
