// To execute from the command line: `dotnet fsi fsharp/ch-2.fsx`

let task2 (d_and_i_s: string) =
    // lo,hi will be modified via side-effects within .map
    let mutable lo = -1
    let mutable hi =  1 + d_and_i_s.Length

    let squeeze_from_ends (di: char): int =
        if   di = 'D'
        then hi <- hi - 1; hi
        else lo <- lo + 1; lo

    (d_and_i_s + "I")
        |> Seq.map(squeeze_from_ends)
        |> Seq.toList

// This is only used for extra round-trip testing.
let ints_to_DI (ns: list<int>) =
    ns |> List.pairwise
       |> List.map (fun (a, b) -> if a > b then "D" else "I")
       |> List.reduce (+)

// Below this point is test harness and data
let mutable test_number = 0
let is (got: 'a) (expected: 'a) (test_name: string) =
    test_number <- test_number + 1
    let ok_msg = if (got = expected) then "ok" else "not ok"
    printfn $"{ok_msg} {test_number} {test_name}"
    ()

type TestRecord = { di: string; expected: list<int> }
let tests : list<TestRecord> = [
    { di = "IDID" ; expected = [0; 4; 1; 3; 2] };
    { di = "III"  ; expected = [0; 1; 2; 3] };
    { di = "DDI"  ; expected = [3; 2; 0; 1] };
]

for test : TestRecord in tests do
    let got: list<int> = task2 test.di
    is got test.expected ("Task2 example: " + test.di)
    is (ints_to_DI got) test.di ("Task2 example: " + test.di + " round-trip")
