#!/usr/bin/perl
use strict;
use warnings;

sub changing_keys {

   # Shift and Caps lock won't be counted. So convert the
   # input to lowercase to make it case-insensitive
   my $input = lc($_[0]);

   # tr has a nice squeeze option!
   # let's squeeze consecutive identical characters
   $input =~ tr/a-z/a-z/s;

   # The number of key changes is simply the number of characters
   # in the squeezed string minus 1 (initial key press)
   my $key_changes = length($input) - 1;

}

# Tests

my $str;

# Example 1
$str = 'pPeERrLl';
print( changing_keys($str), "\n" );  # Output: 3

# Example 2
$str = 'rRr';
print( changing_keys($str), "\n" );  # Output: 0

# Example 3
$str = 'GoO';
print( changing_keys($str), "\n" );  # Output: 1
