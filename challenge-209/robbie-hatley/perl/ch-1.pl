#! /bin/perl -CSDA

=pod

This is a 120-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。 麦藁雪、富士川町、山梨県。
=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|

  ----------------------------------------------------------------
  | Robbie Hatley's Perl soultion to The Weekly Challenge 209-1. |
  | Written Tue. Mar. 21, 2023, by Robbie Hatley.                |
  ----------------------------------------------------------------

PROBLEM DESCRIPTION:

Task 1: Special Bit Characters
Submitted by: Mohammad S Anwar
You are given an array of binary bits that ends with 0. Valid sequences in the bit string are:
[0] -decodes-to-> "a"
[1, 0] -> "b"
[1, 1] -> "c"
Write a script to print 1 if the last character is an “a”, otherwise print 0.
Example 1:   Input: @bits = (1, 0, 0)      Output: 1
Example 2:   Input: @bits = (1, 1, 1, 0)   Output: 0

INPUT/OUTPUT NOTES:

Input is via built-in array of arrays or by @ARGV. If using @ARGV, input should be a single argument consisting of an
array of arrays, in proper Perl syntax, surrounded by 'single quotes', like so: '([1,0,0,1,1],[1,1,0,1,0])'

Output is to STDOUT and will be each input array, its decoding, and 1-or-0 (depending on whether-or-not the last
character of the decoding is 'a').

=cut

# PRELIMINARIES:

use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
$"=', ';

# DEFAULT INPUTS:

my @arrays = ([1,0,0],[1,1,1,0]);

# NON-DEFAULT INPUTS:

if (@ARGV){
   @arrays = eval($ARGV[0]);
}

# SUBROUTINES:

# (none)

# MAIN BODY OF SCRIPT:

for (@arrays){
   my @array = @{$_};            # Encoded version of string.
   my $decoding = '';            # Decoded version of string.
   state $state;                 # State. 0="between characters". 1="in middle of character".
   $state = 0;                   # We're about to start a new input stream, so we're between characters.
   for (@array){                 # For each bit of input stream,
      if ( 0 == $state ){        # if we're between characters,
         if ( 0 == $_ ){         # if current bit is 0, this is character 'a',
            $decoding .= 'a';    # so tack an 'a' on the right end of $decoding.
            $state = 0;          # We're done with current character and ready for next, so $state remains 0.
         }
         else{                   # If current bit is 1,
            $state = 1;          # we're in middle of character so set $state to 1.
         }
      }
      else{                      # If state is 1, current bit determines character.
         if ( 0 == $_ ){         # If current bit is 0, this is character 'b',
            $decoding .= 'b';    # so tack a 'b' on the right end of $decoding.
            $state = 0;          # We're done with current character and ready for next, so set $state to 0.
         }
         else{                   # If current bit is 1, this is character 'c',
            $decoding .= 'c';    # so tack a 'c' on the right end of $decoding.
            $state = 0;          # We're done with current character and ready for next, so set $state to 0.
         }
      }
   }
   my $output = substr($decoding,-1) eq 'a' ? 1 : 0;
   say '';
   say "Encoded string: (@array)";
   say "Decoded string: $decoding";
   say "Output  code:   $output";
}
exit 0;
__END__
