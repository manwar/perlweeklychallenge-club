#!/usr/bin/env raku
use Test;

#|[Task 2: Senior Citizens
- You are given a list of passenger details in the form “9999999999A1122”, 
  where 9 denotes the phone number, A the sex, 1 the age and 2 the seat number.
- Write a script to return the count of all senior citizens (age >= 60).
]
sub task2(@input) {
	my $age-rx = rx/$<phone-number> = (^\d+) 
					$<sex>          = (<[M F]>) 
					$<age>          = (\d\d) 
					$<seat>         = (\d+$)
					/;
	@input.grep( { $_ ~~ $age-rx; $<age> >= 60 } ).elems;

}
my @testcases = (
  {input => ("7868190130M7522","5303914400F9211","9273338290F4010"), output => 2, description=>"The age of the passengers in the given list are 75, 92 and 40. So we have only 2 senior citizens."},
  {input => ("1313579440F2036","2921522980M5644"),                   output => 0, description=>"all too young"},
);

is task2($_<input>), $_<output>, $_<description> for @testcases;