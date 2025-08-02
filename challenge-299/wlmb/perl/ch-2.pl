#!/usr/bin/env perl
# Perl weekly challenge 299
# Task 2:  Word Search
#
# See https://wlmb.github.io/2024/12/09/PWC299/#task-2-word-search
use v5.36;
use PDL;
use PDL::NiceSlice;
my $matrix;
my $zero=pdl(0);
while(@ARGV){
   $matrix=$zero->glue(0,
               $zero->glue(1,
          pdl([map{[map {ord} split ' ']} map {split /\]\s*\[/}
               (my $alpha_matrix=shift)=~s/^\s*\[\s*\[\s*//r=~s/\s*\]\s*\]\s*$//r]),
               $zero), $zero);
   my $word=pdl[map {ord} split "", my $alpha_word=shift];
   my $result=0;
   C: for my $i(1..$matrix->dim(0)-2){
       for my $j(1..$matrix->dim(1)-2){
         $result=1, last C if test(pdl($i,$j),$word);
       }
   }
   say "$alpha_matrix, $alpha_word -> $result";
}
sub test($ind,$word){
     state @d=map {pdl $_}([1,0],[0,1],[-1,0],[0,-1]);
     return 1 unless $word->nelem;
     my $old=(my $s=$matrix->indexND($ind))->copy;
     return 0 unless  $word(0)==$s;
     $s.=0;
     return 1 if $word->nelem==1;
     for(@d){return 1 if test($ind+$_, $word(1:-1))}
     $s.=$old;
     return 0;
}
