module Range exposing (..)

range : Int -> Int -> List Int
range start end =
    if start < end then
        start :: range (start + 1) end
    else
        []