(*
    You are given an array of integers, @ints.
    Write a script to re-arrange the given array in an increasing order
    and return the indices where it differs from the original array.
*)

let check_order arr =
    let rec loop i a b =
        if Seq.isEmpty a then []
        elif Seq.head a = Seq.head b then i :: (loop (i + 1) (Seq.tail a) (Seq.tail b))
        else loop (i + 1) (Seq.tail a) (Seq.tail b)
    in loop 0 arr (Seq.sort arr)

let ints = [ for i in 0..15 do let r = new System.Random() in yield r.NextDouble() * 10. |> int ]

check_order ints