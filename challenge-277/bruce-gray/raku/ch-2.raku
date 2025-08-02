# See blog post for detailed commentary.

sub Triangle       ( UInt $n --> UInt ) { $n * ($n-1) div 2   }  # https://oeis.org/A000217 , [+]1..$n
sub Quarter-square ( UInt $n --> UInt ) { $n *  $n    div 4   }  # https://oeis.org/A002620
sub N42            ( UInt $n --> UInt ) { 4 ** $n  -  2 ** $n }  # https://oeis.org/A020522

sub task2_combo_unique ( @ns --> UInt ) {

    sub is_strong_pair ( (\x,\y) --> Bool ) { 0 < abs(x - y) < min(x,y) }

    return +grep &is_strong_pair, combinations(@ns.unique, 2);
}
sub task2_combo_sort ( @ns --> UInt ) {

    return +grep ->(\x,\y){ (y - x) < x }, combinations( @ns.sort(+*).squish, 2 );
}
sub task2_linear_after_sort ( @ns --> UInt ) {
    my @ns_ss = @ns.sort(+*).squish;

    my ( $y, $r ) = 0 xx *;
    for @ns_ss.kv -> $x, $xv {
        my $x2 = $xv * 2;

        $y++ while ($y+1) <= @ns_ss.end and @ns_ss[$y+1] < $x2;

        $r += $y - $x;
    }

    return $r;
}
sub task2_linear_after_sort_early_return ( @ns --> UInt ) {
    my @ns_ss = @ns.sort(+*).squish;

    my $highest = @ns_ss.tail;

    my ( $y, $r ) = 0 xx *;
    for @ns_ss.kv -> $x, $xv {
        my $x2 = $xv * 2;

        if $x2 > $highest {
            $r += Triangle(+@ns_ss - $x);
            last;
        }

        $y++ while ($y+1) <= @ns_ss.end and @ns_ss[$y+1] < $x2;

        $r += $y - $x;
    }

    return $r;
}




constant DO_TESTS = True;
constant ADD_EXTRA_TESTS = True;
constant DO_BENCHMARKS = False;
my @tests =
    ( 4, (1, 2, 3, 4, 5) ),
    ( 1, (5, 7, 1, 7) ),

    (  241, ( 2,2,2,2,2,2,2,2,2,2,4,3,4,4,3,4,4,4,3,3,5,6,7,7,8,8,5,5,5,5,16,14,15,10,12,16,13,13,14,10,22,24,27,23,21,31,27,25,23,28,42,53,60,58,57,58,33,39,62,38,88,115,108,79,80,90,101,79,127,96 ) ),
    (  467, ( 2,2,2,2,2,2,2,2,2,2,4,3,4,4,3,3,3,3,3,4,7,6,8,8,8,6,6,5,5,5,12,16,12,12,13,16,15,9,16,14,25,26,21,18,21,32,29,25,25,25,54,51,49,46,39,54,49,64,37,42,86,93,123,101,70,96,71,125,86,104,131,165,160,217,241,239,217,234,210,193,409,376,390,419,501,313,387,500,403,465,646,564,639,997,720,513,928,796,848,869 ) ),

    # 4ⁿ - 2ⁿ for ranges 1..2ⁿ⁺¹
    (     2, ( 1..4 ) ),
    (    12, ( 1..8 ) ),
    (    56, ( 1..16 ) ),
    (   240, ( 1..32 ) ),
    (   992, ( 1..64 ) ),

    (    0, ( 1..1 ) ),

    (  121-3, ( 4..23 ) ),

    (  121-6, ( 5..23 ) ),

    (  121-10, ( 6..23 ) ),

    ( 3, (6, 7, 8)),
;
if ADD_EXTRA_TESTS {
    # Contiguous range from a low number.
    for 1..100 -> $i {
        my $Qi1 = Quarter-square($i-1);
        push @tests, ( $Qi1     , (1..$i) ) if $i > 1+1;
        push @tests, ( $Qi1     , (2..$i) ) if $i > 2+1;
        push @tests, ( $Qi1 -  1, (3..$i) ) if $i > 3+1;
        push @tests, ( $Qi1 -  3, (4..$i) ) if $i > 4+1;
        push @tests, ( $Qi1 -  6, (5..$i) ) if $i > 5+1;
        push @tests, ( $Qi1 - 10, (6..$i) ) if $i > 6+2;
        push @tests, ( $Qi1 - 15, (7..$i) ) if $i > 7+3;
        push @tests, ( $Qi1 - 21, (8..$i) ) if $i > 8+4;
    }

    for 1..100 -> \N {
        # Any range N ..^ 2N should result in the Triangle number for N.
        push @tests, ( Triangle(N) , (N ..^ (2*N)) );
    }

    # Contiguous ranges 1..2ⁿ⁺¹ should result in 4ⁿ - 2ⁿ
    for 2..8 -> \N { # At 9 or above the task2_combo_* subs are terrible.
        push @tests, ( N42(N) , (1 .. (2 ** (N+1))) );
    }

}

# Fastest to slowest
my @subs =
    :&task2_linear_after_sort_early_return,
    :&task2_linear_after_sort,
    :&task2_combo_sort,
    :&task2_combo_unique,
;
if DO_TESTS {
    use Test; plan +@tests * +@subs;
    for @subs -> ( :key($sub_name), :value(&task2) ) {
        for @tests -> ( $expected, $ns ) {
            my $in_desc = $ns ~~ Range ?? $ns.raku !! $ns.head(6);

            is task2($ns), $expected, "$sub_name : $in_desc";
        }
    }
}

# XXX Very messy past this point; only used for crude benchmarking
# if DO_BENCHMARKS {
#     my $t = now;
#     for @subs -> ( :key($sub_name), :value(&task2) ) {
#         for ^10 { # 50
#             for @tests -> ( $expected, $ns ) {
#                 task2($ns);
#             }
#         }
#         say now - $t, " : $sub_name";
#         $t = now;
#     }
# }
# if DO_BENCHMARKS {
#     # for 16, 32, 64 ... * -> $size {
#         for 1..* -> $power {
#         say (:$power, size => (2**$power) );
#         my $t = now;
#         for @subs -> ( :key($sub_name), :value(&task2) ) {
#             # for ^1 { # 50
#                 # for @tests -> ( $expected, $ns ) {
#                     task2(1 .. (2**$power));
#                 # }
#             # }
#             say now - $t, " : $sub_name";
#             $t = now;
#         }
#     }
# }

if DO_BENCHMARKS {
    # for 16, 32, 64 ... * -> $size {
        for 1..* -> $power {
        say (:$power, size => (2**$power), 'X4' );
        my @in = ( 1 .. (2**$power) ) X* 4;
        my $t = now;
        for @subs -> ( :key($sub_name), :value(&task2) ) {
            # for ^1 { # 50
                # for @tests -> ( $expected, $ns ) {
                    # task2(1 .. (2**$power));
                    task2(@in);
                # }
            # }
            say now - $t, " : $sub_name";
            $t = now;
        }
    }
}
