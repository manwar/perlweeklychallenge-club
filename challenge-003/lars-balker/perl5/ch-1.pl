# Create a script to generate 5-smooth numbers, whose prime divisors
# are less or equal to 5. They are also called Hamming/Regular/Ugly
# numbers.

use v5.10;
use strict;
use warnings;

sub min {
    my $low = shift;
    for (@_) {
        $low = $_ if $_ < $low;
    }
    return $low;
}

# prints out nth 5-smooth number
my $nth = shift or die "usage: $0 <number>\n";

my %ham = map { $_ => [1] } qw/ 2 3 5 /;

my $next;
for (1..$nth) {
    # pick lowest remaining number for all bases, which is next hamming number
    $next = min(map { $ham{$_}[0] } keys %ham);

    # for all bases:
    for my $base (keys %ham) {
        shift @{$ham{$base}} if $ham{$base}[0] == $next; # remove this number as a candidate
        push @{$ham{$base}}, $next * $base;              # add new candidate to end
    }
}
say $next;
