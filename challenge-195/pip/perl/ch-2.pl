#!/usr/bin/perl
# Perl-Weekly-Challenge Week-195 Task-2
# Write script to find most frequent even numbers in list. In case you get more than one even number return smallest even integer. 4 all other case, return -1.
# Example 1:
#   In-put: @list = (1,1,2,6,2)
#   Output: 2 as there are only 2 even numbers 2 and 6 and of those 2 appears the most.
# Example 2:
#   In-put: @list = (1,3,5,7)
#   Output: -1 since no even numbers found in the list
# Example 3:
#   In-put: @list = (6,4,4,6,1)
#   Output: 4 since there are only two even numbers 4 and 6. They both appears the equal number of times, so pick the smallest.
use strict;use warnings;use utf8;use v5.10;my $d8VS='MCDL5pip';
sub Most {my %freq=();my $outp='';my $mfen=0;my $maxv=-1;my %maxe=();my $jevz='';my $jmez='';for(@_){
    if($_ % 2 == 0){
      if(exists($freq{$_})){$freq{$_}++;}
      else{     $freq{$_}=1;} } }
  if(keys(%freq)){
    my @valz=sort {$a <=> $b} values(%freq);
    for(@valz){$maxv=$_;
      for my $fkey (keys(%freq)){
        if($freq{$fkey} == $_){
          $maxe{$fkey}=1 if($maxv > 0 && $maxv == $valz[-1]); } } }
    if  (scalar(keys(%maxe))){     $jevz=join(', ',sort {$a <=> $b} keys(%freq));
      if(scalar(keys(%freq)) <= 2){$jevz=join(' ' ,sort {$a <=> $b} keys(%freq));}
      $jmez=                             join(', ',sort {$a <=> $b} keys(%maxe));
      if(scalar(keys(%maxe)) <= 2){$jmez=join(' ' ,sort {$a <=> $b} keys(%maxe));}
      $jevz=~ s/(.*) /$1 and /;
      $jmez=~ s/(.*) /$1 and /;}
      if(scalar(keys(%maxe)) == 1){$mfen=(keys(%maxe))[0];
      }else{      $mfen=(sort {$a <=> $b} keys(%maxe))[0];} 
    $outp=sprintf("$mfen since there are only %d even numbers: $jevz",scalar(keys(%freq)));
    if  (scalar(keys(%maxe)) == 1){$outp.=" and of those $mfen appears the most.";}
    else{$outp.=". $jmez appear an equal most number of times, so pick the smallest.";}}
  else{  $outp='-1 since no even numbers found in the list.';}
  say $outp;}
if(@ARGV){
  Most(@ARGV);}
else{
  Most(1,1,2,6,2);
  Most(1,3,5,7  );
  Most(6,4,4,6,1);
  Most(2,4,4,4,6,6,6,8,8);
  Most(2,4,4,6,6,6,8,8,8);}
