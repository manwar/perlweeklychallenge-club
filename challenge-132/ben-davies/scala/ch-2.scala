implicit class Relation(r: NonEmptyTuple) {
  inline def but(i: Int) = r.take(i) ++ r.drop(i).drop(1)
}

extension [S <: NonEmptyTuple](ss: List[S])
  def hashjoin[R <: NonEmptyTuple](rs: List[R])(si: Int, ri: Int)(using Ordering[Tuple.Elem[S, si.type]]) = {
    // 1. For each tuple r in the build input R
    //    1.1 Add r to the in-memory hash table
    val init = Map.empty[Tuple.Elem[S, si.type] | Tuple.Elem[R, ri.type], List[R]].withDefaultValue(List.empty)
    val hash = rs.foldRight(init) { (r, acc) => acc.updated(r(ri), r :: acc(r(ri))) }
    // 2. Do a final scan of the probe input S and add the resulting join
    //    tuples to the output relation
    ss sortBy { _(si) } flatMap { s => hash(s(si)) map { s ++ _.but(ri) } }
  }

@main def ch2 = {
  val playerAges = List(
    (20, "Alex" ),
    (28, "Joe"  ),
    (38, "Mike" ),
    (18, "Alex" ),
    (25, "David"),
    (18, "Simon"),
  )
  val playerNames = List(
    ("Alex", "Stewart"),
    ("Joe",  "Root"   ),
    ("Mike", "Gatting"),
    ("Joe",  "Blog"   ),
    ("Alex", "Jones"  ),
    ("Simon","Duane"  ),
  );
  for r <- playerAges.hashjoin(playerNames)(1, 0) do println(r.toList.mkString(" "))
}
