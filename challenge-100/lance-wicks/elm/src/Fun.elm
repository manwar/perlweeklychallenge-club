module Fun exposing (convert)


convert : String -> String
convert time =
    if String.contains "am" time then
        String.slice 0 5 time

    else if String.contains "pm" time then
        let
            hourMin =
                String.split ":" time
        in
        case List.head hourMin of
            Just a ->
                let
                    hour =
                        String.toInt a
                in
                case hour of
                    Just h ->
                        let
                            hx =
                                h + 12
                        in
                        String.fromInt hx ++ String.slice 2 5 time

                    Nothing ->
                        ""

            Nothing ->
                ""

    else
        let
            hourMin =
                String.split ":" time
        in
        case List.head hourMin of
            Just a ->
                let
                    hour =
                        String.toInt a
                in
                case hour of
                    Just h ->
                        if h > 12 then
                            let
                                hx =
                                    h - 12
                            in
                            let
                                hourStr =
                                    String.fromInt hx
                            in
                            if String.length hourStr > 1 then
                                hourStr ++ String.slice 2 5 time ++ "pm"

                            else
                                "0" ++ hourStr ++ String.slice 2 5 time ++ "pm"

                        else
                            String.slice 0 5 time ++ "am"

                    Nothing ->
                        ""

            Nothing ->
                ""
