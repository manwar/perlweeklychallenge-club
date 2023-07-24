use strict;
use warnings;
use feature 'say';

sub shuffle_string {
    my ($string, $idx_ref) = @_;
    my @indices = @$idx_ref;
    my @index;
    @index[$indices[$_]]= $_ for 0..$#indices;
    return join "", (split //, $string)[@index];
}

for my $test (['lacelengh', [3,2,0,5,4,8,6,7,1]],
    ['rulepark', [4,7,3,1,0,5,2,6]]) {
    printf "%-10s - %-18s => ",
        $test->[0], "@{$test->[1]}";
    say shuffle_string $test->[0], $test->[1];

}
