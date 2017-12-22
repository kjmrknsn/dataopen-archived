module Model.NavbarConf exposing (..)


type alias NavbarConf =
    { signInHidden : Bool
    , userIdHidden : Bool
    }


new : NavbarConf
new =
    { signInHidden = True
    , userIdHidden = True
    }


signedIn : NavbarConf
signedIn =
    { signInHidden = True
    , userIdHidden = False
    }

notSignedIn : NavbarConf
notSignedIn =
    { signInHidden = False
    , userIdHidden = True
    }
