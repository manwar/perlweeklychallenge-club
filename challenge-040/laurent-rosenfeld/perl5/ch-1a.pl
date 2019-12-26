#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my @a = ( [ qw /I L O V E Y O U/ ],
          [ qw /244 42 0 1233 222 0 11 90/ ],
          [ qw /! ???? £ $ %% ^ & */ ],
          [ qw /a b c d e f g f/ ]
        );
my @b;
my $sub_array_size = scalar @{$a[0]};
for my $i (0..$sub_array_size -1) {
    push @b, [ map { $a[$_][$i]} 0 .. @a - 1];
}
say join "\t", @$_ for @b;
