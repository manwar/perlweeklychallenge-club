use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub check_winning(%moves) {
    foreach my $win (["0:0", "0:1", "0:2"], ["1:0", "1:1", "1:2"], ["2:0", "2:1", "2:2"], ["0:0", "1:0", "2:0"], ["0:1", "1:1", "2:1"] ,["0:2", "1:2", "2:2"], ["0:0", "1:1", "2:2"], ["2:0", "1:1", "0:2"]) {
        my $count = 0;
        foreach my $point (@$win) {
            if (exists($moves{$point})) {
                $count += 1;
            }
        }
        return 1 if $count == 3;
    }
    return 0;
}

sub run(@moves) {
    my %a;
    my %b;
    for (my $i = 0; $i < scalar(@moves); $i++) {
        my $c = $i % 2 == 0 ? \%a : \%b;
        $c->{"$moves[$i]->[0]:$moves[$i]->[1]"} = 1;
    }
    return 'A' if check_winning(%a);
    return 'B' if check_winning(%b);
    return 'Draw' if scalar(@moves) == 9;
    return 'Pending';
}

is(run([0,0],[2,0],[1,1],[2,1],[2,2]), 'A', "Example 1");
is(run([0,0],[1,1],[0,1],[0,2],[1,0],[2,0]), 'B', "Example 2");
is(run([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]), 'Draw', "Example 3");
is(run([0,0],[1,1]), 'Pending', "Example 4");
is(run([1,1],[0,0],[2,2],[0,1],[1,0],[0,2]), 'B', "Example 5");
