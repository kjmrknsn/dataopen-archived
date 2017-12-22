module Model.Model exposing (..)

import Model.NavConf exposing (NavConf)
import Model.Page exposing (Page(..))
import Model.SignInForm exposing (SignInForm)


type alias Model =
    { page : Page
    , signInForm : SignInForm
    , userId : String
    , navConf : NavConf
    }

new : Model
new =
    { page = Home
    , signInForm = Model.SignInForm.new
    , userId = ""
    , navConf = Model.NavConf.new
    }

signedIn : Model -> String -> Model
signedIn model userId =
    { model
    | signInForm = Model.SignInForm.new
    , userId = userId
    , navConf = Model.NavConf.signedIn
    }

notSignedIn : Model -> Model
notSignedIn model =
    { model
    | signInForm = Model.SignInForm.new
    , userId = ""
    , navConf = Model.NavConf.notSignedIn
    }
