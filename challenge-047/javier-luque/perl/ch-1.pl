#!/usr/bin/perl
# Test: ./ch-1.pl V + VI
use strict;
use warnings;
use feature qw /say/;
use Number::Convert::Roman;

my $input_string = join ' ', @ARGV;
my $c = Number::Convert::Roman->new;

my %operations = (
    '+' => sub {return ($c->arabic($_[0]) + $c->arabic($_[1]))},
    '-' => sub {return ($c->arabic($_[0]) - $c->arabic($_[1]))},
    'x' => sub {return ($c->arabic($_[0]) * $c->arabic($_[1]))},
    '/' => sub {return ($c->arabic($_[0]) / $c->arabic($_[1]))},
);

if ($input_string =~ /^(\w+)\s*([\+\-x\/])\s*(\w+)$/) {
    say $c->roman(int($operations{$2}->($1, $3)));
} else {
    say "Invalid input";
}
