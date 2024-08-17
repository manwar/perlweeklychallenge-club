#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub goat_latin($sentence) {
    my $order = 1;
    $sentence =~ s/(\w+)/goatify($1, ++$order)/ge;
    return $sentence
}

sub goatify($word, $order) {
    if ($word =~ /^[^aeiou]/i) {
        $word .= substr $word, 0, 1, "";
    }
    $word .= 'm' . 'a' x $order;
    return $word
}

use Test::More tests => 3;

is goat_latin('I love Perl'), 'Imaa ovelmaaa erlPmaaaa', 'Example 1';

is goat_latin('Perl and Raku are friends'),
    'erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa',
    'Example 2';

is goat_latin('The Weekly Challenge'),
    'heTmaa eeklyWmaaa hallengeCmaaaa',
    'Example 3';
