#!/usr/bin/perl
use strict;

# Usage: ch-1.pl starting_number ending_number, e.g. 
# ch-1.pl 200 299
# gives
# 210, 212, 232, 234

sub diff {
    if (($_[0]-$_[1] == 1) or ($_[0]-$_[1] == -1)) {
        return 1;
    } else {return undef;}
}

(my $head, my $tail) = @ARGV;

foreach ($head..$tail) {
    my $num = $_;
    (my $h, my $t, my $d) = split //, $num;
    print "$num\n" if (diff($h,$t) && diff($t,$d));
}
