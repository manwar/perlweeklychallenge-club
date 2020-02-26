#!perl

################################################################################
=comment

Perl Weekly Challenge 046
=========================

Task #1
-------
*Cryptic Message*

The communication system of an office is broken and message received are not
completely reliable. To send message Hello, it ended up sending these following:

  H x l 4 !
  c e - l o
  z e 6 l g
  H W l v R
  q 9 m # o

Similary another day we received a message repeatedly like below:

  P + 2 l ! a t o
  1 e 8 0 R $ 4 u
  5 - r ] + a > /
  P x w l b 3 k \
  2 e 3 5 R 8 y u
  < ! r ^ ( ) k 0

Write a script to decrypt the above repeated message (one message repeated 6
times).

*HINT: Look for characters repeated in a particular position in all six messages
received.*

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $message = 'P + 2 l ! a t o
                   1 e 8 0 R $ 4 u
                   5 - r ] + a > /
                   P x w l b 3 k \
                   2 e 3 5 R 8 y u
                   < ! r ^ ( ) k 0';
    my $array   = make_array($message);
    my $decrypt = '';

    for my $char (0 .. $array->[0]->$#*)
    {
        my %opts;
         ++$opts{ $array->[$_][$char] } for 0 .. $#$array;

        $decrypt .= (sort { $opts{$b} <=> $opts{$a} } keys %opts)[0];
    }

    print "Decrypted message: $decrypt\n";
}

#-------------------------------------------------------------------------------
sub make_array
#-------------------------------------------------------------------------------
{
    my  ($message) = @_;
    my   @array;
    push @array, [ grep { length } split /\s+/, $_ ] for split /\n/, $message;

    return \@array;
}

################################################################################
