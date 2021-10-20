#!/usr/bin/env perl
# Perl weekly challenge 135
# Task 2: Validate SEDOL
#
# See https://wlmb.github.io/2021/10/20/PWC135/#task-2-validate-sedol
use v5.12;
use warnings;
use List::Util qw(all sum0);
use List::MoreUtils qw(pairwise);
my @weights=(1,3,1,7,3,9,1);
my $i=0;
my %values=map {$_=> $i++} 0..9,"A".."Z"; # compute weights
map {$values{$_}=undef} split '', "AEIOU"; # remove vowels
my %origin;
$origin{6}="Asia or Africa";
@origin{0,3}=("UK or Ireland")x2;
@origin{4,5,7}=("Europe")x3;
$origin{2}="America";

foreach(@ARGV){
    say "Input: $_, Output: ", is_sedol($_);
}
sub is_sedol {
    my @s=split '', uc shift; # Assume lc is valid
    return "0, Need 7 chars" unless @s==7;
    return "0, Last char should be digit" unless $s[6]=~m/\d/;
    return "0, Invalid char" unless all {defined $values{$_}} @s; # valid chars
    my @v=@values{@s};
    return "0, Wrong check digit"
           unless (sum0 pairwise {$a*$b} @weights, @v)%10==0;
    return "1, End user SEDOL" if $v[0]==9; # Assume no other restriction
    return "1, New SEDOL" if $s[0] ge 'B';
    return "0, Only digits for old SEDOLs" unless  all {$_<10} @v;
    return "1, Old SEDOL, probably from $origin{$v[0]}" if defined $origin{$v[0]};
    return "1, Old SEDOL, unknown origin";
}
