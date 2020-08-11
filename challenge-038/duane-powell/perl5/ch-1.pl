#!/usr/bin/perl
use warnings;
use strict;
use Date::Calc qw(check_date);
use feature 'say';

# Create a script to accept a 7 digits number, where the first number can only be 1 or 2. 
# The second and third digits can be anything 0-9. The fourth and fifth digits corresponds to the month 
# i.e. 01,02,03,11,12. And the last 2 digits respresents the days in the month i.e. 01,02,03.29,30,31. 
# Your script should validate if the given number is valid as per the rule and then convert into human readable format date.

my $input = shift;
$input ||= 2230120;

usage("Input must be exactly 7 digits\n") unless ($input =~ m/^\d\d\d\d\d\d\d$/);

# check input for any errors, ie numbers outside legal ranges
my $error;
my ($d1,$d2,$d3,$d4,$d5,$d6,$d7) = split(//,$input);
$error .= "First digits must be 1 or 2\n" unless $d1 =~ m/1|2/;
my $month = "$d4$d5";
$error .= "Digits four and five must be a valid month 01..12\n" unless ($month >= 01 and $month <= 12);
my $day = "$d6$d7";
$error .= "Digits six and seven must be a valid calendar day 01..31\n" unless ($day >= 01 and $day <= 31);
usage($error) if ($error);

my $year = ($d1 == 1) ? "19" : "20";
$year = $year . $d2 . $d3;

# if we made it here, ranges are legit, so check if date is valid, eg Feb 29th on non-leap year or 31 days in month with only 30 
if (check_date($year,$month,$day)) {
	say "$year-$month-$day";
}
else {
	say "Date $year-$month-$day is invalid";
}
exit;

sub usage {
	my $message = shift;
        print <<EOU;

$message
Usage:
$0 seven-digits

$0 1|2 00-99 01-12 01-31
for example $0 2230120
EOU
        exit;
}

__END__

./ch-1.pl 2231130
2023-11-30


./ch-1.pl 2231131
Date 2023-11-31 is invalid


./ch-1.pl 223113

Input must be exactly 7 digits

Usage:
./ch-1.pl seven-digits

./ch-1.pl 1|2 00-99 01-12 01-31
for example ./ch-1.pl 2230120


/ch-1.pl 1234567

Digits four and five must be a valid month 01..12
Digits six and seven must be a valid calendar day 01..31

Usage:
./ch-1.pl seven-digits

./ch-1.pl 1|2 00-99 01-12 01-31
for example ./ch-1.pl 2230120

