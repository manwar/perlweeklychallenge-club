use strict;
use warnings;
use feature 'say';

sub replace_digits {
    my @chars = split //, shift;
    for my $i (1..$#chars) {
        if ($chars[$i] =~ /\d/) {
            $chars[$i] = chr( $chars[$i] + ord $chars[$i-1]);
        }
    }
    return join "", @chars;
}

my @tests = ('a1c1e1', 'a1b2c3d4', 'b2b', 'a16z');
for my $test (@tests) {
    printf "%-10s => ", $test;
    say replace_digits $test;
}
