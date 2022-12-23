use strict;
use warnings;
use feature qw/say/;

sub find_ranges {
    my @in = @_;
    my ($start, $curr);
    my @result;
    $start = $curr = $in[0];
    for my $i (1..$#in) {
        next if $in[$i] == $start;
        if ($in[$i] == $curr + 1) {
            $curr = $in[$i];
        } else {
            push @result, "[$start $curr] "
                if $curr > $start;
            $start = $in[$i];
            $curr = $start;
        }
    }
    push @result, "[$start $curr]" if $curr > $start;
    return @result > 0 ? @result : "[]";
}
for my $test ([<1 3 4 5 7>], [<1 2 3 6 7 9>],
    [<0 1 2 4 5 6 8 9>], [<1 3 4 6 7 11 12 13>],
    [<1 3 4 5 7 9>], [<1 3 5>]) {
    say sprintf("%-25s", "@$test => "), find_ranges @$test;
}
