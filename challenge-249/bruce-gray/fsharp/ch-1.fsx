// To execute from the command line: `dotnet fsi fsharp/ch-1.fsx`

type tII = int * int      // Tuple of two `int`s
let make_tII (ns: list<int>):tII = ns.[0], ns.[1]
let tII_same (x: tII): bool = fst x = snd x

let list_to_sorted_tuples_of_two (xs) =
    xs  |> List.sort
        |> List.chunkBySize 2
        |> List.map (make_tII)

let task1 (ns: list<int>) =

    let n_n: list<tII> = ns |> list_to_sorted_tuples_of_two

    let all_equal: bool = n_n |> List.forall tII_same

    if all_equal then n_n else []


// Below this point is test harness and data
let mutable test_number = 0
let is (got: 'a) (expected: 'a) (test_name: string) =
    test_number <- test_number + 1
    let ok_msg = if (got = expected) then "ok" else "not ok"
    printfn $"{ok_msg} {test_number} {test_name}"
    ()

type TestRecord = { ns: list<int>; expected: list<tII>; }
// Note: first task example changed here to sorted order, to ease testing.
let tests : list<TestRecord> = [
    { ns = [3; 2; 3; 2; 2; 2]; expected = [(2, 2); (2, 2); (3, 3)] };
    { ns = [1; 2; 3; 4]; expected = [] }
]
for test : TestRecord in tests do
    let got : list<tII> = task1 test.ns
    is got test.expected "Task1 example"
