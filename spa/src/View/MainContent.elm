module View.MainContent exposing (view)

import Html exposing (Html, div, h2, main_, p, text)
import Html.Attributes exposing (class)
import Model.Model exposing (Model)
import View.Card as Card

-- VIEW

view : Model -> Html msg
view model =
    main_ [ class "h-100 bg-light" ]
        [ div [ class "container-fluid h-100" ]
            [ div [ class "row mt-3" ]
                [ div [ class "col" ]
                    [ Card.view model (homeCardBody model)
                    ]
                ]
            ]
        ]


homeCardBody : Model -> List(Html msg)
homeCardBody model =
    [ h2 [ class "card-title" ] [ text "Data Open" ]
    , p [ class "card-text" ] [ text "Data Open is a web-based collaborative data analysis platform. Users can extract, analyze and visualize data by writing Spark application code and submitting it to a Hadoop cluster. Analysis results can be shared with others as a form of a notebook."]
    ]
