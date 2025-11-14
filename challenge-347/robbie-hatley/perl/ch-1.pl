#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 347-1,
written by Robbie Hatley on Tue Nov 11, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 347-1: Format Date
Submitted by: Mohammad Sajid Anwar
You are given a date in the form: 10th Nov 2025. Write a script
to format the given date in the form: 2025-11-10 using the set
below:
@DAYS   = ("1st", "2nd", "3rd", ....., "30th", "31st")
@MONTHS = ("Jan", "Feb", "Mar", ....., "Nov",  "Dec")
@YEARS  = (1900..2100)

Example #1:
Input:  "1st Jan 2025"
Output: "2025-01-01"

Example #2:
Input:  "22nd Feb 2025"
Output: "2025-02-22"

Example #3:
Input:  "15th Apr 2025"
Output: "2025-04-15"

Example #4:
Input:  "23rd Oct 2025"
Output: "2025-10-23"

Example #5:
Input:  "31st Dec 2025"
Output: "2025-12-31"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I use a "month map" to map month names back to numbers.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '("37th Jan 2027", "18th Aug 2456")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Convert date format:
   sub format_date ( $s ) {
      my ($d1, $m1, $y) = split /\s+/, $s;
      my $d2 = $d1 =~ s/\D+//gr;
      if (length($d2) < 2) {$d2='0'.$d2}
      my %mth_map =
      ('Jan' => '01', 'Feb' => '02', 'Mar' => '03',
       'Apr' => '04', 'May' => '05', 'Jun' => '06',
       'Jul' => '07', 'Aug' => '08', 'Sep' => '09',
       'Oct' => '10', 'Nov' =>,'11', 'Dec' => '12');
      my $m2 = $mth_map{$m1};
      $y.'-'.$m2.'-'.$d2}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @dates =  @ARGV ? eval($ARGV[0])
                   : ('1st Jan 2025', '22nd Feb 2025', '15th Apr 2025', '23rd Oct 2025', '31st Dec 2025');
# Expected outputs :  '2025-01-01'    '2025-02-22'     '2025-04-15'     '2025-10-23'     '2025-12-31'

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $d1 (@dates) {
   say '';
   say "Long  date = $d1";
   my $d2 = format_date $d1;
   say "Short date = $d2";
}
