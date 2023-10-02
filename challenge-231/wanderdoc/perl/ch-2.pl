#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of passenger details in the form "9999999999A1122", where 9 denotes the phone number, A the sex, 1 the age and 2 the seat number. Write a script to return the count of all senior citizens (age >= 60).
Example 1 Input: @list = ("7868190130M7522","5303914400F9211","9273338290F4010") Output: 2
The age of the passengers in the given list are 75, 92 and 40.
So we have only 2 senior citizens.
Example 2 Input: @list = ("1313579440F2036","2921522980M5644") Output: 0
=cut







use Test2::V0;

sub count_by_age
{
     my $boundary = shift;
     my @tickets = @_;
     my $count = 0;
     for my $elm ( @tickets )
     {
          my ($phone, $sex, $age, $seat) = unpack("A10A1A2A2", $elm);
          $count++ if ( $age >= $boundary );
     }
     return $count;
}


is(count_by_age(60, ("7868190130M7522","5303914400F9211","9273338290F4010")), 2, 'Example 1');
is(count_by_age(60, ("1313579440F2036","2921522980M5644")), 0, 'Example 2');
done_testing();