fun multiply_by_two list start =
    if List.exists(fn x => x = start) list
    then multiply_by_two list (start * 2)
    else start

val _ =
    print(Int.toString(multiply_by_two [5,3,6,1,12] 3) ^ "\n");
    print(Int.toString(multiply_by_two [1,2,3,4] 1) ^ "\n");
    print(Int.toString(multiply_by_two [5,6,7] 2) ^ "\n");

