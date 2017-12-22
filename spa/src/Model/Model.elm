module Model.Model exposing (..)

import Model.NavbarConf exposing (NavbarConf)
import Model.Page exposing (Page(..))
import Model.SignInForm exposing (SignInForm)


type alias Model =
    { page : Page
    , signInForm : SignInForm
    , userId : String
    , navbarConf : NavbarConf
    }

new : Model
new =
    { page = Home
    , signInForm = Model.SignInForm.new
    , userId = ""
    , navbarConf = Model.NavbarConf.new
    }

signedIn : Model -> String -> Model
signedIn model userId =
    { model
    | signInForm = Model.SignInForm.new
    , userId = userId
    , navbarConf = Model.NavbarConf.signedIn
    }

notSignedIn : Model -> Model
notSignedIn model =
    { model
    | signInForm = Model.SignInForm.new
    , userId = ""
    , navbarConf = Model.NavbarConf.notSignedIn
    }
