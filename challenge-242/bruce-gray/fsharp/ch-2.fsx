// To execute from the command line: `dotnet fsi fsharp/ch-2.fsx`

let task2 ( arr : int array2d ) =
    let row_count = Array2D.length1 arr
    let col_count = Array2D.length2 arr
    let build_it = fun i j -> (arr[i, col_count - 1 - j] + 1) % 2
    Array2D.init row_count col_count build_it



// Below this point is test harness and data.
let mutable test_number = 0
let is (got: 'a) (expected: 'a) (test_name: string) =
    test_number <- test_number + 1
    let ok_msg = if (got = expected) then "ok" else "not ok"
    printfn $"{ok_msg} {test_number} {test_name}"
    ()

type TestRecord = { input: int array2d; expected: int array2d }
let tests = [
    {
      input    = array2D [[1; 1; 0]; [1; 0; 1]; [0; 0; 0]]
      expected = array2D [[1; 0; 0]; [0; 1; 0]; [1; 1; 1]]
    }
    { input    = array2D [[1; 1; 0; 0]; [1; 0; 0; 1]; [0; 1; 1; 1]; [1; 0; 1; 0]]
      expected = array2D [[1; 1; 0; 0]; [0; 1; 1; 0]; [0; 0; 0; 1]; [1; 0; 1; 0]]
    }
]

for test in tests do
    let got = task2 test.input
    is got test.expected "Task2 example"
