#!perl

################################################################################
=comment

Perl Weekly Challenge 014
=========================

Challenge #1
------------

Write a script to generate Van Eck's sequence starts with 0. For more
information, please check out wikipedia
[ https://en.wikipedia.org/wiki/Van_Eck%27s_sequence |page]. This challenge was
proposed by team member *Andrezgz*.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Regexp::Common;

const my $LENGTH =>  27;
const my $USAGE  => "USAGE: perl $0 [<length>]";

$| = 1;

MAIN:
{
    scalar @ARGV <= 1
        or die "\n$USAGE\n";

    my $length = $ARGV[0] // $LENGTH;

    $length =~ /^$RE{num}{int}$/ && $length > 0
        or die "\nInvalid length '$length': must be an integer > 0\n";

    print "\nThe first $length terms in Van Eck's sequence are:\n",
           join( ', ', van_eck($length)->@* ), "\n";
}

sub van_eck
{
    my ($len) =  @_;
    my  @seq  = (undef, 0);
    my  %indices;

    for my $n (1 .. $len - 1)
    {
        my $old_term = $seq[$n];
        push @seq, exists $indices{$old_term} ? $n - $indices{$old_term} : 0;
        $indices{$old_term} = $n;
    }

    shift   @seq;
    return \@seq;
}

################################################################################
