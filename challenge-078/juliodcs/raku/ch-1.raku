sub get-leaders {
    my \A          = ( 9, 10, 7, 5, 6, 1 );
    sub is-last    { $^i == A.elems - 1 }
    sub current    { A[$^i] }
    sub following  { A[$^i + 1] }
    sub is-leading { current($^i) > following($^i) }
    sub is-leader  { is-last($^i) || is-leading($^i) }
    sub if-leader  { is-leader($^i) ?? current($^i) !! () }
    sub add-leader { ($^list.flat, if-leader($^pos)).flat }

    A.elems == 0 ?? (0) !! [[&add-leader]] ((), |^A)
}

say get-leaders;
