#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a phone number as a string containing digits, space and dash only.

Write a script to format the given phone number using the below rules:

1. Removing all spaces and dashes
2. Grouping digits into blocks of length 3 from left to right
3. Handling the final digits (4 or fewer) specially:
   - 2 digits: one block of length 2
   - 3 digits: one block of length 3
   - 4 digits: two blocks of length 2
4. Joining all blocks with dashes


Example 1

Input: $phone = "1-23-45-6"
Output: "123-456"


Example 2

Input: $phone = "1234"
Output: "12-34"


Example 3

Input: $phone = "12 345-6789"
Output: "123-456-789"


Example 4

Input: $phone = "123 4567"
Output: "123-45-67"


Example 5

Input: $phone = "123 456-78"
Output: "123-456-78"
=cut


use Test2::V0 -no_srand => 1;
is(format_phone_number("1-23-45-6"), '123-456', 'Example 1');
is(format_phone_number("1234"), '12-34', 'Example 2');
is(format_phone_number("12 345-6789"), '123-456-789', 'Example 3');
is(format_phone_number("123 4567"), '123-45-67', 'Example 4');
is(format_phone_number("123 456-78"), '123-456-78', 'Example 5');
done_testing();


sub format_phone_number
{
     my $phone = $_[0];
     $phone =~ tr/- //ds;

     $phone =~ s/(\d{3})(?=\d{2,4})/$1-/g;
     my @arr = split(/\-/, $phone);
     my $tail = pop @arr;

     $tail = length($tail) < 4 ? $tail : 
          join('-', substr($tail, 0, 2), substr($tail, 2)); 
     push @arr, $tail;
     return join('-', @arr);
}
