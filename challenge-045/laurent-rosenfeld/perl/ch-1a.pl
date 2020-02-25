use strict;
use warnings;
use feature "say";

my $msg = shift // "The quick brown fox jumps over the lazy dog";
$msg =~ s/\s+//g;
$msg =~ s/(.{8})/$1\n/g;
my @lines = split /\n/, $msg;
for my $i (0..7) {
    print map { substr  $_, $i, 1 if length $_ >= $i} @lines;
    print " ";
}
