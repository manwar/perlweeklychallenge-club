use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 133
=========================

TASK #2
-------
*Smith Numbers*

Submitted by: Mohammad S Anwar

Write a script to generate first 10 Smith Numbers in base 10.

According to [ https://en.wikipedia.org/wiki/Smith_number |Wikipedia]:

    In number theory, a Smith number is a composite number for which, in a
    given number base, the sum of its digits is equal to the sum of the digits
    in its prime factorization in the given number base.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
Prime factors are found via a simple, brute-force search, which is inefficient,
but fast enough for the given task. Advantage is taken of Raku's in-built
is-prime() method to provide a small optimization.

=end comment
#==============================================================================

my UInt constant $TARGET = 10;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 133, Task #2: Smith Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt @smith;

    loop (my UInt ($count, $n) = (0, 4); $count < $TARGET; ++$n)
    {
        if is-smith( $n )
        {
            @smith.push: $n;
            ++$count;
        }
    }

    "The first %d Smith numbers: %s\n".printf: $TARGET, @smith.join: ', ';
}

#------------------------------------------------------------------------------
sub is-smith( UInt:D $n --> Bool:D )
#------------------------------------------------------------------------------
{
    my UInt @prime-factors = prime-factors( $n );

    return False unless @prime-factors.elems > 1;    # Smith nums are composite

    my UInt $factor-digit-sum = 0;

    for @prime-factors              # Sum the digits of the prime factors of $n
    {
        $factor-digit-sum += $_ for .split: '', :skip-empty;
    }

    my UInt $n-digit-sum = 0;

    $n-digit-sum += $_ for $n.split: '', :skip-empty;    # Sum the digits of $n

    return $n-digit-sum == $factor-digit-sum;
}

#------------------------------------------------------------------------------
sub prime-factors( UInt:D $n is copy --> Array:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt @prime-factors;
    my UInt $max-f = $n.sqrt.floor;

    loop (my UInt $f = 2; $f <= $max-f && $n > 1; ++$f)
    {
        next unless $f.is-prime;

        while $n % $f == 0
        {
            @prime-factors.push: $f;
            $n = ($n / $f).Int;
        }
    }

    @prime-factors.push: $n if $n > 1;

    return @prime-factors;
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
