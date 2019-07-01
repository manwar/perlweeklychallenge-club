# Write a script to generate Van Eck’s sequence starts with 0.
# For more information, please check out wikipedia page.
# This challenge was proposed by team member Andrezgz.

use strict;
use warnings;
use v5.10;

my $end = shift;    #

# we will need to keep last position of every number
# in the sequence.

my @last_pos;

# we start at position 0,
# and first value of sequence is zero by definition
my $pos = 0;
my $seq = 0;
while ( $pos <= $end ) {
    print "$seq ";

    # now we calculate new sequence
    # if the current $seq is in @last_pos, we calculate
    # the interval from last postion to $seq's position
    # and if $seq is new (i.e. not in @last_pos)
    # new value in sequence is 0, also by definition
    my $new_seq =
      defined $last_pos[$seq]
      ? $pos - $last_pos[$seq]
      : 0;

    # not until now we annotate $seq's last position
    $last_pos[$seq] = $pos;

    # set $seq and $pos to their new values
    $seq = $new_seq;
    $pos++;
}
print "\n";
