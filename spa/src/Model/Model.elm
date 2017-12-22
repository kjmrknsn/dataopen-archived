module Model.Model exposing (Model)

import Model.Page exposing (Page)
import Model.SignInForm exposing (SignInForm)


-- MODEL

type alias Model =
    { page : Page
    , signInForm : SignInForm
    , signedIn : Bool
    , userId : String
    }
