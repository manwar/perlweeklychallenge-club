
  use v5.40;
  
  sub day_of_year {
      my ($date) = @_;
      my $day_of_year = 0;
      my ($year, $month, $day) = split /-/, $date;
      
  my $is_leap_year = ($year % 400 == 0) || ($year % 4 == 0 && $year % 100 != 0);
  my $february_days = $is_leap_year ? 29 : 28;

      my @days_in_month = (31, $february_days, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
      $day_of_year += $days_in_month[$_] for (0 .. $month - 2);
      $day_of_year += $day;
      return $day_of_year;
  }

  
MAIN:{
    say day_of_year q/2025-02-02/;
    say day_of_year q/2025-04-10/;
    say day_of_year q/2025-09-07/;
} 

