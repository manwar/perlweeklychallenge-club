fun bitwise_or lst =
    List.length(List.filter(fn e => e mod 2 = 0) lst) > 1

val _ =
  print(Bool.toString(bitwise_or([1,2,3,4,5])) ^ "\n");
  print(Bool.toString(bitwise_or([2,3,8,16])) ^ "\n");
  print(Bool.toString(bitwise_or([1,2,5,7,9])) ^ "\n");

