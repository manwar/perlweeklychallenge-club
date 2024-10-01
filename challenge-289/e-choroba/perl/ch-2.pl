#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ shuffle };

sub jumbled_letters($text) {
    $text =~ s/(\w+)/jumble_word($1)/ger
}

sub jumble_word($word) {
    my $shuffle_length = length($word) - 2;
    substr $word, 1, $shuffle_length, join "",
        shuffle(split //, substr $word, 1, $shuffle_length);
    return $word
}

use Test2::V0;
plan(4);

is jumbled_letters('Perl'), in_set('Perl', 'Prel'), 'Perl';

my $j = jumbled_letters("It doesn't matter.");
like $j, qr/^It d...n't m....r\.$/, "Characters that don't move";
is substr($j, 4, 3), in_set(qw( oes ose eos eso seo soe )), 'length 3';
is substr($j, 12, 4), in_set(qw( atte atet aett etta etat eatt
                                 ttae ttea taet teat tate teta )),
    'length 4';
