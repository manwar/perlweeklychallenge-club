use strict;
use warnings;
use feature "say";

my @tests = ( [ 7, [10, 8, 12, 15, 5]],
              [ 6, [1, 5, 2, 9, 7]],
              [ 15, [10, 30, 20, 50, 40]],
              [ 9, [7, 20, 15, 11, 12]],
            );
for my $R (@tests) {
    my ($target, $test_ref) = @$R;
    my @test = @$test_ref;
    my $found = 0;
    say "Testing: target: $target and @test";
    OUT: for my $i (0..$#test) {
        for my $j ($i..$#test) {
            if (abs($test[$i] - $test[$j]) == $target) {
                $found = 1;
                say +$found, " ($test[$i] $test[$j])" if $found;
                last OUT;
            }

        }

    }
    say "0" unless $found;
}
