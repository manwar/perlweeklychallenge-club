#https://theweeklychallenge.org/blog/perl-weekly-challenge-237/
use strict; use warnings;

sub the_day {
  my($year, $month, $weekday_of_month, $day_of_week) = @_;
  my $want_month = $year*100+$month;
  my $test_day = ($year-1970)*365+($month-1)*28;   #choose a conservative enough start day
  while(1) {                                       #Don't Stop 'Til You Get Enough
    my @lt = gmtime $test_day++ * 24 * 3600;       #get time elems for test_day num, increase test_day
    my($se, $mi, $ho, $mday, $m, $y, $dow) = @lt;  #y=0 for 1900, m=0 for January
    my $test_month = 190001+$y*100+$m;             #i.e. 202309 for Sep 2023, 
    return 0     if  $test_month >  $want_month;   #the wanted month is now passed without a find
    return $mday if  $test_month == $want_month    #same year and month
                 and $day_of_week%7 == $dow        #same weekday, Sun=7=0
	         and --$weekday_of_month == 0      #the wanted count
  }
}

my @tests = (
  '{Year => 2024, Month => 4,  Weekday_of_month => 3, Day_of_week => 2}' => 16, #The 3rd Tue_of_Apr 2024 is the 16th
  '{Year => 2025, Month => 10, Weekday_of_month => 2, Day_of_week => 4}' => 9,  #The 2nd Thu_of_Oct 2025 is the 9th
  '{Year => 2026, Month => 8,  Weekday_of_month => 5, Day_of_week => 3}' => 0,  #There isn't a 5th Wed in Aug 2026
  '{Year => 1970, Month => 1,  Weekday_of_month => 4, Day_of_week => 7}' => 25, #25th was 4th Sun in Jan 1970
  '{Year => 1970, Month => 1,  Weekday_of_month => 5, Day_of_week => 5}' => 30, #30th was 5th Fri in Jan 1970
);

while(@tests){
  my($data, $expected) = splice@tests,0,2;
  my $got = the_day( @{eval$data}{qw(Year Month Weekday_of_month Day_of_week)} );
  print $got  == $expected ? 'ok' : '***NOT OK';
  print "    data: $data    expected: $expected    got: $got\n";
}
