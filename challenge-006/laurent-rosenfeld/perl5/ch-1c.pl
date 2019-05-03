use strict;
use warnings;
use feature 'say';

sub compare {
    my ($prev, $start) = @_;
    return $prev > $start + 1 ? "$start-$prev"
         : $prev > $start     ? "$start,$prev"
         : "$prev";
}

my @input = @ARGV > 0 ? @ARGV : (1,2,3,4,9,10,14,15,16,3,4,5,6,4,5,6,7,9,9);
my $prev_val = my $start_val = shift @input;
my $output = "";
for my $num (@input) {
    if ($num != $prev_val + 1) {
        $output .= compare ($prev_val, $start_val) . ",";
        $start_val = $num;
    }
    $prev_val = $num;
}
$output .= compare ($prev_val, $start_val);
say $output;
