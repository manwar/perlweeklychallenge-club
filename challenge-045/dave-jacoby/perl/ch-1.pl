#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental::postderef experimental::signatures };

use JSON;
my $json = JSON->new;

my $string = 'The quick brown fox jumps over the lazy dog';

my $input = scalar @ARGV ? join ' ', @ARGV : $string;

my $code = encypher($input);
say $code;

sub encypher ( $plaintext ) {
    $plaintext = lc $plaintext;
    $plaintext =~ s/[^a-z]//gmx;
    my @work;

    while ( length $plaintext >= 8 ) {
        my $eight = substr $plaintext, 0, 8;
        $plaintext =~ s/\w{8}//mix;
        push @work, $eight;
    }
    push @work, $plaintext;

    my @cyphertext;

    for my $i ( 0 .. scalar @work - 1 ) {
        my $word = $work[$i];
        for my $j ( 0 .. length $word ) {
            my $letter = substr $word, $j, 1;
            next unless scalar $letter;
            $cyphertext[$j][$i] = $letter;
        }
    }

    return join ' ', map { join '', $_->@* } @cyphertext;
}
