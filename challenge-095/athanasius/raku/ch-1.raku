use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 095
=========================

Task #1
-------
*Palindrome Number*

Submitted by: Mohammad S Anwar (http://www.manwar.org)

You are given a number $N.

Write a script to figure out if the given number is Palindrome. Print 1 if true
otherwise 0.

Example 1:

 Input: 1221
 Output: 1

Example 2:

 Input: -101
 Output: 0, since -101 and 101- are not the same.

Example 3:

 Input: 90
 Output: 0

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

my constant @TESTS =
            {
                input       =>  1221,
                expected    =>  1,
                description => 'Example 1',
            },
            {
                input       => -101,
                expected    =>  0,
                description => 'Example 2',
            },
            {
                input       =>  90,
                expected    =>  0,
                description => 'Example 3',
            },
            {
                input       =>  1234.4321,
                expected    =>  1,
                description => 'Decimal 1',
            },
            {
                input       =>  1234.04321,
                expected    =>  0,
                description => 'Decimal 2',
            };

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 095, Task #1: Palindrome Number (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Real $N?                 #= A real number to be tested: is it a palindrome?
)
#==============================================================================
{
    if $N.defined
    {
        "Input:  %s\nOutput: %d\n".printf: $N, is-palindrome($N) ?? 1 !! 0;
    }
    else
    {
        test();
    }
}

#------------------------------------------------------------------------------
sub is-palindrome( Real:D $N --> Bool:D )
#------------------------------------------------------------------------------
{
    my Str  @chars  = $N.split: '';
    my Bool $is-pal = True;

    for 0 .. floor(@chars.end / 2) -> UInt $i
    {
        if @chars[$i] ne @chars[@chars.end - $i]
        {
            $is-pal = False;
            last;
        }
    }

    return $is-pal;
}

#------------------------------------------------------------------------------
sub test()
#------------------------------------------------------------------------------
{
    use Test;
    plan @TESTS.elems;

    for  @TESTS -> %test
    {
        my UInt $got = is-palindrome( %test<input> ) ?? 1 !! 0;

        is $got, %test<expected>, %test<description>;
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
