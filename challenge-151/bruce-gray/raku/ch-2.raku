# One-line solution to problem. Only offers the score.
sub plot_1line (@h) {
    return (^(2 ** +@h))».base(2).grep({ !/11/ }).map({ [+] @h Z* .flip.comb }).max;
}

# Multiple line solution below allows for important improvements,
# like reporting the details of the plot to our crew,
# instead of just having them drool over the anticipated payout.

sub bin_to_indexes ( Str $b where / ^ <[01]>+ $ / ) {
    return $b.comb.pairs.map({ .key if +.value }).cache;
}

# Stringified binary will make reasoning simpler in sub allowed().
# For $power==3, returns <000 001 010 011 100 101 110 111>
sub binaries ( UInt $power ) {
    my $f = '%0' ~ $power ~ 'b';
    return (^(2 ** $power))».fmt($f);
}

sub allowed ( Str $_ --> Bool ) {
    return not (
           .contains(    '11'  )
           # Could remove optimizations below
        or .contains(    '000' ) # Could always rob the house in the middle.
        or .starts-with( '00'  )
        or .ends-with(   '00'  )
    )
}

# General-purpose routine, when you want *all* the elements that are the maximum, instead of just one max.
sub max_list ( @a, :&by = &[cmp] ) {
    my @r = @a.head;
    for @a.skip -> $a {
        given by( @r.head, $a ) {
            when Order::Less { @r   =   $a }
            when Order::Same { @r.push: $a }
            when Order::More { }
        }
    }
    return @r;
}

# Make our evil plan.
sub plot (@houses) {
    my @score_plots = binaries(@houses.elems)
                    .grep(&allowed)
                    .map(&bin_to_indexes)
                    .map({ @houses[ |.list ].sum, $_ });
    return max_list(@score_plots);
}

sub display ( @houses, @plot ) {
    my %h = @plot.Set;
    my $f = @houses.map({ '%' ~ .chars ~ 's' }).join: ' ';
    my @r =  map { %h{$_} ?? 'R' !! '' }, @houses.keys;
    return sprintf $f, |@r;
}
my @tests =
     7 => (2, 4, 5),
    13 => (4, 2, 3, 6, 5, 3),
     3 => (1, 1, 1, 1, 1, 1),
   335 => (1, 1, 1, 333, 1, 1),
;

for @tests -> ( :key($expected), :value(@in) ) {
    {
        # Also test the one-line version, for thoroughness
        my $got = plot_1line(@in);
        die "$got != $expected in (@in[])" if $got != $expected;
    }

    my @r = plot(@in);
    my ( $best_score, $best_plots ) = @r.head.[0], @r.map( *.[1] );
    die if $best_score != $expected;
    say "@in[] cased; found {$best_plots.elems} plot(s) with highest score $best_score:";
    say display(@in, $_), ' ', $_ for $best_plots.list;
    say '';
}

# Output:
# 2 4 5 cased; found 1 plot(s) with highest score 7:
# R   R (0 2)
#
# 4 2 3 6 5 3 cased; found 1 plot(s) with highest score 13:
# R     R   R (0 3 5)
#
# 1 1 1 1 1 1 cased; found 1 plot(s) with highest score 3:
#   R   R   R (1 3 5)
#
# 1 1 1 333 1 1 cased; found 1 plot(s) with highest score 335:
#   R     R   R (1 3 5)
