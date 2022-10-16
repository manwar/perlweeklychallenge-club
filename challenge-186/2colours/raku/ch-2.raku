#!/usr/bin/env raku

sub makeover($_) { .samemark('a') }

my $str = prompt '$str = ';
$str.&makeover.say;
