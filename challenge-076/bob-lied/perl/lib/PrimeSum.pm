# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# PrimeSum.pm
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package PrimeSum;

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;


require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw(_loadPrimeList);    # Export for testing

my @PrimeList; # Class variable, lazy evaluation.

# Assuming that finding the primes is not part of the exercise.
# Make the list in descending order.
# Could replace this with a sieve if we wanted to find primes ourselves.
sub _loadPrimeList($n, $pathToList)
{
    if ( ! @PrimeList )
    {
        use File::Slurper 'read_lines';
        # https://www.mathsisfun.com/numbers/prime-number-lists.html
        @PrimeList = sort { $b <=> $a }  read_lines($pathToList);
    }
    return [  grep { $_ <= $n } @PrimeList ];
}

sub new($class, @args)
{
    $class = ref($class) || $class;
    my $self = {
        _n => $args[0],
        _pathToPrimes => $args[1], 
        _primeList => undef,

        _numPrimesRequired => int($args[0] / 2),
        _comboList => undef,
    };

    $self->{_pathToPrimes} //= "lib/primes-to-10k.txt";
    $self->{_primeList} = _loadPrimeList( $self->{_n}, $self->{_pathToPrimes} ); 
    bless $self, $class;
    return $self;
}

sub run($self)
{
    my @primes = @{$self->{_primeList}};
    while ( @primes )
    {
        $self->_primeSum(1, $self->{_n}, \@primes, $primes[0], [ $primes[0] ] );

        # Not going to get a shorter list than 1 (if N is prime)
        last if ( $self->{_numPrimesRequired} == 1 );
        shift @primes;
    }

    my $clist = $self->{_comboList};
    my $min = $self->{_numPrimesRequired};


    # Select the rows of $clist that have minimum length
    # and make a smaller list by taking that slice.
    my @shortList = @{$clist}[ grep { scalar(@{$clist->[$_]}) == $min } 0 .. scalar(@$clist)-1 ];

    return $min, $shortList[0];
}

sub _primeSum($self, $depth, $target, $primeList, $prime, $combo)
{
    # say "$depth: $target, $prime, [ @$combo ]";
    my $diff = $target - $prime;
    if ( $diff == 0 )
    {
        push @{$self->{_comboList}}, [ @$combo ];
        $self->{_numPrimesRequired} = $depth if $depth < $self->{_numPrimesRequired};
        return 0;
    }
    if ( $diff < 0 )
    {
        pop @$combo;
        return $diff;
    }

    # If the combo would become bigger than a solution we already found,
    # no need to go down this path.
    if ( $depth >= $self->{_numPrimesRequired} )
    {
        return $diff;
    }
    my @remainingPrime = grep { $_ <= $diff } @$primeList;
    for my $p ( @remainingPrime )
    {
        push @$combo, $p;
        $self->_primeSum($depth+1, $diff, \@remainingPrime, $p, $combo );
        pop @$combo
    }
}

1;

