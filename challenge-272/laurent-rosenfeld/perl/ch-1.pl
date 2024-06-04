use strict;
use warnings;
use feature 'say';

sub defang_ip {
    $_[0] =~ s/\./[.]/g;
    return $_[0] ;
}

my @tests = ("1.1.1.1", "255.101.1.0", "255.255.255.255");
for my $test (@tests) {
    printf "%-16s => ", $test;
    say defang_ip $test;
}
