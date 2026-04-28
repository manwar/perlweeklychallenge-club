#!/usr/bin/env perl
# Perl weekly challenge 371
# Task 1:  Missing Letter
#
# See https://wlmb.github.io/2026/04/27/PWC371/#task-1-missing-letter
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the missing letter in string Sn.
    The strings should contain four lower case English letters a-z and
    exactly one question mark, and they should be compatible with
    a simple or an alternating sequence.
    FIN
my $length=5;
for(@ARGV){
    try {
        die "Wrong length: $_" unless length$_ == $length;
        die "Only lowercase English letters or question marks allowed: $_" unless /^([a-z]|\?)*$/;
        die "Expected only one question mark: $_" if /\?(.*)\?/;
        die "Expected a question mark: $_" unless /^(.*)\?(.*)$/;
        my $unknown = length($1);
        my @codes = map{ord} split "";
        my @separations = map{$codes[$_+1]-$codes[$_]}
                          map {$_% ($length-1)}
                          ($unknown+1, $unknown+2);
        my @newcodes;
        $newcodes[0] = $unknown?$codes[0]:$codes[1]-$separations[1];
        @newcodes[$_]=$newcodes[$_-1] + $separations[($unknown+$_)%2] for 1..$length-1;
        die "Replacement out of range: $_" unless ord("a") <= $newcodes[$unknown] <= ord("z");
        my $newstring = join "", map {chr} @newcodes;
        my $re=s/^(.*)\?(.*)$/$1.$2/r;
        die "Inconsistent string: $_" unless $newstring=~/$re/;
        say "$_ -> ", chr $newcodes[$unknown];
    }
    catch($e) { warn $e; }
}
