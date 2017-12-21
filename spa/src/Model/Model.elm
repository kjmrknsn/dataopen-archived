module Model.Model exposing (Model, SignInForm)

import Model.Page exposing (Page)


-- MODEL

type alias Model =
    { page : Page
    , signInForm : SignInForm
    }

type alias SignInForm =
    { userID : String
    , password : String
    }
