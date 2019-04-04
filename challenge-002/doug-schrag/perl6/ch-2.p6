use v6;

sub MAIN(Cool $n, Bool :$to35 = True, Bool :$to10 ) {
        say $to10 ?? :35($n) !! $n.base(35);
}

