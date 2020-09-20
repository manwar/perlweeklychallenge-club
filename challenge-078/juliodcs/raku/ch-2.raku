sub rotate {
    my \A = (7, 4, 2, 6, 3);
    my \B = (1, 3, 4);
    for B -> \rotation {
        say (|^A).map: { A[ ($^index + rotation) % A.elems ] }
    }
}

rotate;