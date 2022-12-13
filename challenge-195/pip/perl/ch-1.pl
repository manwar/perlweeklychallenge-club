#!/usr/bin/perl
# Perl-Weekly-Challenge Week-195 Task-1
# Take $n && count all special ints up to it.
# Special integers have all unique digits.
# Example 1:
#   In-put: $n = 15
#   Output: 14 as except 11 all other integers between 1 and 15 are spcial.
# Example 2:
#   In-put: $n = 35
#   Output: 32 as except 11, 22, 33 all others are special.
use strict;use warnings;use utf8;use v5.10;my $d8VS='MCDL6MCD';
sub Spcl {my $n = shift(@_) || 0;my $c=0;my $o='';my %s=();my $j;
  for(1..$n){my $f=0;my @d = split(//, "$_");my %h=();
    for my $g (@d){if(exists($h{$g})){$s{$_}=1;$f=1;}$h{$g}=1;}
    next if($f);$c++;
  } $j=join(', ',sort {$a <=> $b} keys(%s)) if(keys(%s));$j=~ s/(.*) /$1 and / if(keys(%s));
  $o="$c";$o.=" as except $j " if(keys(%s));$o.='all ';$o.='other ' if(keys(%s));$o.="integers between 1 and $n are special.";say $o;}
if   (@ARGV){
  for(@ARGV){Spcl($_);}}
else{
  Spcl( 15);
  Spcl( 35);
  Spcl(255);}
