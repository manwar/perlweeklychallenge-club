#!/usr/bin/perl

=head1

Week 184:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-184

Task #1: Sequence Number

    You are given list of strings in the format aa9999 i.e. first 2
    characters can be anything 'a-z' followed by 4 digits '0-9'.

    Write a script to replace the first two characters with sequence
    starting with '00', '01', '02' etc.

=cut

use v5.36;
use Test2::V0;

is sequence_number('ab1234', 'cd5678', 'ef1342'),
   ['001234', '015678', '021342'], 'Example 1';

is sequence_number('pq1122', 'rs3334'),
   ['001122', '013334'], 'Example 2';

done_testing;

#
#
# METHOD

sub sequence_number(@list) {
    my @sn = ();
    my $i  = 0;
    foreach my $entry (@list) {
        next unless ($entry =~ /^[a-z]{2}(\d{4})$/);
        push @sn, sprintf("%02d%d", $i++, $1);
    }

    return \@sn;
}
