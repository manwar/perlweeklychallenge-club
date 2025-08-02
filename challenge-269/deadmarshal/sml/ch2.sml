fun distribute_elements lst =
    let fun aux [] acc1 acc2 = acc1 @ acc2
	  | aux (x::xs) acc1 acc2 =
	    if (List.hd(List.rev acc1)) > (List.hd(List.rev acc2))
	    then aux xs (acc1 @ [x]) acc2
	    else aux xs acc1 (acc2 @ [x])
    in
      aux (List.tl (List.tl lst)) [List.hd lst] [List.hd(List.tl lst)]
    end
	
fun print_list(nil) = ()
  | print_list(x::xs) = (
    print(Int.toString(x));
    print(" ");
    print_list(xs);
    print("\n")
  );

val _ = (
  print_list(distribute_elements([2,1,3,4,5]));
  print_list(distribute_elements([3,2,4]));
  print_list(distribute_elements([5,4,3,8]))
)

