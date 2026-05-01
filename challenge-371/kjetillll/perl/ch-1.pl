sub f {
    my( $a, $b, $c, $d, $e ) = map ord, @_;
    chr [
        $b - $d + $c,
        $c - $e + $d,
        $d - $b + $a,
        $e - $c + $b,
        $d - $b + $c
        ] -> [ .5 * index "@_", "?" ]
}

print pop(@$_) eq f(@$_) ? "ok\n" : "ERROR ".f(@$_)."\n" for
[ qw( a c ? g i      e) ],  # ex1
[ qw( a d ? j m      g) ],  # ex2
[ qw( a e ? m q      i) ],  # ex3
[ qw( a c f ? k      h) ],  # ex4
[ qw( b e g ? l      j) ],  # ex5

[ qw( ? b c d e      a) ],
[ qw( ? c d f g      a) ],
[ qw( ? b f g k      a) ],

[ qw( a ? f g k      b) ],
[ qw( a ? c d e      b) ],

[ qw( a b ? g k      f) ],
[ qw( a b ? d e      c) ],

[ qw( a b f ? k      g) ],
[ qw( a d g ? m      j) ],

[ qw( a b f g ?      k) ],
[ qw( a f k p ?      u) ],
map {
    my($x, $y, $i) = map int(1+rand(5)), 1..3;
    my @a = map {chr 96 + ( $i += [$x, $y]->[$_ % 2] ) } 1..5;
    my $q = int( rand(5) );
    my $r = $a[$q];
    $a[$q] = '?';
    [@a, $r]
}
1 .. ( $ENV{EXTRA_TESTS} // 5 )

# https://theweeklychallenge.org/blog/perl-weekly-challenge-371/
# EXTRA_TESTS=100000 perl ch-1.pl|sort|uniq -c
# 100016 ok
