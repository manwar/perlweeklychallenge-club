#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($str) = @ARGV;

my $level = 0;
my $result = q{};

for my $c (split //, $str) {
    if ($c eq q{(}) {
        if ($level > 0) {
            $result .= $c;
        }
        $level++;
    }
    elsif ($c eq q{)}) {
        $level--;
        if ($level > 0) {
            $result .= $c;
        }
    }
}

say "\"$result\"";

