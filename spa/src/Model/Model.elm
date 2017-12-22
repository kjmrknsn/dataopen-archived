module Model.Model exposing (..)

import Model.NavConf exposing (NavConf)
import Model.Page exposing (Page(..))
import Model.SignInForm exposing (SignInForm)


-- MODEL

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
