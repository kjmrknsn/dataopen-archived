module Model.Msg exposing (Msg(..))

import Model.Model exposing (Model)
import Navigation exposing (Location)


type Msg
    = UrlChange Location

