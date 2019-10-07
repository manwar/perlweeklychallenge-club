#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

# Task #1
# Write a script to demonstrate brace expansion. For example, script
# would take command line argument
#   Perl {Daily,Weekly,Monthly,Yearly} Challenge
# and should expand it and print like below:
#   Perl Daily Challenge
#   Perl Weekly Challenge
#   Perl Monthly Challenge
#   Perl Yearly Challenge

# HT https://rosettacode.org/wiki/Brace_expansion#Perl

use JSON;
my $json = JSON->new->pretty->canonical;

my $argv  = join ' ', @ARGV;
say $argv;
say '-' x length $argv;

my @array = expand($argv);
say join "\n", @array;

say '-' x length $argv;

my @expand = brace_expand($argv);
say join "\n", @expand;

say '-' x length $argv;

sub expand ($input) {
    my @stack = ( [ my $current = [''] ] );
    my @input = $input =~ /\G ((?:[^\\{,}]++ | \\(?:.|\z))++ | . )/gx;
    for my $token (@input) {
        if ( $token eq '{' ) { push @stack, ( [ $current = [''] ] ) }
        elsif ( $token eq ',' && @stack > 1 ) {
            push @{ $stack[-1] }, ( $current = [''] );
        }
        elsif ( $token eq '}' && @stack > 1 ) {
            my $group = pop @stack;
            $current = $stack[-1][-1];

            # handle the case of brace pairs without commas:
            @{ $group->[0] } = map { "{$_}" } @{ $group->[0] }
                if @$group == 1;

            @$current = map {
                my $c = $_;
                map {
                    map { $c . $_ }
                        @$_
                } @$group;
            } @$current;
        }
        else {
            $_ .= $token for @$current;
        }
    }

    while ( @stack > 1 ) {
        my $right = pop @{ $stack[-1] };
        my $sep;
        if   ( @{ $stack[-1] } ) { $sep = ',' }
        else                     { $sep = '{'; pop @stack }
        $current  = $stack[-1][-1];
        @$current = map {
            my $c = $_;
            map { $c . $sep . $_ } @$right;
        } @$current;
    }

    return @$current;
}

sub brace_expand {
    my $input = shift;
    my @stack = ( [ my $current = [''] ] );

    while ( $input =~ /\G ((?:[^\\{,}]++ | \\(?:.|\z))++ | . )/gx ) {

        if ( $1 eq '{' ) {
            push @stack, [ $current = [''] ];
        }
        elsif ( $1 eq ',' && @stack > 1 ) {
            push @{ $stack[-1] }, ( $current = [''] );
        }
        elsif ( $1 eq '}' && @stack > 1 ) {
            my $group = pop @stack;
            $current = $stack[-1][-1];

            # handle the case of brace pairs without commas:
            @{ $group->[0] } = map { "{$_}" } @{ $group->[0] }
                if @$group == 1;

            @$current = map {
                my $c = $_;
                map {
                    map { $c . $_ }
                        @$_
                } @$group;
            } @$current;
        }
        else { $_ .= $1 for @$current; }
    }

    # handle the case of missing closing braces:
    while ( @stack > 1 ) {
        my $right = pop @{ $stack[-1] };
        my $sep;
        if   ( @{ $stack[-1] } ) { $sep = ',' }
        else                     { $sep = '{'; pop @stack }
        $current  = $stack[-1][-1];
        @$current = map {
            my $c = $_;
            map { $c . $sep . $_ } @$right;
        } @$current;
    }

    return @$current;
}
