#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub remove_outermost {
   my $input = shift ;
#define a current number which you increase by 1 for every opening and 
#decrease by 1 for every closing parenthesis. Opening parenthesis with 
#number 1 and closing p. with 0 must be removed
   my $after_removal ; #final string
   my @letternumbers ; #letters with number ;
   my $current_num = 0 ;
   for my $letter( split( // , $input )) {
      if ( $letter eq "(" ) {
         $current_num++ ;
      }
      else {
         $current_num-- ;
      }
      push( @letternumbers , [$current_num , $letter] ) ;
   }
   for my $element( @letternumbers ) {
      if ( $element->[1] eq "(" && $element->[0] != 1 ) {
         $after_removal .= "(" ;
      }
      if ( $element->[1] eq ")" && $element->[0] != 0 ) {
         $after_removal .= ")" ;
      }
   }
   if ( $after_removal ) {
      return $after_removal ;
   }
   else { 
      return "\"\"" ;
   }
}

say remove_outermost( "()()()" ) ;
say remove_outermost( "(((())))" ) ;
say remove_outermost( "(()())(())" ) ;
say remove_outermost( "()((()))()" ) ;
say remove_outermost( "(()(()))(()())" ) ;
