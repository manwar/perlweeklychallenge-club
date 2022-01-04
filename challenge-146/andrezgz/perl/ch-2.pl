#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-146/
# Task #2 > Curious Fraction Tree
#
# You are given a fraction, member of the tree created similar to the above sample.
#
# Write a script to find out the parent and grandparent of the given member.
#
# Example 1:
#     Input: $member = '3/5';
#     Output: parent = '3/2' and grandparent = '1/2'
# Example 2:
#     Input: $member = '4/3';
#     Output: parent = '1/3' and grandparent = '1/2'

use strict;
use warnings;
use feature 'say';

my $member = shift || die "Argument member is missing e.g. 5/3 \n";

my $ftree = {
    v => '1/1',
    l => {
            v => '1/2',
            l => { v => '1/3', l => { v=> '1/4' }, r => { v=> '4/3' } },
            r => { v => '3/2', l => { v=> '3/5' }, r => { v=> '5/2' } }
        },
    r => {
            v => '2/1',
            l => { v => '2/3', l => { v=> '2/5' }, r => { v=> '5/3' } },
            r => { v => '3/1', l => { v=> '3/4' }, r => { v=> '4/1' } }
        }
};

travel($ftree);

exit 0;

sub travel {
    my $node = shift;
    my $parent = shift // 'N/A';
    my $grandparent = shift // 'N/A';

    if ($member eq $node->{v}) {
        say "parent = $parent and grandparent = $grandparent";
    }
    else {
        travel($node->{l},$node->{v},$parent) if exists $node->{l};
        travel($node->{r},$node->{v},$parent) if exists $node->{r};
    }
}

__END__

./ch-2.pl 4/1
parent = 3/1 and grandparent = 2/1

$ ./ch-2.pl 2/1
parent = 1/1 and grandparent = N/A

$./ch-2.pl 1/1
parent = N/A and grandparent = N/A
