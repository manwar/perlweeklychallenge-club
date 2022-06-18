use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 168
=========================

TASK #1
-------
*Perrin Prime*

Submitted by: Roger Bell_West

The Perrin sequence is defined to start with [3, 0, 2]; after that, term N is
the sum of terms N-2 and N-3. (So it continues 3, 2, 5, 5, 7, ….)

        A Perrin prime is a number in the Perrin sequence which is also a prime
        number.

Calculate the first 13 Perrin Primes.

f(13) = [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193,
         792606555396977]

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
Generate successive terms in the Perrin sequence using the recurrence relation
p(n) = p(n-2) + p(n-3).

Test whether each new term is a prime number using Raku's in-build is-prime
method.

Output Perrin primes as they are found, until the output count reaches 13.

=end comment
#==============================================================================

my      constant @INIT-TRIPLET = 3, 0, 2;
my UInt constant $TARGET       = 13;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 168, Task #1: Perrin Prime (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt @triplet      = @INIT-TRIPLET;
    my UInt %primes{UInt} = @triplet.grep( *.is-prime ).map: { $_ => 1 };

    "f(%d) =\n  %s".printf: $TARGET, %primes.keys.sort.join: ', ';

    while %primes.keys.elems < $TARGET
    {
        my UInt $n = [+] @triplet[ 0, 1 ];

        @triplet.shift;
        @triplet.push: $n;

        if $n.is-prime
        {
            ++%primes{ $n };

            ", $n".print if %primes{ $n } == 1;
        }
    }

    put();
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
