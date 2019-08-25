use v6;

################################################################################
=begin comment

Perl Weekly Challenge 022
=========================

Task #1
-------
Write a script to print first *10 Sexy Prime Pairs*. Sexy primes are prime
numbers that differ from each other by 6. For example, the numbers 5 and 11 are
both sexy primes, because *11 - 5 = 6*. The term *"sexy prime"* is a pun
stemming from the Latin word for six: sex. For more information, please checkout
wiki [ https://en.wikipedia.org/wiki/Sexy_prime |page].

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my UInt constant $DIFFERENCE =  6;
my UInt constant $TARGET     = 10;

BEGIN say '';

sub MAIN()
{
    my      @pairs;
    my UInt $prime = 1;

    while @pairs.elems < $TARGET
    {
        Nil until is-prime(++$prime);                      # Find the next prime

        my UInt $partner = $prime + $DIFFERENCE;

        @pairs.push( [$prime, $partner] ) if is-prime($partner);
    }

    say "The first $TARGET sexy prime pairs are:\n",
         @pairs.map( { '(%2d, %2d)'.sprintf(@$_) } ).join(', ');
}

################################################################################
