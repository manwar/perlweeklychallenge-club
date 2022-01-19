# Lots of utility subs and support for generating, navigating, and exploring the Calkin-Wilf tree.
# Also, code to generate (the beginnings of) ch-2_tests.txt

# Generate each row by calculating both branches of each elements of the prior row.
sub next-Calkin-Wilf-row ( $prior_row ) {
    return cache gather for $prior_row.list -> Rat $r {
        my $sum = [+] $r.nude;
        take $r.numerator / $sum;
        take         $sum / $r.denominator;
    }
}
constant @CW-rows = (1/1,), &next-Calkin-Wilf-row ... *;


# Linear navigation to next neighbor on same row (or jumping row if at end).
sub next-Calkin-Wilf-neighbor ( Rat \x --> Rat ) {
    my \n = x.floor;
    my \y = x - n;
    return 1/( n + 1 − y );
}
constant @CW-linear = 1/1, &next-Calkin-Wilf-neighbor ... *;


subset LR-Str of Str where / ^ <[LR]>* $ /;
sub Calkin-Wilf-to-LR ( Rat $r --> LR-Str ) {
    my @lineage = $r, &Calkin-Wilf-tree-parent …^ 1/1;
    return @lineage.reverse.map({ <L R>[$_ > 1] }).join;
}

sub LR-to-Calkin-Wilf ( LR-Str $LRs --> Rat ) {
    my $r = 1/1;
    for $LRs.comb -> $lr {
        my $sum = $r.nude.sum;

        $r = ($lr eq 'L') ?? $r.numerator / $sum
          !! ($lr eq 'R') ??         $sum / $r.denominator
          !!                 die "Cannot happen"
          ;
    }
    return $r;
}

sub Calkin-Wilf-tree-parent ( Rat $r --> Rat ) { # Copied from ch-2.raku
    my ( Int \n, Int \d ) =     $r.nude;
    my   Int \diff        = [-] $r.nude;

    return diff > 0
        ?? diff /  d
        !!    n / -diff;
}

# Formatter
sub f ( Rat $r ) {
    my ($n, $d) = $r.nude;
    return    $n.fmt( '%20d')
      ~ '/' ~ $d.fmt('%-20d');
}

sub make-test ( LR-Str $s1 ) {
    my @a = $s1,
            $s1.substr(0, *-1),
            $s1.substr(0, *-2),
    ;

    return @a.map({ f LR-to-Calkin-Wilf($_) }).join(" ") ~ ' # ' ~ $s1;
}

sub make-single-bit-tests ( $size ) {
    for <L R>, <R L> -> ($a, $b) {
        for ^$size -> $X {
            my $Y = $size - $X - 1; # One is for the single $b.
            say make-test( ( $a x $X ) ~ $b ~ ( $a x $Y ) );
        }
    }
    say '';
}

sub make-tests-from-counts ( @counts ) {
    for @counts -> ( $A, $B, $C ) {
        for <L R>, <R L> -> ($a, $b) {
            for <L R> -> $final {
                say make-test( ( ( ( $a x $A ) ~ ( $b x $B ) ) ) x $C ~ $final );
            }
        }
    }
    say '';
}

# For power=6, returns <64 0 1>, <32 32 1>, <16 16 2>, <8 8 4>, <4 4 8>, <2 2 16>, <1 1 32>;
sub make-counts-from-power ( Int $power ) {
    my $size = 2 ** $power;
    return gather {
        take ($size, 0, 1); # Solid line of $size Ls or Rs.
        for $power ^... 0 -> $p {
            my $s = 2 ** $p;
            take ( $s, $s, $size/$s/2 );
        }
    }
}

say @CW-linear.head(33)».nude».join('/');

say $_».nude».join("/") for @CW-rows.head(10);


if 1==1 {
    for @CW-rows.skip(10).head.list {
        say f($_), ' => ', Calkin-Wilf-to-LR($_);
    }
}

# say Calkin-Wilf-to-LR(273/290);
# say Calkin-Wilf-to-LR(21/10); # LLLLLLLLLRR
# say LR-from(21/10); # LLLLLLLLLRR
# say f LR-to-Calkin-Wilf('LLLLLLLLLRR'); # 21/10

if 1==0 { # Demonstrate the first N Left/Right navigations down the tree, as translations from Integer to LR then to CW.
    for ^127 -> $n {
        my LR-Str $LRs = ($n+1).base(2).trans( '0' => 'L', '1' => 'R' ).substr(1);
        say "$LRs => ", f LR-to-Calkin-Wilf($LRs);
    }
}

make-tests-from-counts( make-counts-from-power(5) );
make-tests-from-counts( map { ( $_, 0,  1 ) }, (63 .. 68)              );
make-tests-from-counts( map { ( $_, 0,  1 ) }, (1, {$_ * 10} … 10_000) );
make-tests-from-counts( map { (  1, 1, $_ ) }, (1, {$_ +  4} …     45) );

make-single-bit-tests(16);
