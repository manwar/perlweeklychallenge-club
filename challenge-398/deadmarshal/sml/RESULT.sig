signature RESULT =
sig
  datatype ('a,'b) t = Ok of 'a
		     | Error of 'b
				  
  val isOk : ('a,'b) t -> bool

  val isError : ('a,'b) t -> bool

  val map : ('a,'b) t -> ('a -> 'c) -> ('c,'b) t

  val mapError : ('a,'b) t -> ('b -> 'c) -> ('a,'c) t

  val flatten : (('a,'b) t,'b) t -> ('a,'b) t

  val try : ('a,'b) t -> ('a -> ('c,'b) t) -> ('c,'b) t

  val unwrap : ('a,'b) t -> 'a -> 'a

  val lazyUnwrap : ('a,'b) t -> (unit -> 'a) -> 'a

  val unwrapError : ('a,'b) t -> 'b -> 'b

  val or : ('a,'b) t -> ('a,'b) t -> ('a,'b) t

  val lazyOr : ('a,'b) t -> (unit -> ('a,'b) t) -> ('a,'b) t

  val all : (('a,'b) t list) -> ('a list,'b) t

  val partition : ('a,'b) t list -> ('a list * 'b list)

  val replace : ('a,'b) t -> 'c -> ('c,'b) t

  val replaceError : ('a,'b) t -> 'c -> ('a,'c) t

  val values : ('a,'b) t list -> 'a list

  val tryRecover : ('a,'b) t -> ('b -> ('a,'c) t) -> ('a,'c) t
end;

