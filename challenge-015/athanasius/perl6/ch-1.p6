use v6;

################################################################################
=begin comment

Perl Weekly Challenge 015
=========================

Task #1
-------

Write a script to generate first 10 strong and weak prime numbers.

  For example, the nth prime number is represented by p(n).

  p(1) = 1
  p(2) = 3
  p(3) = 5

  Strong Prime number p(n) when p(n) > [ p(n-1) + p(n+1) ] / 2
  Weak   Prime number p(n) when p(n) < [ p(n-1) + p(n+1) ] / 2

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my UInt constant $SERIES-LENGTH = 10;
my      constant @PRIME-TYPES   = < strong weak >;
my UInt constant $TYPE-LENGTH   = @PRIME-TYPES.map( { .chars } ).max;

sub MAIN()
{
    my      %primes   = @PRIME-TYPES.map: { $_ => [] };
    my UInt $previous = next-prime;
    my UInt $current  = next-prime;

    while %primes{'strong'}.elems < $SERIES-LENGTH ||
          %primes{'weak'  }.elems < $SERIES-LENGTH
    {
        my Int $next = next-prime;
        my Rat $mean = ($previous + $next)  /  2;
        my Str $type = ($current  > $mean) ?? 'strong' !!
                       ($current  < $mean) ?? 'weak'   !! 'balanced';

        if $type ∈ @PRIME-TYPES && %primes{$type}.elems < $SERIES-LENGTH
        {
            %primes{$type}.push: $current;
        }

        ($previous, $current) = ($current, $next);
    }

    say '';
    say "The first $SERIES-LENGTH ", $_.fmt( "%-{ $TYPE-LENGTH }s" ),
        ' primes are: ', %primes{$_}.map({ .fmt( '%2d' ) }).join(', ')
            for @PRIME-TYPES;
}

sub next-prime(--> UInt)
{
    state UInt $p = 1;

    repeat until $p.is-prime
    {
        ++$p;
    }

    return $p;
}

################################################################################
