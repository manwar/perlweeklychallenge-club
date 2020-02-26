#!perl

################################################################################
=comment

Perl Weekly Challenge 045
=========================

Task #1
-------
*Square Secret Code*
The square secret code mechanism first removes any space from the original
message. Then it lays down the message in a row of 8 columns. The coded message
is then obtained by reading down the columns going left to right.

For example, the message is *"The quick brown fox jumps over the lazy dog".*

Then the message would be laid out as below:

  thequick
  brownfox
  jumpsove
  rthelazy
  dog

The code message would be as below:

  tbjrd hruto eomhg qwpe unsl ifoa covz kxey

Write a script that accepts a message from command line and prints the equiva-
lent coded message.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $COLUMNS => 8;

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    @ARGV > 0          or die "Missing command-line message\n";

    my $plain   = join '', @ARGV;
    my $encoded = encode($plain);
    my $decoded = decode($encoded);

    print  "Original message:\n>$plain<\n";
    print "\nEncoded message:\n>$encoded<\n";
    print "\nDecoded message:\n>$decoded<\n";

    $decoded eq $plain or die "\nCoding error\n";
}

#-------------------------------------------------------------------------------
sub encode
#-------------------------------------------------------------------------------
{
    my  ($plain)  = @_;
    my   @rows;
    push @rows, substr($plain, 0, $COLUMNS, '') while $plain;
    my   $encoded = '';

    for my $col (0 .. $COLUMNS - 1)
    {
        $encoded .= ' ' if $encoded;

        for my $row (0 .. $#rows)
        {
            my $text  = $rows[$row];
            $encoded .= substr($text, $col, 1) if $col < length $text;
        }
    }

    return $encoded;
}

#-------------------------------------------------------------------------------
sub decode
#-------------------------------------------------------------------------------
{
    my ($encoded) = @_;
    my  @rows     = split /\s+/, $encoded;
    my  $decoded  = '';

    for my $col (0 .. length($rows[0]) - 1)
    {
        $decoded .= substr($rows[$_], $col, 1) for 0 .. $#rows;
    }

    return $decoded;
}

################################################################################
