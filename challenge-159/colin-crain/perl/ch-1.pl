#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       fareys-wear-boots.pl
#
#         Farey Sequence
#         Submitted by: Mohammad S Anwar
#         You are given a positive number, $n.
# 
#         Write a script to compute Farey Sequence of the order $n.
# 
#         Example 1:
#             Input: $n = 5
#             Output: 0/1, 1/5, 1/4, 1/3, 2/5, 
#                     1/2, 
#                     3/5, 2/3, 3/4, 4/5, 1/1
# 
#         Example 2:
#             Input: $n = 7
#             Output: 0/1, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 2/5, 3/7, 
#                     1/2, 
#                     4/7, 3/5, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 1/1
# 
#         Example 3:
#             Input: $n = 4
#             Output: 0/1, 1/4, 1/3, 
#                     1/2, 
#                     2/3, 3/4, 1/1
# 
#         method:
# 
#             The Fahey sequence or a given order n is a list of all
#             subunary fractions with denominators up to the value of the
#             order, reduced to their lowest terms and placed in ascending
#             order. One interesting property of this sequence is that for
#             any triplet of successive terms selected, the central term
#             will be the mediant of the two outer, which is to say we can
#             obtain the ratio of the intermediate value by summing the two
#             numerators and two denominators of the outside terms: for the
#             two terms in example 2 above 2/7 and 2/5 the intermediate
#             numerator is 2+2 and denominator is 7+5, yielding 4/12, wich
#             can be reduced to 1/3. This can be seen to be the case by
#             examination of the example.
# 
#             Two algorithms suggest themselves to produce the Fahey
#             sequence for a given order: we can either construct all the
#             fractions exhaustively, reduce them to their lowest terms,
#             remove duplicates and sort them; or alternately we can bisect
#             each set of adjacent fractions in the the previous order to
#             construct the next, reducing them as possible along the way,
#             until we arrive at the order requested. 
#
#             As it 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


package Rat;
{
    use Moo;
    use feature qw(signatures);
    no warnings 'experimental::signatures';

    has n => ( is => 'ro');
    has d => ( is => 'ro');

    has num => ( is => 'rw');
    has den => ( is => 'rw');
    has val => ( is => 'rw');
    
    around BUILDARGS => sub {
        my ( $orig, $class, @args ) = @_;
        return {    n => $args[0],
                    d => $args[1]  };        
    };
 
    sub BUILD ($self, $args) { 
        my $gcd = gcd( $self->n, $self->d );           
        $self->num( $self->n / $gcd );
        $self->den( $self->d / $gcd ); 
        $self->val( $self->n / $self->d );
    };
    
    sub gcd ($m, $n) {
        return $n if $m == 0;   ## gcd of (0,n) is n
        while ( $n != 0 ) {
            $n > $m and ($m, $n) = ($n, $m);
            my $r = $m - $n * ( int ($m/$n));
            return $n if $r == 0;
            ($m, $n) = ($n, $r);
        }
    }

    sub string ($self) {
        return $self->num . "/" . $self->den;
    };

}



package main;

my $order = shift @ARGV // 7;

my @rats;
for my $den (1..$order) {
    for my $num ( 0..$den) {
        push @rats, new Rat($num, $den);    
    }
}

my %farey = map { $_->string => $_->val } @rats;

say join ' ', sort { $farey{$a} <=> $farey{$b} } keys %farey;


