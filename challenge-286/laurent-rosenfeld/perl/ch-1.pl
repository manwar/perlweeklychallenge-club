use strict;
use warnings;
use feature 'say';

my @words;
open my $FH, '<', __FILE__ or die "Error opening file";
while (<$FH>) {
    s/^\s+//g;    # remove leading spaces from $_ if any
    push @words, split /\s+/, $_;
}
close $FH;
say $words[int(rand($#words + 1))];
