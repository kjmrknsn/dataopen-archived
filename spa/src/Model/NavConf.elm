module Model.NavConf exposing (..)

type alias NavConf =
    { signInHidden : Bool
    , userIdHidden : Bool
    }

new : NavConf
new =
    { signInHidden = True
    , userIdHidden = True
    }
