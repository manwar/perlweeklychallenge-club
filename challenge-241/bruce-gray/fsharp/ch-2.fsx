// To execute from the command line: `dotnet fsi fsharp/ch-2.fsx`

let factorCount (num: int) =
    let rec fc  (num: int, divisor: int) =
        if   num < divisor     then  0
        elif num % divisor = 0 then (1 + fc (num/divisor, divisor  ))
        else                        (0 + fc (num        , divisor+1))
    fc (num, 2)

let task2 (nums: int list) =
    let comparer (n1: int) (n2: int) =
        let c = compare (factorCount n1) (factorCount n2)
        if c <> 0 then c else
            compare n1 n2
    nums |> List.sortWith comparer


// Below this point is test harness and data
let mutable test_number = 0
let is (got: 'a) (expected: 'a) (test_name: string) =
    test_number <- test_number + 1
    let ok_msg = if (got = expected) then "ok" else "not ok" 
    printfn $"{ok_msg} {test_number} {test_name}"
    ()

is (task2 [11; 8; 27; 4]) 
    [11; 4; 8; 27]
    "task2 example"
