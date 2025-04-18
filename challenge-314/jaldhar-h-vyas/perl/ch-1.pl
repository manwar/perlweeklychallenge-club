#!/usr/bin/perl
use v5.38;
use builtin qw/ true /;
no warnings qw/ experimental::builtin /;

my ($s1, $s2, $s3) = @ARGV;
my $ops = 0;
my @strs = ($s1, $s2, $s3);

while (true) {
    if (grep { length($_) == 0 } @strs) {
        say -1;
        last;
    }

    if ($strs[0] eq $strs[1] && $strs[1] eq $strs[2]) {
        say $ops;
        last;
    }

    my $maxlen = (sort { $b <=> $a } map { length($_) } @strs)[0];
    for my $i (keys @strs) {
        if (length($strs[$i]) == $maxlen) {
            $strs[$i] = substr($strs[$i], 0, -1);
            $ops++;
        }
    }
}
