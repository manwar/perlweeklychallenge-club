use strict;
use warnings;
use feature 'say';

my @input = @ARGV > 0 ? @ARGV : (1,2,3,4,9,10,14,15,16,3,4,5,6,4,5,6,7,9,9);
my $prev = my $start = shift @input;
for my $num (sort { $a <=> $b } @input) {
    next if $num == $prev;
    if ( $prev == $num - 1 ) {
        $prev = $num;
    } else {
        print $prev == $start ? "$prev," : "$start-$prev,";
        $start = $prev = $num;
    }
}
say $prev == $start ? $prev : "$start-$prev";
