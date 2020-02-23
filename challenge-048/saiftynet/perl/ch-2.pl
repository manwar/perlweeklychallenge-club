#!/usr/env/perl
# Task 2 Challenge 048 Solution by saiftynet
# 
# Palindrome Dates
# 
# Write a script to print all Palindrome Dates between 2000 and 2999. The 
# format of date is mmddyyyy. For example, the first one was on October 2, 
# 2001 as it is represented as 10022001.

# With Palindromic dates, the year contains the digits of the month
# and date, so can be easiy derived from the year using substr.
# The MMDDYYY format is a requirement of the task, but is probably the
# most illogical date format (and therefore naturally favoured by
# Americans).
# DDMMYYY (the most common worldwide) and YYYYMMDD (ISO 8601, the most
# logical and least ambiguous format) also can produce different
# palindromic dates. This script can yield these formats too.

# There are many better ways of getting valid dates via modules.
# Much more interesting to roll-your-own, so didn't use them.


# Changing this string will show palindromes in other formats
# valid formats are MDY, DMY and YMD.  The format can also be
# passed from the command line using e.g. perl ch-2.pl DMY

my $format = $ARGV[0] // "MDY";  # valid strings "MDY", "DMY" and "YMD".
die 'Invalid string, must be "MDY", "DMY" or "YMD"' if $format !~/^MDY|DMY|YMD\b/;

foreach my $yyyy (2000..2999){
   my $mm   =  reverse substr($yyyy,2,2);
   my $dd   =  reverse substr($yyyy,0,2);
   
   ($mm,$dd)=($dd,$mm) if $format eq "DMY";    # Swap if DDMMYYY required
   
   next if ($mm >12 or $mm ==0);               # Discard invalid months
   if ($mm =~/02/){                            # February is special case
       $notLeapYear=($y % 4)||(!($y%100)&&($y%400));
       my $FebDays=(28+($notLeapYear?0:1))."";
       next if ($dd gt $FebDays or $dd eq "00")
   }
   elsif ($mm=~/^01|03|05|07|08|10|12/){       # months with 31 days
       next if ($dd gt "31"     or $dd eq "00");
   } 
   else{                                       # all the rest have 30 days
       next if ($dd gt "30"     or $dd eq "00");
   
  }
  
   print "M $mm, D $dd, Y $yyyy :  $mm$dd$yyyy \n" if $format eq "MDY";
   print "D $dd, M $mm, Y $yyyy :  $dd$mm$yyyy \n" if $format eq "DMY";
   print "Y $yyyy, M $mm, D $dd :  $yyyy$mm$dd \n" if $format eq "YMD";   
}
