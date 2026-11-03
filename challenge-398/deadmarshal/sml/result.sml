structure Result : RESULT =
struct
datatype ('a,'b) t = Ok of 'a
		   | Error of 'b

(* private: *)
fun tryMap xs f =
    let fun aux [] _ acc = Ok(rev acc)
	  | aux (x :: xs) f acc =
	    case f(x) of
		(Ok first) => aux xs f (first :: acc)
	      | (Error e) => Error e
    in
      aux xs f []
    end

fun filterMap xs f =
    let fun aux [] _ acc = rev acc
	  | aux (x::xs) f acc =
	    let val newAcc = case f(x) of
				 (Ok first) => first :: acc
			       | (Error _) => acc
	    in
	      aux xs f newAcc
	    end
    in
      aux xs f []
    end

(* public: *)
fun isOk (Ok _) = true
  | isOk (Error _) = false

fun isError (Error _) = true
  | isError (Ok _) = false

fun map (Ok x) f = Ok(f x)
  | map (Error e) _ = Error e

fun mapError (Ok x) _ = Ok x
  | mapError (Error e) f = Error(f e)

fun flatten (Ok x) = x
  | flatten (Error e) = Error e

fun try (Ok x) f = f x
  | try (Error e) _ = Error e

fun unwrap (Ok x) _ = x
  | unwrap (Error _) default = default

fun lazyUnwrap (Ok x) _ = x
  | lazyUnwrap (Error _) default = default ()
					   
fun unwrapError (Ok _) default = default
  | unwrapError (Error e) _ = e

fun or (first as (Ok _)) _ = first
  | or (Error _) second = second

fun lazyOr (first as (Ok _)) _ = first
  | lazyOr (Error _) second = second ()

fun all results = tryMap results (fn r => r)

fun partition results =
    let fun partitionLoop results oks errors =
	    case results of
		[] => (oks,errors)
	      | (Ok(x)::rest) => partitionLoop rest (x::oks) errors
	      | (Error(e)::rest) => partitionLoop rest oks (e::errors)
    in
      partitionLoop results [] []
    end
      
fun replace (Ok _) value = Ok value
  | replace (Error e) _ = Error e

fun replaceError (Ok v) _ = Ok v
  | replaceError (Error _) e = Error e

fun values results = filterMap results (fn x => x)

fun tryRecover (Ok v) _ = Ok v
  | tryRecover (Error e) f = f e
end;

