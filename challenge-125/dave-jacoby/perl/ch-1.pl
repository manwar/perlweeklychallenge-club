#!/usr/bin/env perl

use feature qw{say state signatures};
use strict;
use warnings;
use utf8;
no warnings qw{ experimental };

use List::Util qw{ uniq };
use JSON;
use Carp;
use Getopt::Long;
my $json = JSON->new->canonical->space_after;

my $n = 5;
GetOptions( 'n=i' => \$n, );

carp 'out of range' if $n <= 0;

my $p = pythagorean_triples($n);
say <<"END";

    INPUT: $n
    OUTPUT: $p

END

sub pythagorean_triples( $n ) {
    my @output;
    push @output, pt_a($n);
    push @output, pt_c($n);
    @output = sort grep { defined } @output;
    return join ", ", @output if @output;
    return -1;
}

sub pt_a ($n ) {
    my @output;
    my $n2 = $n**2;

    for my $b1 ( 1 .. $n2 ) {
        my $b2 = $b1**2;
        my $c2 = $n2 + $b2;
        my $c  = sqrt $c2;
        next unless int $c == $c;
        my @x = sort { $a <=> $b } map { int $_ } $n, $b1, $c;
        push @output, $json->encode( \@x );
    }
    return uniq @output if @output;
    return undef;
}

sub pt_c ($n ) {
    my @output;
    my $n2 = $n**2;

    for my $b1 ( 1 .. $n2 ) {
        my $b2 = $b1**2;
        my $a2 = $n2 - $b2;
        next unless $a2 > 0;
        my $a1  = sqrt $a2;
        next unless int $a1 == $a1;
        my @x = sort { $a <=> $b } map { int $_ } $n, $b1, $a1;
        push @output, $json->encode( \@x );
    }
    return uniq @output if @output;
    return undef;

    # my @output;
    # my $n2 = $n**2;

    # for my $a1 ( 1 .. $n2 ) {
    #     my $a2 = $a1**2;
    #     for my $b1 ( 1 .. $n2 ) {
    #         my $b2 = $b1**2;
    #         my $c2 = $a2 + $b2;
    #         next if $c2 > $n2;
    #         if ( $n2 == $c2 ) {
    #             my @x = sort { $a <=> $b } map { int $_ } $a1, $b1, $n;
    #             push @output, $json->encode( \@x );
    #         }
    #     }
    # }
    # return uniq @output if @output;
    # return undef;
}
