#!/usr/bin/env perl
# Perl weekly challenge 179
# Task 1: Ordinal number spelling
#
# See https://wlmb.github.io/2022/08/22/PWC179/#task-1-ordinal-number-spelling
use v5.36;
use experimental qw(try);
use POSIX qw(floor);
my (%ordinals, %cardinals);
@ordinals{0..19}=
    qw(zeroth first second third fourth fifth sixth seventh eighth ninth tenth
       eleventh twelfth thirteenth fourteenth fifteenth sixteenth seventeenth eighteenth
       nineteenth);
@ordinals{qw(20 30 40 50 60 70 80 90)}=
    qw(twentieth thirtieth fortieth fiftieth
       sixtieth seventieth eightieth ninetieth);
@cardinals{0..19}=qw(
    zero one two three four five six seven eight nine ten eleven twelve
    thirteen fourteen fifteen sixteen seventeen eighteen nineteen);
@cardinals{qw(20 30 40 50 60 70 80 90)}=qw(
    twenty thirty forty fifty sixty seventy  eighty ninety);
for(@ARGV){
    try {say "$_-th=", ordinal($_);}
    catch($n){say $n;};
}

sub ordinal($n){
    die "$n is too large" if $n>=1000000000;
    die "$n is not a positive integer" unless $n=~/^\s*\+?\d+\.?\s*$/;
    my $millions=floor($n/1000000);
    my $rest=$n%1000000;
    return cardinal($millions)
        . ($rest ? " million " . ordinal($rest)
                 : " millionth")   if $millions;
    my $thousands=floor($rest/1000);
    $rest %= 1000;
    return cardinal($thousands)
	. ($rest ? " thousand " . ordinal($rest)
                 : " thousandth")   if $thousands;
    my $hundreds=floor($rest/100);
    $rest%=100;
    return cardinal($hundreds)
        . ($rest ? " hundred and " . ordinal($rest)
                 : " hundredth") if $hundreds;
    my $tens = floor($rest/10);
    $rest %= 10;
    return $cardinals{10*$tens} ."-". ordinal($rest) if $tens >=2 && $rest;
    return $ordinals{10*$tens} if $tens >=2;
    return $ordinals{10*$tens+$rest} if $tens==1;
    return $ordinals{$rest} if $tens==0;
}
sub cardinal($n){
    die "$n is too large" if $n>=1000000000;
    die "$n is not a positive integer" unless $n=~/^\s*\+?\d+\.?\s*$/;
    my $millions=floor($n/1000000);
    my $rest=$n%1000000;
    return cardinal($millions). " million " . cardinal($rest) if $millions;
    my $thousands=floor($rest/1000);
    $rest%=1000;
    return cardinal($thousands) . " thousand " . cardinal($rest) if $thousands;
    my $hundreds=floor($rest/100);
    $rest%=100;
    return cardinal($hundreds) . " hundred" . ($rest? " and ". cardinal($rest) : "") if $hundreds;
    my $tens=floor($rest/10);
    $rest%=10;
    return $cardinals{10*$tens}. " " . cardinal($rest) if $tens>=2;
    return $cardinals{10*$tens+$rest} if $tens==1;
    return $cardinals{$rest} if $rest>0;
    return "";
}
