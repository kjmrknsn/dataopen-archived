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


signedIn : NavConf
signedIn =
    { signInHidden = True
    , userIdHidden = False
    }

notSignedIn : NavConf
notSignedIn =
    { signInHidden = False
    , userIdHidden = True
    }
