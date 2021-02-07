#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#
# Each line is assumed to be a white space separated list of
# numbers. The first number is the target number (`$N`), the rest of
# the numbers is the array (`@N`).
#
# Now, we could implement a binary search to find the target in
# O (log N) time, but why bother? We need to read the array, which
# means we're already spending linear time; furthermore, we have to
# insert element if not found -- which is a worst case linear time
# operation anyway. So, we just do a linear scan.
#
# Note that we insert $N into @N by adding it to the end, and then
# sorting -- which is linear in Perl (as the list (@N, $N) is nearly
# sorted). We then use a goto to go back to the search; this is 
# guaranteed to succeed.
#

INPUT: while (<>) {
    chomp;
    my ($N, @N) = split ' ';
  SEARCH:
    for my $i (keys @N) {
        if ($N == $N [$i]) {
            say $i;
            next INPUT;
        }
    }

    #
    # Not found. Insert by adding to the end and sorting.
    #
    @N = sort {$a <=> $b} @N, $N;

    #
    # Now, do the search again -- this time, it will succeed.
    #
    goto SEARCH;
}


__END__
