// For the Halloween season, a scary Haskell-style point-free solution!
// To execute from the command line: `dotnet fsi fsharp/ch-1_scary.fsx`

let uncurry   f (x, y) = f x y
let mapBoth   f (x, y) = f x, f y
let fwdAndRev f (x, y) = f (x, y) , f (y, x)

let diffs = mapBoth Set.ofList >> uncurry Set.difference >> Set.toList
let task1 = fwdAndRev diffs


// Below this point is test harness and data.
let mutable test_number = 0
let is (got: 'a) (expected: 'a) (test_name: string) =
    test_number <- test_number + 1
    let ok_msg = if (got = expected) then "ok" else "not ok"
    printfn $"{ok_msg} {test_number} {test_name}"
    ()

//type intListPair = list<int> * list<int> // XXX Include? move higher?
type TestRecord = { input: list<int> * list<int>; expected: list<int> * list<int> }
let tests: TestRecord list = [
    { input = ( [1; 2; 3]    , [2; 4; 6]    ); expected = ( [1; 3] , [4; 6] ) };
    { input = ( [1; 2; 3; 3] , [1; 1; 2; 2] ); expected = ( [3;  ] , [    ] ) };
]
for test in tests do
    let got = task1 test.input
    is got test.expected "Task1 example"
