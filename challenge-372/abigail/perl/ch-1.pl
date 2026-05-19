#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    s/["\n]//g;                                       # Remove quotes, newline
    my $spaces  = y/ / /;                             # Count spaces
    my @words   = split;                              # Split into words
    my $gaps    = @words - 1;                         # Nr of gaps between words
    my $per_gap = $gaps ? int ($spaces / $gaps) : 0;  # Calculate amount
    my $end     = $spaces - $gaps * $per_gap;         #   of spaces needed
    say '"', join (" " x $per_gap, @words), " " x $end, '"';
}

__END__
