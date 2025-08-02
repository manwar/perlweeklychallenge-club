use strict;
use warnings;
use feature 'say';

sub changing_key {
    my $count = 0;
    my @letters = split //, lc shift;
    my $old = shift @letters;
    for my $let (@letters) {
        $old = $let and $count++ if $let ne $old;
    }
    return $count;
}

my @tests = ('pPeERrLl', 'rRr', 'GoO');
for my $test (@tests) {
    printf "%-10s => ", $test;
    say changing_key $test;
}
