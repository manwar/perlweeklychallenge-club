#!perl

################################################################################
=comment

Perl Weekly Challenge 026
=========================

Task #1
-------
Create a script that accepts two strings, let us call it, *"stones"* and
*"jewels"*. It should print the count of "alphabet" from the string *"stones"*
found in the string *"jewels"*. For example, if your *stones* is *"chancellor"*
and *"jewels"* is *"chocolate"*, then the script should print *"8"*. To keep it
simple, only A-Z,a-z characters are acceptable. Also make the comparison case
sensitive.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;

const my $ALPHA  =>  qr{ [A-Za-z] }x;
const my $STONES => 'chancellor';
const my $JEWELS => 'chocolate';
const my $USAGE  => "USAGE: perl $0 [--stones=<Str>] [--jewels=<Str>] " .
                                   "[--show]\n";

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $stones = $STONES;
    my $jewels = $JEWELS;
    my $show   = 0;

    GetOptions
    (
        'stones=s' => \$stones,
        'jewels=s' => \$jewels,
        'show'     => \$show,

    ) or die $USAGE;

    my $count  = 0;
    my %jewels = map { $_ => undef } grep { /$ALPHA/ } split //, $jewels;

    # Count each letter in the "stones" string if and only if it also occurs
    # (anywhere, but at least once) in the "jewels" string

    my @letters if $show;

    for my $letter (grep { /$ALPHA/ } split //, $stones)
    {
        if (exists $jewels{$letter})
        {
            ++$count ;
            push(@letters, $letter) if $show;
        }
    }

    my $width = length $count;

    printf "%*d of the letters in the Stones string \"%s\"\n" .
           "%*s     also occur%s in the Jewels string \"%s\"\n",
            $width, $count, $stones,
           ($count == 1 ? $width - 1 : $width), '',
           ($count == 1 ?    's'     :   ''  ), $jewels;

    print('namely (', join(', ', @letters), ")\n") if $show;
}

################################################################################
