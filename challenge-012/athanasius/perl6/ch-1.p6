use v6;

################################################################################
=begin comment

Perl Weekly Challenge 012
=========================

Challenge #1
------------

The numbers formed by adding one to the products of the smallest primes are
called the Euclid Numbers (see [ https://en.wikipedia.org/wiki/Euclid_number
|wiki]). Write a script that finds the smallest *Euclid Number* that is not
prime. This challenge was proposed by Laurent Rosenfeld.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use Math::Prime::Util:from<Perl5> < factor pn_primorial >;

my Sub $factor       := &Math::Prime::Util::factor;
my Sub $pn-primorial := &Math::Prime::Util::pn_primorial;
my Str constant $FMT := "\nThe smallest composite Euclid number E_n is:\n" ~
                          "  E_%d = (%d# + 1) = %s = %s\n";

sub MAIN()
{
    for 1 ... Inf -> Int $n
    {
        unless (my Int $euclid = $pn-primorial($n) + 1).is-prime
        {
            $FMT.printf($n, $n, commify($euclid), $factor($euclid).join(' * '));
            last;
        }
    }
}

sub commify(Int:D $n --> Str:D)
{
    return "$n" if $n.abs < 1e3;

    my @reversed  = $n.split('', :skip-empty).reverse;
    my @commified = @reversed.head;

    for 1 .. @reversed.end - 1 -> Int $index
    {
        @commified.push: @reversed[$index];
        my $next = $index + 1;
        @commified.push: ',' if $next % 3 == 0 && @reversed[$next] ne '-';
    }

    @commified.push: @reversed.tail;

    return @commified.reverse.join('');
}

################################################################################
