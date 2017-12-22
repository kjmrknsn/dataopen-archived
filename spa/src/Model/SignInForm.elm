module Model.SignInForm exposing (..)


type alias SignInForm =
    { userId : String
    , password : String
    , alertHidden: Bool
    }


new : SignInForm
new = { userId = "", password = "", alertHidden = True }


updateUserId : SignInForm -> String -> SignInForm
updateUserId signInForm userId = { signInForm | userId = userId }


updatePassword : SignInForm -> String -> SignInForm
updatePassword signInForm password = { signInForm | password = password }


updateAlertHidden : SignInForm -> Bool -> SignInForm
updateAlertHidden signInForm alertHidden = { signInForm | alertHidden = alertHidden }
