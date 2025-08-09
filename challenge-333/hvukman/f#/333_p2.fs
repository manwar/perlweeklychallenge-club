// 333 part 2

let input_1 = [| 1;0; 2; 3; 0; 4; 5; 0 |]
let input_2 = [| 1; 2; 3 |]
let input_3 = [| 1; 2; 3; 0 |]
let input_4 = [| 0; 0; 0; 0 |]
let input_5 = [| 1; 2; 0; 3; 4 |]
let inputs_2 = [ input_1; input_2; input_3; input_4; input_5 ]

// if 0 double else x; then truncuate to length of x
let dup (x:int array) = Array.collect (fun x -> match x with 
                                                  |0 -> [|0;0|]
                                                  |_ -> [|x|] ) x |> Array.take (Array.length x)               
    
for i in (inputs_2) do
    for j in dup(i) do
        printf "%i " j
    printf "%s\n" ""
