#!/usr/bin/env raku

sub AM(@input) {
  @input.sum/@input
}

sub GM(@input) {
  ([*] @input) ** (1/@input)
}

sub HM(@input) {
  @input/@input.map(1/*).sum
}

my $input = prompt 'Input: @n = ';
my @n = $input.comb: /'-'? \d+ /;
say "Output: AM = {round(AM(@n), 0.1)}, GM = {round(GM(@n), 0.1)}, HM = {round(HM(@n), 0.1)}"; 
