use strict;
use warnings;
use feature 'say';

sub shortest_distance {
    my ($char, $str) = @_;
    my @result;
    my $max_idx = length($str) - 1;
    for my $i (0..$max_idx) {
        my $next = index ($str, $char, $i);
        my $prev = rindex( $str, $char, $i);
        push @result, abs($i - $next) and next if $prev < 0;
        push @result, abs($i - $prev) and next if $next < 0;
        my $dist = abs($i - $next) < abs($i - $prev) ?
                   abs($i - $next) : abs($i - $prev);
        push @result, $dist;
    }
    return "@result";
}

my @tests = ( { str => "loveleetcode", char => "e" },
              { str => "aaab",         char => "b" } );
for my $t (@tests) {
    printf "%-1s -  %-15s => ", $t->{"char"}, $t->{"str"};
    say shortest_distance $t->{"char"}, $t->{"str"};
}
