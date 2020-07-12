#!perl

################################################################################
=comment

Perl Weekly Challenge 068
=========================

Task #2
-------
*Reorder List*

*Submitted by:* Mohammad S Anwar

You are given a singly linked list $L as below:

 L0 →  L1 →  … →  Ln-1 →  Ln

Write a script to reorder list as below:

 L0 →  Ln →  L1 →  Ln-1 →  L2 →  Ln-2 → […]

You are *ONLY* allowed to do this in-place without altering the nodes' values.

*Example*

 Input:  1 →  2 →  3 →  4
 Output: 1 →  4 →  2 →  3

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use lib            qw( . );
use SinglyLinkedList;

const my $USAGE =>
"Usage:
  perl $0 <num-elements>
  perl $0 [<elements> ...]

    <num-elements>      (UInt > 0) Num. of elements (with values 1, 2, 3, ...)
    [<elements> ...]    (Str+) Explicit element values, in order\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 068, Task #2: Reorder List (Perl)\n\n";

    my $args = scalar @ARGV;
       $args > 0 or die $USAGE;

    my @args = @ARGV;
       @args = 1 .. $ARGV[0]
            if $args == 1 && $ARGV[0] =~ /\A$RE{num}{int}\z/ && $ARGV[0] > 0;

    my $L = SinglyLinkedList->new(@args);

    $L->print('Input:  ');

    reorder_list($L);

    $L->print('Output: ');
}

#-------------------------------------------------------------------------------
sub reorder_list
#-------------------------------------------------------------------------------
{
    my ($list) = @_;

    for (my $curr = $list->get_head;
            $curr->{next} && $curr->{next}{next};
            $curr = $curr->{next}{next})
    {
        $list->insert($curr, $list->remove_tail);
    }
}

################################################################################
