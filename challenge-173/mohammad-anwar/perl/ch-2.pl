#!/usr/bin/perl

=head1

Week 173:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-173

Task #2: Sylvester’s sequence

    Write a script to generate first 10 members of Sylvester's sequence.

=cut

use v5.36;
use Test2::V0;

is sylvester_sequence(10),
   [
     2
    ,3
    ,7
    ,43
    ,1807
    ,3263443
    ,10650056950807
    ,113423713055421844361000443
    ,12864938683278671740537145998360961546653259485195807
    ,165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443
   ],
   'Example';

done_testing;

#
#
# METHOD

sub sylvester_sequence($n) {
    die "ERROR: Missing number.\n"    unless defined $n;
    die "ERROR: Invalid number $n.\n" if $n < 3;

    my @ss = (2);
    foreach (1 .. --$n) {
        push @ss, (1 + $ss[-1] * ($ss[-1] - 1));
    }
    return \@ss;
}
