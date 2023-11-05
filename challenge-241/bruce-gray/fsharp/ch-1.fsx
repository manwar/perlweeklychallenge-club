// To execute from the command line: `dotnet fsi fsharp/ch-1.fsx`

// Two solutions; set this var to 1 or 2 to select.
let algorithm = 1

// Raku: +grep { $s{ $_ + $diff } and $s{ $_ + $diff + $diff } }, @ns;
let task1_set_scan (diff: int) (ns: int list) =
    let s = Set.ofSeq ns

    ns  |> List.filter (fun v -> (Set.contains (v + diff       ) s))
        |> List.filter (fun v -> (Set.contains (v + diff + diff) s))
        |> List.length

// Raku: elems [∩] @ns, (@ns X+ $diff), (@ns X+ ($diff *2));
let task1_set_intersection (diff: int) (ns: int list) =
    let span_ns (spans_of_diff: int) = 
        let span = diff * spans_of_diff
        set (List.map (fun n -> n + span) ns)

    [0..2]  |> List.map (fun n -> (span_ns n))
            |> Set.intersectMany
            |> Set.count


let task1 (diff) (ns) =
    if diff = 0 then 0
    elif algorithm = 1 then task1_set_scan         diff ns
    elif algorithm = 2 then task1_set_intersection diff ns
    else failwithf "Unexpected algorithm: {algorithm}"


// Below this point is test harness and data
let mutable test_number = 0
let is (got: 'a) (expected: 'a) (test_name: string) =
    test_number <- test_number + 1
    let ok_msg = if (got = expected) then "ok" else "not ok" 
    printfn $"{ok_msg} {test_number} {test_name}"
    ()

type TestRecord = { expected: int; diff: int; ns: int list }
let tests = [
    { expected = 2; diff = 3; ns = [0; 1; 4; 6; 7; 10] };
    { expected = 2; diff = 2; ns = [4; 5; 6; 7; 8;  9] };
]

for test in tests do
    let got = task1 test.diff test.ns
    is got test.expected "Task1 example"

let test_large (diff_range: int list) (ns: int list) (expected: int list) =
    let got = List.map (fun diff -> task1 diff ns) diff_range
    is got expected

test_large
    [0 .. 45]
    [10;11;12;14;15;17;18;20;21;25;26;27;28;29;31;33;35;37;39;41;42;46;48;49;50;51;52;54;56;59;60;61;62;63;65;67;71;73;79;82;85;86;87;88;89;92;93;94;97;98]
    [0;14;16;12;16;10;15;8;10;7;10;12;9;10;9;13;4;12;5;12;5;12;6;8;8;9;6;3;5;3;5;5;4;4;7;4;6;4;5;4;2;3;2;1;1;0]
    "Random 50, over diffs of 0..45"

test_large
    [1 .. 500]
    [1..1000]
    [998 .. -2 .. 0]
    "All 1000 over diffs of 1..500"
