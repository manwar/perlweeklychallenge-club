#!/usr/bin/perl
use v5.38;

sub max($first, $second) {
    return $first > $second ? $first : $second;
}

my @ints = @ARGV;

my $neg = 0;
my $pos = 0;

for my $int (@ints) {
    if ($int < 0) {
        $neg++;
    }  elsif ($int > 0) {
        $pos++;
    }

}
say max($neg, $pos);