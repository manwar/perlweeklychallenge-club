#!/usr/bin/perl
use strict;
use warnings;
use Statistics::Frequency;

=begin
In this task, you need to answer two questions:
1. Does each letter of the given string ($given_str) occur in an element ($element) of the word array (@str)?
2. Is the frequency of a letter in the given string ($given_str) Less Than or Equal To the frequency in an element ($element) of the word array (@str)?

To put it another way:

if( (index($element, $char_given_str) == -1) || $f1->frequency($char_given_str) > $f2->frequency($char_given_str)) -> no success

where $f1 refers to $given_str and $f2 to an element of @str
=cut

sub completing_word {

  my($given_str, @str) = @_;

  my @result = ();

# get characters [a-z] from the given string
  my @given_str_chars = grep( /[a-z]/, (split //, lc($given_str)) );
# create a new Statistics::Frequency object to invoke later the 'frequency' method
  my $f1 = Statistics::Frequency->new(@given_str_chars);

# extract all unique characters from $given_str to avoid duplicate results
  my $unique_chars_given_str = join ("", @given_str_chars);
  $unique_chars_given_str =~ tr/a-z//s;

# evaluate each element in word array @str by an INNER loop
  OUTER: foreach my $element (@str) {

# create a new Statistics::Frequency object to invoke later the 'frequency' method
       my $f2 = Statistics::Frequency->new( (split //, $element) );

       my $success = 0;
       INNER: foreach my $char ((split //, $unique_chars_given_str)) {

           if( (index($element, $char) == -1) || $f1->frequency($char) > $f2->frequency($char)) {
             $success = 0;
# terminate loop INNER and investigate next element (if exists)
             last INNER;
           }
           $success++;
       }
       push(@result, $element) if($success);
  }

# if there is more than one string that satisfies the condition
  if(scalar @result > 1) {
      my @result_sorted = sort( { length($a) <=> length($b) } @result );
# print the smallest array element
      print("Result: $result_sorted[0]\n");
  }
  else {
      print("Result: @result\n");
  }

}

# TESTS

my($given_str, @str);

# Example 1
$given_str = 'aBc 11c';
@str = ('accbbb', 'abc', 'abbc');
completing_word($given_str, @str); # accbbb

# Example 2
$given_str = 'Da2 abc';
@str = ('abcm', 'baacd', 'abaadc');
completing_word($given_str, @str); # baacd

# Example 3
$given_str = 'JB 007';
@str = ('jj', 'bb', 'bjb');
completing_word($given_str, @str); # bjb

# Example 4
$given_str = 'JB 007';
@str = ('jz', 'bb', 'bjb');
completing_word($given_str, @str); # bjb
