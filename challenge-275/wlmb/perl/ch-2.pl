#!/usr/bin/env perl
# Perl weekly challenge 275
# Task 2:  Replace Digits
#
# See https://wlmb.github.io/2024/06/24/PWC275/#task-2-replace-digits
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to replace digits by the previous character shifted the corresponding
    number of spaces
    FIN
for(@ARGV){
    my ($last, $current);
    my $result=join "", map {($last, $current)=nextchar($last, $_); $current} split "", $_;
    say "$_ -> $result";
}
sub nextchar($last, $current){
    die "Digit before first char" if /[0-9]/ && not defined $last;
    $current=chr(ord($last)+$current) if /[0-9]/;
    $last=$current unless /[0-9]/;
    die "Out of range" unless $current=~/[a-z]/i;
    return ($last, $current);
}
