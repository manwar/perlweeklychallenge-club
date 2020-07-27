#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars- /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <N>

    <N>    bit length (2 - 5)
-USAGE-

    exit(0);
}


my $N = shift // usage();

if ($N < 2 || $N > 5) {
    usage();
}

my @code = (0, 1, 3, 2);

if ($N > 2) {
    for my $i (3 .. $N) {
        my @s1 = map { sprintf('%0*b', $i - 1, $_); } @code;
        my @s2 = reverse @s1;
        @s1 = map { "0b0$_"; } @s1; 
        @s2 = map { "0b1$_"; } @s2;
        @code = map { oct $_; } @s1, @s2;
    }
}

say q{[}, (join q{, }, @code), q{]};
