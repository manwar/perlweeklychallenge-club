#!/usr/bin/env raku

sub align-right($caption, $length) {
  ' ' x ($length - $caption.chars) ~ $caption
}

my @n = prompt('Input: @n = ').comb(/\d+/)>>.Int;
my @lines = @n, { [\+] .skip andthen .Array } ... * == 1;
for @lines {
  .unshift(|('' xx (@n - $_)))
}
my @col-length = [Zmax] @lines>>.chars;
.say for @lines.map(*.List Z[&align-right] @col-length).map(*.join: ' ');