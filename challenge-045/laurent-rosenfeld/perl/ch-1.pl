use strict;
use warnings;
use feature "say";

my $msg = shift // "The quick brown fox jumps over the lazy dog";
$msg =~ s/\s+//g;
my @letters = map { /.{1,8}/g; } $msg;
for my $i (0..7) {
    print map { substr  $_, $i, 1 if length $_ >= $i} @letters;
    print " ";
}
