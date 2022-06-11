use Prime::Factor;

sub is-square-free ( UInt $n ) { $n.&prime-factors.repeated.not }

say join ', ', grep &is-square-free, 1..500;
