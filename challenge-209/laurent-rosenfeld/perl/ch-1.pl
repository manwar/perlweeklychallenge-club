use strict;
use warnings;
use feature "say";

sub ends_with_a {
    my $i = 0;
    my $end = $#_;
    while (1) {
        return 1 if $i == $end;
        $i += $_[$i] == 0 ? 1 : 2;
        return 0 if $i > $end;
    }
}

for my $test ([<1 0 0>], [<1 1 1 0>],
    [<0 0 0 1 0>], [<1 1 0>]) {
    printf "%-12s => %d\n", "@$test", ends_with_a @$test;
}
