fun member _ [] = false
  | member x (y::ys) = (x=y) orelse member x ys

fun intersect([],ys) = []
  | intersect(x::xs,ys) =
    if member x ys then x::intersect(xs,ys)
    else intersect(xs,ys)

fun countCommon (xs,ys) =
    length (intersect(xs,ys))

val l1 = ["perl","weekly","challenge"];
val l2 = ["raku","weekly","challenge"];
val l3 = ["perl","raku","python"];
val l4 = ["python","java"];
val l5 = ["guest","contribution"];
val l6 = ["fun","weekly","challenge"];

countCommon (l1,l2);
countCommon (l3,l4);
countCommon (l5,l6);

