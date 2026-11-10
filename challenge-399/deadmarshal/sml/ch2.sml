structure Ch2 : sig
  val longestAbsolutePath : string -> int
end =
struct
  type entry = {depth:int,name:string}
  infix 8 |>
  fun x |> f = f x
  
  fun longestAbsolutePath fs =
      let
	fun dictGet (k,lens:(int * int) list) =
	    case List.find (fn(k',_) => k' = k) lens of
	      SOME(_,v) => v
	    | NONE => 0
	fun dictInsert(k,v,lens:(int * int) list) =
	    (k,v) :: List.filter(fn(k',_) => k' <> k) lens
	fun parse line =
	    let
	      val n = String.size line
	      fun count i =
		  if i < n andalso String.sub(line,i) = #"\t"
		  then count(i+1)
		  else i
	      val d = count 0
	    in
	      {depth=d,name=String.extract(line,d,NONE)}
	    end
	fun parentLen(depth,lens) =
	    if depth = 0 then 0 else dictGet(depth-1,lens) + 1
	fun walk([],_,best) = best
	  | walk({depth,name}::rest,lens,best) =
	    let
	      val len = parentLen(depth,lens) + String.size name
	      val isDir =
		case rest of
		  {depth=nextDepth,...}::_ => nextDepth > depth
		| [] => false
	      val isFile = not isDir andalso
	      String.isSubstring "." name
	      val best' = if isFile then Int.max(best,len) else best
	    in
	      walk(rest,dictInsert(depth,len,lens),best')
	    end
	val entries =
	  String.fields (fn c => c = #"\n") fs
			|> List.filter (fn line => line <> "")
			|> List.map parse
      in
	walk(entries,[],0)
      end
end

val _ =
  let val l = List.map Ch2.longestAbsolutePath
		       ["dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2",
			"file1.txt\nfile2.ext\na.png",
			"my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png",
			"root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt",
			"a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"]
    fun printIntList xs =
	print ("[" ^ String.concatWith ", "
		   (List.map Int.toString xs) ^ "]\n")
  in
    printIntList l
  end

