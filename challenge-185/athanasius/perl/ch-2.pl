#!perl

###############################################################################
=comment

Perl Weekly Challenge 185
=========================

TASK #2
-------
*Mask Code*

Submitted by: Mohammad S Anwar

You are given a list of codes in many random format.

Write a script to mask first four characters (a-z,0-9) and keep the rest as it
is.

Example 1

  Input: @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy')
  Output: ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')

Example 2

  Input: @list = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f')
  Output: ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f')

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no arguments are given on the command-line, the test suite is run.

Assumption
----------
If fewer than 4 characters are eligible for masking, they will be masked but no
error will be reported. That is, the requirement is interpreted to be: "Write a
script to mask UP TO THE first four characters (a-z,0-9)...".

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Set::Tiny;
use Test::More;

const my $MASK_CHAR    => 'x';
const my $MASK_COUNT   =>  4;
const my $TARGET_CHARS =>  Set::Tiny->new( 'a'..'z', '0'..'9' );
const my $TEST_FIELDS  =>  3;
const my $USAGE        =>
"Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    List of code strings to be masked\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 185, Task #2: Mask Code (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if ($args == 0)
    {
        run_tests();
    }
    else
    {
        printf "Input: \@list = (%s)\n", join ', ', map { "'$_'" } @ARGV;

        my @masked;

        for my $code (@ARGV)
        {
            push @masked, mask( $code );
        }

        printf "Output:        (%s)\n",  join ', ', map { "'$_'" } @masked;
    }
}

#------------------------------------------------------------------------------
sub mask
#------------------------------------------------------------------------------
{
    my ($code)  = @_;
    my  @chars  = split '', $code;
    my  $masked = '';
    my  $count  = 0;

    for my $char (@chars)
    {
        if ($count < $MASK_COUNT && $TARGET_CHARS->has( $char ))
        {
            $masked .= $MASK_CHAR;
            ++$count;
        }
        else
        {
            $masked .= $char;
        }
    }

    return $masked;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($name, $in, $exp) = split / , \s* /x, $line, $TEST_FIELDS;

        is mask( $in ), $exp, $name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1.1,  ab-cde-123,   xx-xxe-123
Example 1.2,  123.abc.420,  xxx.xbc.420
Example 1.3,  3abc-0010.xy, xxxx-0010.xy
Example 2.1,  1234567.a,    xxxx567.a
Example 2.2,  a-1234-bc,    x-xxx4-bc
Example 2.3,  a.b.c.d.e.f,  x.x.x.x.e.f
Short string, pq-4,         xx-x
x unchanged,  m-x:n87:0,    x-x:xx7:0
