use strict;
use warnings;
use List::Util qw(sum);

sub left_right_sum_diff {
    my @ints = @_;
    my @left = map { $_ > 0 ? sum( @ints[ 0 .. $_ - 1 ] ) : 0 } ( 0 .. $#ints );
    my @right = map { $_ < $#ints ? sum( @ints[ $_ + 1 .. $#ints ] ) : 0 }
      ( 0 .. $#ints );
    return [ map { abs( $left[$_] - $right[$_] ) } ( 0 .. $#ints ) ];
}

# testing
my @ints = ( 10, 4, 8, 3 );
print join( ", ", @{ left_right_sum_diff(@ints) } ),
  "\n";    # should print "15, 1, 11, 22"

@ints = (1);
print join( ", ", @{ left_right_sum_diff(@ints) } ), "\n";    # should print "0"

@ints = ( 1, 2, 3, 4, 5 );
print join( ", ", @{ left_right_sum_diff(@ints) } ),
  "\n";    # should print "14, 11, 6, 1, 10"
