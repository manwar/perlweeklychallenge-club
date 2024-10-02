#!/usr/bin/perl
use v5.38;

sub pickOne($str) {
    return substr $str, int(rand(length $str)), 1;
}

my $str = shift;
my $steps = 0;

my $digits = join q{}, '0' .. '9';
my $lower = join q{}, 'a' .. 'z';
my $upper = join q{}, 'A' .. 'Z';
my $all = $digits . $lower . $upper;
my $nondigits = $lower . $upper;
my $nonlower = $digits . $upper;
my $nonupper = $digits . $lower;

while ($str =~ /((.)\g{-1}\g{-1})/) {
    my $chars = (index($lower, $2) > -1)
        ? $nonlower
        : (index($upper, $2) > -1)
            ? $nonupper
            : $digits;
    my $c = $1;
    $str =~ s/$c/substr($c, 0, 2) . pickOne($chars)/e;
    $steps++;
}

if ($str !~ / [$digits] /x) {
    $str .= pickOne($digits);
    $steps++;
}

if ($str !~ / [$lower] /x) {
    $str .= pickOne($lower);
    $steps++;
}

if ($str !~ / [$upper] /x) {
    $str .= pickOne($upper);
    $steps++;
}

while (length $str < 6) {
    $str .= pickOne($all);
    $steps++;
}

say $steps;