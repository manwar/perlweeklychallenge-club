# Two ways to carve up the problem.
# Both are extended to work with more than 5 elements.

# This one is concise, but inflexible and fragile.
# find_PQ_int finds the LR for the first 4 iff PQ are Int.
# task2a uses find_PQ_int to check that the same PQ applies everywhere,
# by calculating the PQ for every consecutive 4 elements.
sub find_PQ_int ( (\a, \b, \c, \d) ) {
    my ($D, @PQn) = b² - a*c, b*d - c², a*d - b*c;

    return (@PQn.all %% $D) ?? [@PQn Xdiv $D] !! [];
}
sub task2a ( @ns --> Bool ) {
    my @PQ = find_PQ_int(@ns.head(4))
        or return False;

    return so @PQ eqv @ns.skip.rotor(4 => -3).map(&find_PQ_int).all;
}

# This is longer, but much more versatile and resilient against corner cases.
# find_PQ is a general-purpose, works-with-anything PQ finder. Can return Rats!
# make_2LR generates an infinite Linear Recurrence from PQ and the first two elements.
# find_PQ_constant makes sure the same PQ applies everywhere,
# by feeding the info from `find_PQ` to `make_2LR`, and comparing the sequences. Works with Rats!
# task2b is only True when find_PQ_constant returns Ints.

# Linear Recurrence Relation, second-order with constant coefficients.
sub make_2LR ( (\P, \Q), (\a0, \a1) --> Seq ) {
    # return a0, a1, P * * + Q * * … *;       # Bwaahaahaa!

    my Code $next_lr = { P * $^x + Q * $^y };

    return a0, a1, $next_lr … Inf;
}

sub find_PQ ( $a, $b, $c, $d ) {
    my $PQ_denom = $b² - $a*$c;
    my Rat ($P, $Q);

    # Division by zero can ruin your day.
    if $a == 0 and $b == 0 {
        return 0,0 if $c == 0 and $d == 0; # *any* P or Q could be correct. 

        # If $c != 0 or $d != 0, no P or Q could achieve this; nothing you multiply by zero can ever move the sequence off of zero.
        return Nil;
    }
    elsif $b == 0 {
        # Similar to the above, if $b==0 and $c==0, then d==0 vs d!=0 yield any-answer or no-answer.
        return Nil if $c == 0;

        ($P, $Q) = ($c / $a, $d / $c);
    }
    elsif $a == 0 {
        $Q = $c / $b;
        $P = $d / $b  -  $Q²;
    }
    elsif $PQ_denom == 0 {
        # A geometric series
        # like 2,10,50,250 (factor=5)
        # or   3, 3, 3,  3 (factor=1)
        my Rat $factor = $b / $a;

        if $c == 0 {
            warn "Can't happen??? XXX $a, $b, $c, $d";
            return Nil;
        }
        if $factor != $c/$b or $factor != $d/$c {
            # Like: find_PQ(3, 6, 12, 23);
            return Nil;
        }
        ($P, $Q) = 0/1, $factor;
    }
    else {
        $P = ($b*$d - $c²  ) / $PQ_denom;
        $Q = ($b*$c - $a*$d) / $PQ_denom;
    }

    return ($P, $Q)».narrow;
}

sub find_PQ_constant ( @ns ) {
    die "Minimum 4" if @ns < 4;

    my ( $P, $Q ) = find_PQ( |@ns.head(4) )».narrow;

    my @seq = make_2LR( ($P, $Q), @ns.head(2) );

    return Nil if @ns !eqv @seq.head(+@ns).List;
    return $P, $Q;
}
sub task2b ( @ns --> Bool ) {
    my ( $P, $Q ) = find_PQ_constant(@ns)
        orelse return False;

    return ($P ~~ Int && $Q ~~ Int);
}


my @task_tests =
    ( True , ( 1, 1, 2,  3, 5 ) ),
    ( False, ( 4, 2, 4,  5, 7 ) ),
    ( True , ( 4, 1, 2, -3, 8 ) ),

    # Correct working 2nd-order LRs, but in Rat instead of Int:
    ( False, ( 5,  7, 227/24, 2485/192, 81241/4608 ) ),
    ( False, (24, 24,  37/1 ,  387/8  , 12863/192  ) ),
;
use Test; plan @task_tests * 2;
for ( :&task2a, :&task2b ) -> ( :key($sub_name), :value(&task2) ) {
    for @task_tests -> (Bool $expected, @in) {
        is task2(@in), $expected, "$sub_name - @in[0,1]...";
    }
}
