use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 177
=========================

TASK #2
-------
*Palindromic Prime Cyclops*

Submitted by: Mohammad S Anwar

Write a script to generate first 20 Palindromic Prime Cyclops Numbers.


    A cyclops number is a number with an odd number of digits that has a zero
    in the center only.


Output

  101, 16061, 31013, 35053, 38083, 73037, 74047, 91019, 94049,
  1120211, 1150511, 1160611, 1180811, 1190911, 1250521, 1280821,
  1360631, 1390931, 1490941, 1520251

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Configuration
-------------
The first $TARGET palindromic prime cyclops numbers (PPCNs) are displayed in
columns, with $N-PER-LN PPCNs per line; vertical alignment is achieved by set-
ting $WIDTH to a suitable value (each PPCN is right-justified in a field $WIDTH
characters wide). Adjust as desired.

Algorithm
---------
Calculation time is kept to a minimum by *constructing* palindromic cyclops
numbers (PCNs) in numerically ascending order, and testing for primality as
they are constructed. Each PCN has the form "oM0Ro" where:

  - o is an outer digit. It is limited to the values 1, 3, 7, and 9, as all
      prime numbers greater than 5 must end in one of these digits.
  - M is a sequence of 0 or more digits which does not contain a zero.
  - 0 is a literal zero.
  - R is the reverse of M.

The primality test is performed by Raku's built-in is-prime() method.

=end comment
#==============================================================================

my UInt constant $N-PER-LN =  8;
my UInt constant $TARGET   = 20;
my UInt constant $WIDTH    =  7;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 177, Task #2: Palindromic Prime Cyclops (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt @palindromic-prime-cyclops;

    L_OUTER:
    for 0 .. Inf -> UInt $digits
    {
        for 1, 3, 7, 9 -> UInt $outer
        {
            for 1 x $digits .. 9 x $digits -> Str $m
            {
                next if $m ~~ /0/;

                my UInt $n = ($outer ~ $m ~ 0 ~ $m.flip ~ $outer).Int;

                if $n.is-prime
                {
                    @palindromic-prime-cyclops.push: $n;

                    last L_OUTER
                         if @palindromic-prime-cyclops.elems >= $TARGET;
                }
            }
        }
    }

    display( @palindromic-prime-cyclops );
}

#------------------------------------------------------------------------------
sub display( Array:D[UInt:D] $palindromic-prime-cyclops )
#------------------------------------------------------------------------------
{
    "The first %d palindromic prime cyclops numbers:\n%*d".printf:
                $TARGET, $WIDTH, $palindromic-prime-cyclops[  0 ];

    for 1 .. $palindromic-prime-cyclops.end -> UInt $i
    {
        '%s%*d'.printf: ($i %% $N-PER-LN ?? ",\n" !! ', '),
                         $WIDTH, $palindromic-prime-cyclops[ $i ];
    }

    put();
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
