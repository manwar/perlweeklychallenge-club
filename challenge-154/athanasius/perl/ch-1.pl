#!perl

###############################################################################
=comment

Perl Weekly Challenge 154
=========================

TASK #1
-------
*Missing Permutation*

Submitted by: Mohammad S Anwar

You are given possible permutations of the string 'PERL'.

 PELR, PREL, PERL, PRLE, PLER, PLRE, EPRL, EPLR, ERPL,
 ERLP, ELPR, ELRP, RPEL, RPLE, REPL, RELP, RLPE, RLEP,
 LPER, LPRE, LEPR, LRPE, LREP

Write a script to find any permutations missing from the list.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
1. Generate all permutations (without duplicates) of the given string using the
   formultiperm() function from the CPAN module Math::Prime::Util. The permuta-
   tions are stored in @perms.
2. Optionally check whether the given "possible permutations" (in @GIVEN) are
   valid permutations of the given string, and list any which are not (see
   below).
3. For each permutation in @perms: check whether it occurs in @GIVEN using the
   list-reduction function none() from the standard module List::Util. If it
   is not present, record it as a missing permutation.
4. Report the missing permutation(s).

Note on the Given Permutations
------------------------------
The list of "given possible permuations" might contain invalid entries, but
this would not affect the logic of the algorithm. If a validity check is de-
sired, the constant $CHECK should be set to a true value (the default).

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util        qw( none );
use Math::Prime::Util qw( formultiperm );

const my $STRING => 'PERL';
const my @GIVEN  =>
         qw(
               PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL ERLP ELPR ELRP RPEL
               RPLE REPL RELP RLPE RLEP LPER LPRE LEPR LRPE LREP
           );
const my $CHECK  => 1;
const my $USAGE  => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 154, Task #1: Missing Permutation (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    printf "Input:  %d possible permutations of the string %s\n",
        scalar @GIVEN, $STRING;

    my @perms;

    formultiperm { push @perms, join '', @_ } [ sort split //, $STRING ];

    check_given_perms( \@perms ) if $CHECK;

    my @missing;

    for my $s (@perms)
    {
        push @missing, $s if none { $s eq $_ } @GIVEN;
    }

    my $missing = scalar @missing;

    printf "Output: There %s %d missing permutation%s %s\n",
        $missing == 1 ? 'is' : 'are',
        $missing,
        $missing == 0 ? 's'  : $missing == 1 ? ':' : 's:',
        join ', ', @missing;
}

#------------------------------------------------------------------------------
sub check_given_perms
#------------------------------------------------------------------------------
{
    my ($perms) = @_;
    my  @invalid;

    for my $p (@GIVEN)
    {
        push @invalid, $p if none { $p eq $_ } @$perms;
    }

    my $invalid = scalar @invalid;

    if ($invalid == 0)
    {
        print  "        All of these are valid\n";
    }
    else
    {
        printf "        %d of these %s invalid: %s\n",
            $invalid,
            $invalid == 1 ? 'is' : 'are',
            join ', ', @invalid;
    }
}

###############################################################################
