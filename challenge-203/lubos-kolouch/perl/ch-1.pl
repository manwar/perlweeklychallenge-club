use strict;
use warnings;
use Test::More tests => 3;

sub special_quadruplets {
    my ($nums) = @_;
    my $total = 0;
    my @sorted = sort { $a <=> $b } @$nums;
    for my $i (0 .. $#sorted) {
        for my $j ($i + 1 .. $#sorted) {
            for my $k ($j + 1 .. $#sorted) {
                if (grep { $_ == $sorted[$i] + $sorted[$j] + $sorted[$k] } @sorted[$k + 1 .. $#sorted]) {
                    $total++;
                }
            }
        }
    }
    return $total;
}

my @test_cases = (
    {
        nums => [1, 1, 1, 3, 5],
        total => 4,
    },
    {
        nums => [1, 2, 3, 6],
        total => 1,
    },
    {
        nums => [3, 3, 4, 5, 6],
        total => 0,
    },
);

for my $test_case (@test_cases) {
    my $nums = $test_case->{nums};
    my $expected_total = $test_case->{total};
    my $actual_total = special_quadruplets($nums);
    is($actual_total, $expected_total, "Test with nums @$nums");
}

