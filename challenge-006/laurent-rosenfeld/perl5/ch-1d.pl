use strict;
use warnings;
use feature 'say';

my @input = @ARGV > 0 ? @ARGV : (1,2,3,4,9,10,14,15,16,3,4,5,6,4,5,6,7,9,9);

sub process_input {
    my ($range, $input, $output) = @_;
    my $curr_val = shift @$input;
    if ($curr_val == $range->[1] + 1) {
        $range->[1] = $curr_val;
    } else {
        my $sep = $range->[1] > $range->[0] + 1 ? "-" : ",";
        $output .= (join $sep, @$range) . ",";
        $range = [$curr_val, $curr_val];
    }
    return $output if @$input == 0;
    process_input ($range, $input, $output);
}

my $first = shift @input;
my $output = process_input([($first) x 2], \@input, "");
chop $output;
say $output;
