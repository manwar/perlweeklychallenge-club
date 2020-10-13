#!/opt/perl/bin/perl

#
# You are given file named input.
# 
# Write a script to find the frequency of all the words.
# 
# It should print the result as first column of each line should be
# the frequency of the the word followed by all the words of that
# frequency arranged in lexicographical order. Also sort the words
# in the ascending order of frequency.
# 
# For the sake of this task, please ignore the following in the input file:
# 
#     . " ( ) , 's --
#

#
# Note that the challenge says "please ignore the following in the input
# file", but what it actually means is "treat it as a separator". The 
# example contains "highway--whoever", but the output contains both
# "highway" and "whoever", but no "highwaywhoever". If we were to just
# ignore the "--", we would have expected the latter to appear.
#
# It's still a bit ambigious. If we have "foo---bar", should that count
# as "foo" and "-bar", or as "foo-" and "bar". Our implementation uses
# the former. (We could have split on /--+/ as well, resulting in counting
# "foo" and "bar").
#

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Read the input -- if there is a file "input", read from there.
# Else, read STDIN.
#

my $fh;
if (-f "input") {
    open $fh, "<", "input" or die;
}
else {
    $fh = \*STDIN;
}

local $/; # Slurp in the input.
$_ = <$fh>;

#
# Split into words and count them.
#
my %words;
$words {$_} ++ for split /(?:[\s."(),]|'s|--)+/;

#
# Bucket them
#
my %buckets;
while (my ($word, $count) = each %words) {
    push @{$buckets {$count}} => $word;
}

#
# Print them, sorted by frequency, then words. Some fibbling because
# we need a blank line *between* the buckets, but none after the last.
#
my @buckets = sort {$a <=> $b} keys %buckets;
foreach my $i (keys @buckets) {
    my $count = $buckets [$i];
    print "\n" if $i;
    print $count;
    print " $_" for sort @{$buckets {$count}};
    print "\n";
}


__END__
