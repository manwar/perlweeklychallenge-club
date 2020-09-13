#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

# tested with:
# raku ch-1.raku 20000
# `-> 90 case(s) 2.17 secs

use v6.d;

our $d is export = False;

sub test { say $d }

multi sub fibs ( 1 ) { (1)   }
multi sub fibs ( 2 ) { (1,2) }
multi sub fibs ( Int $limit ) {
    my @fibs = 1,2;
    while ( (my $new-fib = ( @fibs[*-2] + @fibs[*-1] )) <= $limit ) {
        push @fibs, $new-fib;
    }
    @fibs
}

sub rfibs ( $limit ) { fibs($limit).reverse } # r: reverse
say "reverse fibs(100) test: {rfibs(100)}" if $d;


class CombiFibSum {
    has ( @!rfibs, $.target-sum );
    method rfibs {
        ( @!rfibs.elems == 0 or @!rfibs[*-1] < $!target-sum )
        and @!rfibs = rfibs( $!target-sum );

        @!rfibs
    }

    # return the all possible ways a fib number can be expressed
    #   which includes the fib number itself
    # ex) f(55)-> [55], [34, 21], [34, 13, 8], [34, 13, 5, 3], [34, 13, 5, 2, 1]
    method a-fib-subcases( $a-fib ) {
        my $beg = Nil;
        my @all-cases;
        for 0 .. self.rfibs.end -> $i { # call .rfibs to ensure to get @!rfibs
            @!rfibs[$i] == $a-fib and ( $beg = $i+1, last );
        }
        $beg.defined or Empty.return;  # not a fibonacci num.
        @all-cases.push( ( $a-fib,) ); # note: comma required

        loop ( my $fi = $beg; $fi+1 < @!rfibs.elems; $fi+=2 ) {
            my @last-fibs-except-last-fib = @all-cases[*-1][0..*-2];
            my @two-new-fibs = @!rfibs[$fi, $fi+1];
            @all-cases.push( ( |@last-fibs-except-last-fib, |@two-new-fibs ) );
        }
        if $d {
            print "sub cases of fib({$a-fib}): ";
            say @all-cases.map( *.Array.raku ).join(" | ");
        };
        @all-cases
    }

    method all-fibs-subcases( @rfibs ) {
        #my @ban-list = @rfibs.clone;
        #my $bi = 0; # for ban list indexing

        my @all-fibs-subcases;
        @rfibs.map(
            -> $f {
                @all-fibs-subcases.push(
                    self.a-fib-subcases( $f )
                 ) } );

        dd @all-fibs-subcases if $d;
        @all-fibs-subcases
    }

    # find a case tally the target sum
    multi method min-combi-fib-sum ( $tsum = $!target-sum,
                                     @given-rfibs is copy = self.rfibs.clone ) {
        my ( $major-fib, $skip ) = Nil, 0;
        through-rfibs:
        for ( 0 .. @given-rfibs.end ) -> $fi {

            given @given-rfibs[$fi] {
                when ( * > $tsum ) { next through-rfibs }
                when (     $tsum ) { .return }
                $major-fib = $_;
            }

            $skip      = $fi+1;
            last;
        }

        $major-fib.defined or Empty.return;
        my @rest = samewith( $tsum-$major-fib, @given-rfibs[$skip..*] );
        @rest.elems > 0 ?? ( $major-fib, |@rest ) !! Empty;
    }

    method all-combi-sum {
        my @a-combi = self.min-combi-fib-sum;
        @a-combi.elems == 0 and ().return;
        say "found a combination of sum({$!target-sum}):"
        ~ " {@a-combi.Array.raku}" if $d;

        my @all-fibs-subcases = self.all-fibs-subcases( @a-combi );
        ( [X] @all-fibs-subcases ).
        map( -> $c
             {
                 my $found-duplicated = False;
                 $c.rotor(2 => -1).
                 map( -> ($a, $b)
                      {
                          $a[*-1] <= $b[0]
                          and ( $found-duplicated = True, last );
                      } );
                 next if $found-duplicated;
                 $c».List.flat } ); # or collect found a case
    }
}

sub MAIN (
    UInt:D \S,               #= target fibonacci sum
    Bool :$debug = False #= show verbose message
) {
    $d = $debug;
    my CombiFibSum $F .= new( :target-sum(S) );
    my @all-combi = $F.all-combi-sum;

    say "Input: " ~ S;
    say "Output:";

    if ( @all-combi.elems == 0 ) {
        say "0"; # I couldn't find this case.
    } else {
        @all-combi.map(
            -> @a-combi {
                say @a-combi.join(" + ") ~ " = " ~ S;
            } );
        say "Total {@all-combi.elems} case(s) found.";
    }
}
