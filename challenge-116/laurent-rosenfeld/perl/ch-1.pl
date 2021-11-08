use strict;
use warnings;
use feature "say";
my $end_result;

sub num_seq {
    my $cur_val = shift;
    my $result = shift;
    my @digits = @_;

    my $len = length $cur_val;
    return if scalar @digits < $len;
    $cur_val = $digits[0] - 1 unless $cur_val;
    for my $i ($len - 1 .. $#digits) {
        my $new_val = join "", @digits[0..$i];
        next if $new_val - $cur_val != 1 or $new_val =~ /^0/;
        push @{$result}, join "", @digits[0..$i];
        # say "@$result";
        if (scalar @digits > $len) {
            num_seq($new_val, $result, @digits[$i+1..$#digits]);
        } else {
            $end_result = $result;
            return;
        }
    }
}

for my $test (qw<1234 91011 10203>) {
    $end_result = "";
    num_seq 0, [], split "", $test;
    if ($end_result) {
        say join ", ", @$end_result;
    } else {
        say $test;
    }
}
