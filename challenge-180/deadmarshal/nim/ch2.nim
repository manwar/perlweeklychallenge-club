import sequtils

proc TrimList(Seq:var seq[int]; i:int):seq[int] = 
  Seq.filter(proc(x:int):bool = x > i)

var
  n = @[1,4,2,3,5]
  n2 = @[9,0,6,2,3,8,5]
  
proc main() =
  echo TrimList(n, 3)
  echo TrimList(n2, 4)
  
main()
