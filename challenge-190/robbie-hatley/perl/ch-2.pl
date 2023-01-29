#! /usr/bin/env perl

# PWCC_190_P2_Decoded-List_Robbie-Hatley.pl

=pod

You are given an encoded string consisting of a sequence of
numeric characters (/[0-9]+/). Encoding is simply done by mapping
A,B,C,D,... to 1,2,3,4,... etc. Write a script to find the all
valid different decodings in sorted order.

=cut

# NOTE: Input is via built-in-array (default) or CLI. If using CLI,
#       input should be space-separated sequence of unquoted positive
#       integers (/^[1-9][0-9]*$/).

# NOTE: Output will be to stdout and will consist of a sorted List
#       of all possible decodings using partitions of each
#       digit cluster into numbers.

use v5.36;

sub is_positive_integer ($s)
{
   $s =~ m/^[1-9][0-9]*$/ and return 1
   or return 0;
}

sub are_all_positive_integers_1_26 (@a)
{
   for (@a)
   {
      return 0 unless is_positive_integer $_ && $_ >=  1 && $_ <= 26;
   }
   return 1;
}

# Return an array of refs to arrays of all possible partitionings
# of a string into substrings:
sub string_partitions ($string)
{
   my @partitions;
   my $size = length($string);
   if ( 0 == $size )
   {
      @partitions = ([]);
   }
   else
   {
      my ($first, $second);
      for ( my $part = 1 ; $part <= $size ; ++$part )
      {
         $first  = substr($string, 0,     $part        );
         $second = substr($string, $part, $size - $part);
         my @partials = string_partitions($second);
         for (@partials) {unshift @$_, $first;}
         push @partitions, @partials;
      }
   }
   return @partitions;
}

# Decode an array of positives integers, 1-26, into a text string:
sub decode (@a)
{
   return 'DecodeError' unless are_all_positive_integers_1_26(@a);
   my $s = ''; # output string
   foreach my $o (@a){$s.=chr(64+$o);}
   return $s;
}

# Default input:
my @array = qw( 11 1115 127 );

# Non-Default input:
if (scalar(@ARGV)>0) {@array = @ARGV}

# Set-up output to be ', '-separated:
$,=', ';

foreach my $s (@array)
{
   not is_positive_integer $s              # If an input is invalid,
   and say "$s is not a positive integer"  # alert user
   and next;                               # and skip that input.
   my @d = string_partitions($s);          # Array of refs to arrays of all possible partitionings of $s (HARD!!!).
   my $e;                                  # One possible decoding  of $s
   my @e;                                  # Array of all decodings of $s
   for my $ar (@d)
   {                                       # For each partitioning of $s,
      $e = decode(@$ar);                   # get the corresponding decoding,
      push(@e,$e)                          # and push it onto @e,
      unless $e eq 'DecodeError';          # unless a decode error occurred.
   }
   say sort @e; # Print sorted list of valid decodings.
}
