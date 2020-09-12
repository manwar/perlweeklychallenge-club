#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

=pod Fibonacci Sum

=head1 SYNOPSIS

perl ch-1.pl <sum>

=head1 Solution

1. find a minimum number of fibonacci combination which tally "target sum"
   ex) 89 + 8 + 3 = 100
2. figure out how many ways to express each fibonacci in the combination
   which must be not duplicated or overlaped with other numbers

   ex) 89 -> [ 89 ], [ 55, 34 ], [ 55, 21, 13 ]
        8 -> [ 8 ] # only one
        3 -> [ 3 ], [ 2, 1]

3. Product all the cases shown above.

=head1 About Sub-cases For Each Fibonacci Number

if we have fibonacci number like below (in a reversed order)

 a b c d e f g h   (`a' is largest number)

 1. a = b + c
 2. c = d + e
 therefore an easy way to find sub cases is that
 a = b + (d + e)

 but if we're trying to change the number between `a', 'c' e.g `b'
 1'. a = b + c -> a = (c+d) + c
 `c' is duplicated
 (repeated) a = (c+d) + c = 2c + d
 if we can find `2c' where c <= `2c' <= a, this is True
 e.g) 2c == b which is impossible in any case
 because b = c + d, and of course `d' != `c'

so I concluded that chaging the fibonacci number into two lower
fibonacci numbers (right next to the current) until not overlapping
is the only way to make sub cases.

the sequence definitely looks like

      a b c -> a b _ (d e) -> a b _ (d _ (f g)) -> a b _ d _ f _ h i -> ...
 cmp: a b c -> a b c  d e  -> a b c  d e  f g      a b c d e f g h i -> ...

=cut

use strict; use warnings;
use v5.26;
use Getopt::Long qw(:config gnu_compat);
use Pod::Usage;
use List::Util qw{any product};

BEGIN {
    sub fs { "File::Spec" }
    $::debugging = 0;

    my $help = 0;

    GetOptions( "debug"   => \$::debugging,
                "help"    => \$help,
        ) or pod2usage(2);

    pod2usage( -exitval => 0, -verbose => 2 ) if $help;


    our $dprint = sub( @ ) {
        ++$|;
        print @_;
    };

    *::dprint = $::debugging ? $dprint : sub {};
}

sub fibs ($) { # excluding first 1 for challenge purpose
    my $limit = shift;
    $limit <= 1 and return (1);
    $limit <= 2 and return (1,2);

    my @fibs = ( 1, 2 );
    while ( (my $new_fib = ($fibs[-2] + $fibs[-1] )) <= $limit ) {
        push @fibs, $new_fib;
    }
    @fibs
}

sub rfibs ($) { reverse (fibs shift) }

# return the all possible ways a fib number can be expressed
#   which includes the fib number itself
# ex) f(55) -> [55], [34, 21], [34, 13, 8], [34, 13, 5, 3], [34, 13, 5, 2, 1]
# return as array of arrayref
# FIXME: need more information about implmentation

sub allCasesSubFibs ($$$) {
    # assume allRevFibsRef is sorted desc.
    my ( $afib, $allRevFibsRef, $fibsNotToUseRef )  = @_;
    my @allRevFibs = @{$allRevFibsRef}; # copy: no side effect

    my $skip = 0;
    for my $fi ( 0..$#allRevFibs ) { # FIXME: I saw something new expression
        $allRevFibs[$fi] == $afib and ( $skip = $fi + 1 );
    }
    my @subfibs = splice @allRevFibs, $skip;
    my @allCases = ( [$afib] ); # add fib number itself.
                                # XXX: even if it's already banned.

    for ( my $fi = 0; $fi+1 < @subfibs; $fi += 2 ) {
        my @lastFibs = splice( @{[@{$allCases[-1]}]}, # copy
                               0, $#{$allCases[-1]} );
        my @twoFibs = @subfibs[ $fi, $fi+1 ];
        if ( any { my $bomb = $_;
                   grep { $bomb eq $_ } @twoFibs } @$fibsNotToUseRef ) {
            last; # stop here on purpose
        }
        push @allCases, [ @lastFibs, @twoFibs ];
    }
    @allCases;
}

sub productCases ($) {
    my ( $casesRef, @pos, $csr ) = $_[0];
    my @cases = @{$casesRef}; # side note: this is copy method
    @pos = (0) x scalar @cases;
    if ( @pos == 1 ) {
        ::dprint "[WRN] only one case given\n";
    }
    my @num_cases = map { scalar @{$_} } @cases;
    ::dprint "[INF] total: ".( join " x ", @num_cases  )." = ".
      (product @num_cases)." case(s)\n";

    $csr = $#cases;

    my @allcases;
    {
        if ( $pos[$csr] < @{$cases[$csr]} ) {
            ::dprint "[DBG] $csr: @pos: ",
              (join ",", map { @{$cases[$_][$pos[$_]]} } 0..$#cases ),$/;
            # add record
            push @allcases,
              [ map { @{$cases[$_][$pos[$_]]} } 0..$#cases ];
            ++$pos[$csr];
            redo;
        }
        else {
            # find higher order case
            my $newCsr;
            for ( my $c = $csr-1; $c >= 0; --$c ) {
                if ( $pos[$c] < $#{$cases[$c]} ) {
                    $newCsr = $c;
                    ::dprint "[DBG] New Cursor: $newCsr\n";
                    last;
                }
            }
            if ( defined $newCsr ) {
                ++$pos[$newCsr];
                @pos[ $newCsr+1 .. $#pos ] = (0) x (scalar @pos);
                $csr = $#cases;
                redo;
            }
        }
    }
    @allcases;
}

# product all cases of each fib numbers
sub productRevFibCombination ($$) {
    my ( $aRevFibCombiRef, $allRevFibsRef ) = @_;
    my @fibsNotToUse = @{$aRevFibCombiRef};

    my @rcases = map {
        shift @fibsNotToUse; # remove one by one from ban list
                             # for shorter comparison
        my @a = allCasesSubFibs( $_, $allRevFibsRef, \@fibsNotToUse );
        ::dprint( ('[DBG] ', join "|", map{ "[".join( ",", @$_)."]" } @a), $/ );
        [ @a ];

    } @$aRevFibCombiRef;
    productCases \@rcases;
}

sub minRevFibSumCombination ($$);
sub minRevFibSumCombination ($$) { # find a case tally the target sum.
    my ( $targetSum, $allRevFibRef ) = @_;
    #my @allRevFib = grep { $_ <= $targetSum } @{$allRevFibRef};
    my @allRevFib = @{$allRevFibRef}; # assuming it's already sieved.
    my $majorFib;
    {
        $majorFib = shift @allRevFib;
        defined $majorFib or return ();
        ::dprint "[DBG] current major fib: $majorFib, target sum: $targetSum\n";
        redo if $majorFib > $targetSum;

        $majorFib == $targetSum and return ($majorFib);
    }

    my @rest = minRevFibSumCombination( ($targetSum-$majorFib), \@allRevFib );
    ::dprint "[DBG] rest for $majorFib: @rest\n";
    return ( @rest > 0 ? ( $majorFib, @rest ) : () )
}

# final solution form
sub allCombiFibSum ($) {
    my $targetSum = shift;
    my @reversedFibNumbers = rfibs $targetSum;

    my @aCombi = minRevFibSumCombination( $targetSum, \@reversedFibNumbers );
    ::dprint( "[DBG] A possible minimum combination: ", join( ",", @aCombi ), $/ );
    return () if @aCombi == 0;
    productRevFibCombination( \@aCombi, \@reversedFibNumbers );
}

if (0) {
    say "@{[rfibs 999]}";
    say "@$_" for allCasesSubFibs 55, [rfibs(55)], [8,3];
    say "@$_" for productRevFibCombination ( [89,21,3], [rfibs 55] );
    say "@{[minRevFibSumCombination(150, [rfibs 150])]}";
}

my $N = shift @ARGV;
( defined $N and $N > 0 ) or pod2usage( -exitval => 0, -verbose => 1 );

say "Input: \$N = $N";
my @allCombi = allCombiFibSum $N;
say "Output:";
say map {
    join( " + ",  @$_ ). " = " . $N . $/;
} @allCombi;
say "Total ".(scalar @allCombi)." case(s) found";
