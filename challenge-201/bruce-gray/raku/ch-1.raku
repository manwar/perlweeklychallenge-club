sub task1 ( @ns ) {
    my Set $s = @ns.Set;

    return grep { $_ ∉ $s }, 0 .. @ns.elems;
}


multi sub MAIN (      *@ns   ) { say task1(+«@ns) }
multi sub MAIN ( Bool :$test ) {
    use Test;
    plan 3;
    is-deeply task1([0,1,3]), (2,);
    is-deeply task1([0,1  ]), (2,);
    is-deeply task1([87,29]), (0,1,2);
}
