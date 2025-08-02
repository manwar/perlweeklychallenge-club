use strict;
use warnings;
use feature 'say';

sub count_equal_div {
    my $divisor = shift;
    die "$divisor cannot be 0" if $divisor == 0;
    my @in = @_;
    my $count = 0;
    for my $i (0 .. $#in - 1) {
        for my $j ($i+1 .. $#in) {
            next if $in[$i] != $in[$j];
            $count++ if $i * $j % $divisor == 0;
        }
    }
    return $count;
}

my @tests = ( [2, [3,1,2,2,2,1,3]], [1, [1,2,3]] );
for my $test (@tests) {
    printf "%d - %-15s => ", $test->[0], "@{$test->[1]}";
    say count_equal_div  @$test[0], @{$test->[1]};
}
