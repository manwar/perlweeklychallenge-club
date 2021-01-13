use warnings;
use strict;
use feature ":5.26";

use List::Util qw(sum);

## ## ## ## ## MAIN:

my @array = @ARGV;
my @sets = choose_2_sets( @array );

my $sum;
for my $set ( @sets ) {
    $sum += bit_difference($set->[0], $set->[1]);
}

say $sum;


## ## ## ## ## SUBS:

sub bit_difference {
    return sum( split //, sprintf "%b", 0+$_[0] ^ 0+$_[1] );
}

sub choose_2_sets {
    my @array = @_;
     my @out;
    for my $i (0..(scalar @array - 1)) {
    	for my $j ($i+1..(scalar @array - 1)) {
    		push @out, [ $array[$i], $array[$j] ];
    	}
    }
    return @out;
}
