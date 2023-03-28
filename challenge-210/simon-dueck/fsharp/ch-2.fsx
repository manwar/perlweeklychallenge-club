(*
    You are given an array of integers which can move in right
    direction if it is positive and left direction when negative.

    If two numbers collide then the smaller one will explode.
    And if both are same then they both explode.
    We take the absolute value in consideration when comparing.
    
    All numbers move at the same speed, therefore any 2 numbers
    moving in the same direction will never collide.
    
    Write a script to find out who survives the collision.
*)

let abs a = if a > 0 then a else 0 - a

let collide a b: int option =
    if (abs a) = (abs b) then None
    elif (abs a) > (abs b) then Some(a)
    else Some(b)

let number_collision arr: int list =

    let rec advance = function
        | x::y::xs when x > 0 && y < 0 -> 
            match collide x y with
            | Some(w) when w > 0 -> advance (w :: xs)
            | Some(w) -> w :: (advance xs)
            | None -> advance xs
        | x::y::xs when x > 0 && y > 0 || x < 0 && y < 0 ->
            x :: advance (y::xs)
        | x -> x

    let rec repeat arr =
        let advanced = advance arr
        if advanced = arr then advanced
        else repeat advanced

    repeat arr

let a = [2; 3; -1;]
printfn $"{number_collision a}"

let b = [3; 2; -4;]
printfn $"{number_collision b}"

let c = [1; -1;]
printfn $"{number_collision c}"