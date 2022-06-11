use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
1. Generate all permutations of the given string using Raku's built-in method
   permutations(). The permutations are stored in @perms.
2. Optionally check whether the given "possible permutations" (in @GIVEN-PERMS)
   are valid permutations of the given string, and list any which are not (see
   below).
3. For each permutation in @perms: check whether it occurs in @GIVEN-PERMS
   using Raku's built-in none() method. If it is not present, record it as a
   missing permutation.
4. Report the missing permutation(s).

Note on the Given Permutations
------------------------------
The list of "given possible permuations" might contain invalid entries, but
this would not affect the logic of the algorithm. If a validity check is de-
sired, the constant $CHECK-GIVEN-PERMS should be set to True (the default).

=end comment
#==============================================================================

my Str  constant $PERM-STRING = 'PERL';
my      constant @GIVEN-PERMS =
                 <
                     PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL ERLP ELPR
                     ELRP RPEL RPLE REPL RELP RLPE RLEP LPER LPRE LEPR LRPE
                     LREP
                 >;
my Bool constant $CHECK-GIVEN-PERMS = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 154, Task #1: Missing Permutation (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    "Input:  %d possible permutations of the string %s\n".printf:
        +@GIVEN-PERMS, $PERM-STRING;

    my Str @chars = $PERM-STRING.split( '', :skip-empty ).sort;
    my Str @perms = @chars.permutations.map: { .join };

    check-given-perms( @perms ) if $CHECK-GIVEN-PERMS;

    my Str @missing;

    for @perms -> Str $s
    {
        @missing.push( $s ) if $s eq @GIVEN-PERMS.none;
    }

    "Output: There %s %d missing permutation%s %s\n".printf:
        +@missing == 1 ?? 'is' !! 'are',
        +@missing,
        +@missing == 0 ?? 's'  !! +@missing == 1 ?? ':' !! 's:',
         @missing.join: ', ';
}

#------------------------------------------------------------------------------
sub check-given-perms( Array:D[Str:D] $perms )
#------------------------------------------------------------------------------
{
    my Str @invalid;

    for @GIVEN-PERMS -> Str $p
    {
        @invalid.push( $p ) if $p eq @$perms.none;
    }

    if +@invalid == 0
    {
        '        All of these are valid'.put;
    }
    else
    {
        "        %d of these %s invalid: %s\n".printf: 
            +@invalid,
            +@invalid == 1 ?? 'is' !! 'are',
             @invalid.join: ', ';
    }
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
