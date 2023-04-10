use strict;
use warnings;
use feature "say";

sub is_toeplitz {
    my @in = @_;
    my $j_max = scalar @{$in[0]} - 1;
    for my $i (1..$#in) {
        for my $j (1..$j_max) {
            # say "$i $j $in[$i][$j] $in[$i-1][$j-1]";
            return "false" if $in[$i][$j] != $in[$i-1][$j-1];
        }
    }
    return "true";
}

for my $test
    ( [ [<4 3 2 1>], [<5 4 3 2>], [<6 5 4 3>] ],
      [ [<3 2 1 0>], [<4 3 2 1>], [<5 4 3 2>] ],
      [ [<3 2 1 0>], [<4 3 2 1>], [<5 5 3 2>] ],
      [ [<1 2 3>], [<3 2 1>] ] ) {
    say "[ ", (join ", ", map "[@$_]", @$test), " ]";
    say is_toeplitz(@$test), "\n";
}
