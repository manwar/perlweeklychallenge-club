# As long as we don't mind calculating *all* the places the zeros could go,
# the task cleanly separates into "how many can we fit" and "is that >= wanted".
sub task2 ( UInt $count, @ns --> Bool ) { $count <= max_zeros_space(@ns) }
sub max_zeros_space (    @ns --> UInt ) {
    return @ns.join
              .split( / 0? 1+ 0? /, :skip-empty )
              .map({ ( .chars / 2 ).ceiling })
              .sum;
}

# This solution features inspectable modifications to $s,
# and returns as soon as $count is reached.
sub task2_with_early_return ( UInt $count, @ns --> Bool ) {
    my $s = @ns.join;

    for ^$count {
        $s ~~ s/ <!after 1> 0 <!before 1> /1/
            or return False;
    }

    return True;
}

# This solution avoids .join'ing the array, which would work better if
# the 0|1 values ever needed to be longer than length=1 symbols.
sub task2_without_join ( UInt $count is copy, @ns is copy --> Bool ) {
    return True if $count == 0;

    for @ns.keys -> $i {
        if  (                  @ns[$i  ] eq '0' )
        and ( $i == 0       or @ns[$i-1] eq '0' )
        and ( $i == @ns.end or @ns[$i+1] eq '0' ) {
            @ns[$i] = '1';
            $count--;
            return True if $count == 0;
        }
    }

    return False;
}


my @tests =
    # From original task examples:
    ( 1, (1,0,0,0,1)         , 1 ),
    ( 2, (1,0,0,0,1)         , 0 ),
    ( 3, (1,0,0,0,0,0,0,0,1) , 1 ),

    # Checking edges:
    ( 0, (1,0,0,1)           , 1 ),
    ( 1, (1,0,0,1)           , 0 ),
    ( 4, (1,0,0,0,0,0,0,0,1) , 0 ),

    # Checking groupings:
    ( 5, (1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,1) , 1 ),
    ( 6, (1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,1) , 0 ),
;
use Test;
plan 3 * @tests;

for :&task2, :&task2_with_early_return, :&task2_without_join -> (:key($sub_name), :value($sub_to_test)) {
    for @tests -> ($in_count, $in_ns,  $expected) {
        is  +$sub_to_test($in_count, $in_ns), $expected, " $sub_name : {$in_ns.join}";
    }
}
