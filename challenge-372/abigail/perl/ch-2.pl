#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    my @chars = /./g;  # Turn input an array of characters, sans the newline.
    my $max   = -1;    # Track max difference.
    for (my $f = 0; $f < @chars; $f ++) {           # For each character, ...
        for (my $l = @chars - 1; $l > $f; $l --) {  # find matching character
            if ($chars [$f] eq $chars [$l]) {       # from the end
                if ($l - $f - 1 > $max) {           # If larger distance, ...
                    $max = $l - $f - 1;             # remember it
                }
                last;
            }
        }
    }
    say $max;
}


__END__
