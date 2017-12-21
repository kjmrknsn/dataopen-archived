module View.Modal.SignIn exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Model.Model exposing (Model)
import Model.Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    div
        [ class "modal fade"
        , id "signInModal"
        , tabindex -1
        , attribute "role" "dialog"
        , attribute "aria-labelledby" "signInModalLabel"
        , attribute "aria-hidden" "true"
        ]
        [ div
            [ class "modal-dialog"
            , attribute "role" "document"
            ]
            [ div [ class "modal-content" ]
                [ div [ class "modal-header" ]
                    [ h5 [ class "modal-title", id "signInModalLabel"]
                        [ text "Sign In" ]
                    , button
                        [ type_ "button"
                        , class "close"
                        , attribute "data-dismiss" "modal"
                        , attribute "aria-label" "Close"
                        ]
                        [ span [ attribute "aria-hidden" "true"]
                            [ text "×" ]
                        ]
                    ]
                , div [ class "modal-body" ]
                    [ Html.form []
                        [ div [ class "form-group" ]
                            [ label [ for "userId" ] [ text "User Id" ]
                            , input
                                [ type_ "text"
                                , class "form-control"
                                , id "userId"
                                , placeholder "User Id"
                                , attribute "autocomplete" "username"
                                , onInput SignInFormUserId
                                ] []
                            ]
                        , div [ class "form-group" ]
                            [ label [ for "password" ] [ text "Password" ]
                            , input
                                [ type_ "password"
                                , class "form-control"
                                , id "password"
                                , placeholder "Password"
                                , attribute "autocomplete" "current-password"
                                , onInput SignInFormPassword
                                ] []
                            ]
                        , button
                            [ type_ "button"
                            , class "btn btn-success"
                            , onClick SignIn
                            ] [ text "Sign In" ]
                        ]
                    ]
                ]
            ]
        ]

