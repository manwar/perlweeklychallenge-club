// To execute from the command line: `dotnet fsi fsharp/ch-1.fsx`

// See also my alternate phrasing of the same solution: ch-1_scary.fsx

let task1 (ns1: int list, ns2: int list) =
    let s1 = Set.ofList ns1
    let s2 = Set.ofList ns2

    let diff (sa: Set<int>) (sb: Set<int>) =
        Set.difference sa sb |> Set.toList

    ( diff s1 s2 , diff s2 s1 )

// Below this point is test harness and data.
let mutable test_number = 0
let is (got: 'a) (expected: 'a) (test_name: string) =
    test_number <- test_number + 1
    let ok_msg = if (got = expected) then "ok" else "not ok" 
    printfn $"{ok_msg} {test_number} {test_name}"
    ()

type TestRecord = { input: list<int> * list<int>; expected: list<int> * list<int> }
let tests: TestRecord list = [
    { input = ( [1; 2; 3]    , [2; 4; 6]    ); expected = ( [1; 3] , [4; 6] ) };
    { input = ( [1; 2; 3; 3] , [1; 1; 2; 2] ); expected = ( [3;  ] , [    ] ) };
]
for test in tests do
    let got = task1 test.input
    is got test.expected "Task1 example"
