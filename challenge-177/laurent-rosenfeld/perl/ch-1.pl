use strict;
use warnings;
use feature qw/say/;

my @damm =  (
    [ qw < 0 3 1 7 5 9 8 6 4 2 > ],
    [ qw < 7 0 9 2 1 5 4 8 6 3 > ],
    [ qw < 4 2 0 6 8 7 1 3 5 9 > ],
    [ qw < 1 7 5 0 9 8 3 4 2 6 > ],
    [ qw < 6 1 2 3 0 4 5 9 7 8 > ],
    [ qw < 3 6 7 4 2 0 9 5 8 1 > ],
    [ qw < 5 8 6 9 7 2 0 1 3 4 > ],
    [ qw < 8 9 4 5 3 6 2 0 1 7 > ],
    [ qw < 9 4 3 8 6 1 7 2 0 5 > ],
    [ qw < 2 5 8 1 4 3 6 7 9 0 > ] );

sub find_check {
    my $n = shift;
    my $t = 0;
    $t = $damm[$t][$_] for split //, $n;
    return $t;
}

sub is_valid {
    my $n = shift;
    return find_check($n) == 0;
}

for my $test (5724, 5727) {
    say $test, is_valid($test) ? " is valid." : " is not valid.";
}
say "\nValid numbers between 5700 and 5800 are: ";
for my $i (5700..5800) {
    print "$i " if is_valid $i;
}
say "";
