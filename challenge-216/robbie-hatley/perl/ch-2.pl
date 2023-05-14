#! /bin/perl -CSDA

=pod

------------------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 120-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

------------------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-2.pl
Solutions in Perl for The Weekly Challenge 216-2.
Written by Robbie Hatley on Sat May 13, 2023.

------------------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Word Stickers
Submitted by: Mohammad S Anwar
You are given a list of word stickers and a target word.
Write a script to find out how many word stickers is needed to make up the given target word.

Example 1:
Input: @stickers = ('perl','raku','python'), $word = 'peon'
Output: 2
We just need 2 stickers i.e. 'perl' and 'python'.
'pe' from 'perl' and
'on' from 'python' to get the target word.

Example 2:
Input: @stickers = ('love','hate','angry'), $word = 'goat'
Output: 3
We need 3 stickers i.e. 'angry', 'love' and 'hate'.
'g' from 'angry'
'o' from 'love' and
'at' from 'hate' to get the target word.

Example 3:
Input: @stickers = ('come','nation','delta'), $word = 'accommodation'
Output: 4
We just need 2 stickers of 'come' and one each of 'nation' & 'delta'.
'a' from 'delta'
'ccommo' from 2 stickers 'come'
'd' from the same sticker 'delta' and
'ation' from 'nation' to get the target word.

Example 4:
Input: @stickers = ('come','country','delta'), $word = 'accommodation'
Output: 0
as there's no "i" in the inputs.

------------------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This one is tricky. I can't see an iterative way of doing it, and recursive approaches are usually nightmares. Let me
see if I can find a CPAN for this.... Ah, there is "Math::Combinatorics". Ok, I'll use that, then get all 1,2,3...n
combinations of "stickers" and stop when I'm either able to make the word (in which case print n), or I've run out of
combinations (in which case print 0).

COMPLICATION #1: The examples appear to indicate that any letter in any "sticker" may only be used ONCE, much like
making a sign using letter decals. My first attempt did not get this right, so I had to change the code to make
sticker letters "non-reusable".

COMPLICATION #2: Example 4 appears to indicate that we have large (unlimited?) numbers of each kind of sticker
at our disposal. That's going to be very tricky. Should I write code to determine whether it's even POSSIBLE to make
a work from a given set of skickers, regardless of having multiple copies of each kind available? That could get quite
complicated. But a simple (if not efficient) approach is, I'll limit sticker copies to the number of letters in the
word being made, because we know that if a word has n letters, and we can't make it even though we have n copies of
each sticker in our set, then we can't make that word using those stickers.

COMPLICATION #3: Oops, while the approach I lay out in #2 above technically works, for a word such as "accomodation",
with a sticker-type set NOT containing all those letters, it can take HOURS for the program to realized that it simply
can't be done and print "0". So I had to also create a "cant_make" sub to check for that. Now the run time dropped from
"several hours" down to about 810µs.

COMPLICATION #4: The approach in #3 above works well enough for words requiring 1, 2, or 3 "multiples" of the original
set of sticker types, but for more multiples, it can take several seconds. This could be dramatically improved by having
sub "can_make" report back info on which letters we "ran out of", then have number_of_stickers_needed only duplicate
the NECESSARY sticker types instead of duplicating ALL sticker types. But I'm not going to Level 4 with this program;
I spent an entire Saturday afternoon on it as it is. Level 3, while not "optimum", is "good enough" for this exercise.

------------------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a double-quoted
array of arrays in proper Perl syntax, with each inner array being a sequence of single-quoted words to be used as
"stickers" (decals) followed by a word to be made from those stickers, like so:
./ch-2.pl "(['horse', 'pig ', 'goat', 'port'], ['dog', 'pig', 'cow', 'ddddd'], ['fig', 'apple', 'peach', 'helm'])"

Output is to STDOUT and will be the word to be made, followed by a list of sticker types from which the word is to be
made, followed by the number of stickers required (or "0" if the word can't be made from those sticker types).

=cut

# ----------------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
use Math::Combinatorics;
$"=', ';

# ----------------------------------------------------------------------------------------------------------------------
# SUBROUTINES:
sub is_in_list ($item, $list) {
   for (@$list) {$item eq $_ and return 1;}
   return 0;
}

sub remove_from_list ($item, $list) {
   for ( my $i = 0 ; $i <= $#$list ; ++$i ) {
      if ($$list[$i] eq $item) {
         splice @$list, $i, 1;
         return;
      }
   }
}

sub cant_make($word, $stickers) {
   my $stck  = join '', @$stickers;
   my @wordfc = sort split //, fc $word =~ s/\PL//gr;
   my @stckfc = sort split //, fc $stck =~ s/\PL//gr;
   for (@wordfc) {
      if (!is_in_list($_, \@stckfc)) {
         return 1;
      }
   }
   return 0;
}

sub can_make($word, $stickers) {
   my $stck  = join '', @$stickers;
   my @wordfc = sort split //, fc $word =~ s/\PL//gr;
   my @stckfc = sort split //, fc $stck =~ s/\PL//gr;
   for (@wordfc) {
      if (     is_in_list($_, \@stckfc)) {
         remove_from_list($_, \@stckfc);
      }
      else {
         return 0;
      }
   }
   return 1;
}

sub number_of_stickers_needed($word, $stickers) {
   # If any of the letters of $word are simply NOT IN any of the types
   # of stickers we have available to us, then return 0, indicating that
   # "this simply can't be done":
   if ( cant_make($word, $stickers) ) {
      return 0;
   }
   # Otherwise, we know that this word CAN be made from these sticker types,
   # though it may take multiple copies of some of the sticker types, up to
   # a maximum of the number of letters in the word (eg, given word "ddddd"
   # and stickers ('dog', 'cat', 'pig'), it will take 5 copies of 'dog').
   my $num_lttrs = length($word);
   my @multiple;
   for ( my $j = 1 ; $j <= $num_lttrs ; ++$j ) {
      push @multiple, @$stickers;
      my $num_stick = scalar(@multiple);
      for ( my $i = 1 ; $i <= $num_stick ; ++$i ) {
         my $combs = Math::Combinatorics->new(count => $i, data => [@multiple]);
         while ( my @comb = $combs->next_combination ) {
            can_make($word, \@comb) and return $i;
         }
      }
   }
   return 0;
}

# ----------------------------------------------------------------------------------------------------------------------
# DEFAULT INPUTS:
my @arrays =
(
   [ 'perl', 'raku',    'python', 'peon'          ],
   [ 'love', 'hate',    'angry',  'goat'          ],
   [ 'come', 'nation',  'delta',  'accommodation' ],
   [ 'come', 'country', 'delta',  'accommodation' ],
);

# ----------------------------------------------------------------------------------------------------------------------
# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# ----------------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
{ # begin main
   my $t0 = time;
   for my $aref (@arrays) {
      my @stickers   = @{$aref};
      my $word       = pop @stickers;
      my $num_stckrs = number_of_stickers_needed($word, \@stickers);
      say '';
      say "word to make     = $word";
      say "list of stickers = (@stickers)";
      say "stickers needed  = $num_stckrs";
   }
   my $µs = 1000000 * (time - $t0);
   printf("\nExecution time was %.3fµs.\n", $µs);
   exit 0;
} # end main
