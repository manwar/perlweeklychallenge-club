#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

use Algorithm::Permute;

my @x = pandigital_1();
my @y = pandigital_2();
my @z = pandigital_3();

my @headers = qw{I PANDIGITAL1 PANDIGITAL2 PANDIGITAL3};
say join "\t", @headers;
say join "\t", map {s/./-/gmix;$_} @headers;
for my $i ( 0 .. 4 ) {
    say join "\t", $i, $x[$i], $y[$i], $z[$i];
}


sub pandigital_1 {
    my @output;
    my @nums = ( 0, 2 .. 9 );
    my $p    = Algorithm::Permute->new( \@nums );
    while ( my @res = $p->next ) {
        my $n = join '', 1, @res;
        push @output, $n;
    }
    @output = sort { $a <=> $b } @output;
    return @output[ 0 .. 4 ];
}

sub pandigital_2 {
    my $output = [];
    my $state  = [1];
    _pandigital_2( $output, $state );
    my @output = $output->@*;
    return @output[ 0 .. 4 ];
}

sub _pandigital_2 ( $output, $state ) {
    my %state  = map  { $_ => 1 } $state->@*;
    my @digits = grep { !$state{$_} } 0 .. 9;
    if ( scalar $output->@* > 5 ) { return }
    if ( scalar $state->@* == 10 ) {
        my $pandigit = join '', $state->@*;
        push $output->@*, $pandigit;
        return;
    }
    for my $i (@digits) {
        my $newstate->@* = $state->@*;
        push $newstate->@*, $i;
        _pandigital_2( $output, $newstate );
    }
    return;
}

sub pandigital_3 {
    my @output;
    my $i = 1023456789;
    while ( scalar @output < 5 ) {
        push @output, $i if is_pandigital($i);
        $i++;
    }
    return @output[ 0 .. 4 ];
}

sub is_pandigital ( $n ) {
    for my $i ( 0 .. 9 ) {
        return 0 unless $n =~ /$i/;
    }
    return 1;
}
