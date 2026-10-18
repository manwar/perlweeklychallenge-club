#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of equal lengths words.

Write a script to arrange a set of words into a grid that reading across any row gives the exact same word as reading down its corresponding column.
Example 1

Input: @words = ("MA", "AM", "MY", "ME")
Output: ("MA", "AM")

    M A
    A M

Example 2

Input: @words = ("SUN", "USE", "NET", "SEE", "TEN")
Output: ("SUN", "USE", "NET")

    S U N
    U S E
    N E T

Example 3

Input: @words = ("BOAT", "TEAL", "AREA", "TSAR", "OGRE")
Output: ("BOAT", "OGRE", "AREA", "TEAL")

    B O A T
    O G R E
    A R E A
    T E A L

Example 4

Input: @words = ("CARD", "AREA", "REAR", "DART")
Output: ("CARD", "AREA", "REAR", "DART")

    C A R D
    A R E A
    R E A R
    D A R T

Example 5

Input: @words = ("HEART", "TREND", "EMBER", "RESIN", "ABUSE")
Output: ("HEART", "EMBER", "ABUSE", "RESIN", "TREND")

    H E A R T
    E M B E R
    A B U S E
    R E S I N
    T R E N D

=cut


use Test2::V0 -no_srand => 1;

is([word_squares("MA", "AM", "MY", "ME")],
     ["MA", "AM"], 'Example 1');

is([word_squares("SUN", "USE", "NET", "SEE", "TEN")],
     ["SUN", "USE", "NET"], 'Example 2');

is([word_squares("BOAT", "TEAL", "AREA", "TSAR", "OGRE")],
     ["BOAT", "OGRE", "AREA", "TEAL"], 'Example 3');
     
is([word_squares("CARD", "AREA", "REAR", "DART")],
     ["CARD", "AREA", "REAR", "DART"], 'Example 4');
     
is([word_squares("HEART", "TREND", "EMBER", "RESIN", "ABUSE")],
     ["HEART", "EMBER", "ABUSE", "RESIN", "TREND"], 'Example 5');

done_testing();

sub word_squares 
{
     my @words = @_;
     my $n = length($words[0]);
     my @answer = choose(\@words, 0, $n, []);
     return @answer;
    
     sub choose 
     {
          my ($source, $side, $n_all, $output) = @_;
        
          if ($side == $n_all) 
          {
               return @$output;
          }
        
          for my $idx (0 .. $#$source) 
          {
               if (is_square($output, $source->[$idx], $side)) 
               {
                    my $word = splice(@$source, $idx, 1);  
                    push @$output, $word;
                    my @result = choose($source, $side + 1, $n_all, $output);
                    return @result if @result;  

                    pop @$output;
                    splice(@$source, $idx, 0, $word);  
               }
          }
     }
}


sub is_square 
{
     my ($aref, $cand, $row) = @_;
     return 1 if $row == 0;
    
     my @temp = @$aref;
     push @temp, $cand;
    
     for my $r (0 .. $row - 1) 
     {
          if (substr($temp[$r], $row, 1) ne substr($temp[$row], $r, 1)) 
          {
               return 0;
          }
     }
     return 1;
}
