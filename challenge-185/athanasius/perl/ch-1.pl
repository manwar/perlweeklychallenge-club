#!perl

###############################################################################
=comment

Perl Weekly Challenge 185
=========================

TASK #1
-------
*MAC Address*

Submitted by: Mohammad S Anwar

You are given MAC address in the form i.e. hhhh.hhhh.hhhh.

Write a script to convert the address in the form hh:hh:hh:hh:hh:hh.

Example 1

  Input:  1ac2.34f0.b1c2
  Output: 1a:c2:34:f0:b1:c2

Example 2

  Input:  abc1.20f1.345a
  Output: ab:c1:20:f1:34:5a

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

Note
----
[[:xdigit:]] is the POSIX character class matching hexadecimal digits [1].

Reference
---------
[1] https://perldoc.perl.org/perlrecharclass#POSIX-Character-Classes

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $TOTAL_DIGITS => 12;
const my $DIGIT_SET    =>  4;
const my $TEST_FIELDS  =>  3;
const my $USAGE        =>
"Usage:
  perl $0 <MAC>
  perl $0

    <MAC>    MAC address in the form \"hhhh.hhhh.hhhh\" (h = hex digit)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 185, Task #1: MAC Address (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 1)
    {
        my $MAC = $ARGV[ 0 ];

        print "Input:  $MAC\n";

        my @hex = validate_hex (  $MAC );
        my $out = insert_colons( \@hex );

        print "Output: $out\n";
    }
    else
    {
        error( 'Too many command-line arguments' );
    }
}

#------------------------------------------------------------------------------
sub validate_hex
#------------------------------------------------------------------------------
{
    my ($MAC) = @_;

    $MAC =~ / ^ ([[:xdigit:]]{$DIGIT_SET}) \.
                ([[:xdigit:]]{$DIGIT_SET}) \.
                ([[:xdigit:]]{$DIGIT_SET}) $ /x
        or error( 'Invalid MAC address' );

    return split '', join '', @{ ^CAPTURE };
}

#------------------------------------------------------------------------------
sub insert_colons
#------------------------------------------------------------------------------
{
    my ($hex)  = @_;
    my  $elems = scalar @$hex;

    $elems == $TOTAL_DIGITS
        or die "Expected $TOTAL_DIGITS elements, found $elems\n";

    my  $out   = '';
    my  $count = 0;

    for my $h (@$hex)
    {
        $out .= $h;
        $out .= ':' if ++$count % 2 == 0;
    }

    chop   $out;

    return $out;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR:  $message\n$USAGE";
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

        my @hex = validate_hex (  $in  );
        my $out = insert_colons( \@hex );

        is $out, $exp, $name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1,   1ac2.34f0.b1c2, 1a:c2:34:f0:b1:c2
Example 2,   abc1.20f1.345a, ab:c1:20:f1:34:5a
Capitals,    1AC2.34F0.B1C2, 1A:C2:34:F0:B1:C2
Digits only, 0123.4567.8901, 01:23:45:67:89:01
Mix,         0a1B.2c3D.4e5F, 0a:1B:2c:3D:4e:5F
