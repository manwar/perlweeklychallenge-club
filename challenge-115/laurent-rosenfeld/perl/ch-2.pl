use strict;
use warnings;
use feature "say";

sub find_largest {
    my @sorted = reverse sort @_;
    return @sorted if $sorted[-1] % 2 == 0;
    for my $i (reverse 0..$#sorted) {
        # swap smallest even digit with last digit
        if ($sorted[$i] % 2 == 0) {
            @sorted[$i, -1] = @sorted[-1, $i];
            return @sorted;
        }
    }
    return (); # Failed, no even digit
}
for my $test ( [qw<1 0 2 6>], [qw<1 3 2 6>],
               [qw<1 3 5 7>], [qw<1 4 2 8>] ) {
    my @result = find_largest(@$test);
    print @$test, ": ";
    if (@result > 0) {
        say "Solution: ", join '', @result;
    } else {
        say "No solution";
    }
}
