#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

my @examples;
push @examples, 'redivider';
push @examples, 'deific';
push @examples, 'rotors';
push @examples, 'challenge';
push @examples, 'champion';
push @examples, 'christmas';
push @examples, 'sever';
push @examples, 'seer';
push @examples, 'reverse';

for my $e (@examples) {
    palindrome_tree($e);
    say '';
}

sub palindrome_tree($e ) {
    my %d;
    my @output;
    my @letters = grep { $d{$_}++ < 1 } split //, $e;

    say $e;

    for my $i (@letters) {
        push @output, $i;
        my $len = length $e;
    LETTER: for my $x ( 0 .. $len ) {
            my $l = substr $e, $x, 1;
            next if $l ne $i;
            my $string = substr $e, $x;
            my $slen   = length $string;
            for my $y ( reverse 2 .. $slen ) {
                my $substr  = substr $string, 0, $y;
                my $reverse = reverse $substr;
                if ( $substr eq $reverse ) {
                    push @output, $substr;
                    next LETTER;
                }
            }
        }
    }
    say join ' ', @output;
}
