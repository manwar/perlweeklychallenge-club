use strict;
use warnings;
use feature 'say';

sub twice {
    my %seen;
    for my $let (split //, shift) {
        return $let if exists $seen{$let};
        $seen{$let} = 1;
    }
}

my @tests = ("acbddbca", "abccd", "abcdabbb");
for my $test (@tests) {
    printf "%-10s => ", $test;
    say twice $test;
}
