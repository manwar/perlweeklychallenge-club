#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my @examples = (
    { in => "textbook",     exp => 0 },
    { in => "book",         exp => 1 },
    { in => "AbCdEfGh",     exp => 1 },
    { in => "rhythmmyth",   exp => 0 },
    { in => "UmpireeAudio", exp => 0 },
);

is(string_alike($_->{in}), $_->{exp}) for @examples;

done_testing;

sub string_alike {
    my $s = shift;
    my $l = length($s)/2;
    my $v = substr($s,0,$l) =~ y/aeiouAEIOU//;
    return $v > 0 && $v == substr($s,$l) =~ y/aeiouAEIOU// ? 1 : 0;
}
