#! /usr/bin/perl
# pwc-183b-date-difference-rh.pl
use v5.32;
use experimental 'switch';

sub is_leap_year       ($);
sub days_per_month     ($$);
sub print_elapsed_time ($$$$$$);
sub help               ();

{ # begin main
   if ("-h" eq $ARGV[0] || "--help" eq $ARGV[0]) {help;exit;}
   my $s1=$ARGV[0];
   my $y1=0+substr($s1,0,4);
   my $m1=0+substr($s1,5,2);
   my $d1=0+substr($s1,8,2);
   my $s2=$ARGV[1];
   my $y2=0+substr($s2,0,4);
   my $m2=0+substr($s2,5,2);
   my $d2=0+substr($s2,8,2);

   if ($y1<1 || $y1>9999)
   {
      say("Error: Invalid first year.");
      help;
      exit;
   }
   if ($y2<1 || $y2>9999)
   {
      say("Error: Invalid second year.");
      help;
      exit;
   }
   if ($m1<1 || $m1>12)
   {
      say("Error: Invalid first month.");
      help;
      exit;
   }
   if ($m2<1 || $m2>12)
   {
      say("Error: Invalid second month.");
      help;
      exit;
   }
   if ($d1<1 || $d1>days_per_month($y1,$m1))
   {
      say("Error: Invalid first day.");
      help;
      exit;
   }
   if ($d2<1 || $d2>days_per_month($y2,$m2))
   {
      say("Error: Invalid second day.");
      help;
      exit;
   }
   if ($s1 gt $s2)
   {
      say("Error: Date1 must not be earlier than Date2.");
      help;
      exit;
   }
   print_elapsed_time($y1,$m1,$d1,$y2,$m2,$d2);
   exit;
} # end main

sub is_leap_year ($)
{
   my $Year   = shift;
   if    ( 0 == $Year%4 && 0 != $Year%100 ) {return 1;}
   elsif ( 0 == $Year%400                 ) {return 1;}
   else                                     {return 0;}
} # end sub is_leap_year

sub days_per_month ($$)
{
   my $Year   = shift;
   my $Month  = shift;
   given ($Month)
   {
      when ( 1) {return 31;}
      when ( 2) {return is_leap_year($Year) ? 29 : 28;}
      when ( 3) {return 31;}
      when ( 4) {return 30;}
      when ( 5) {return 31;}
      when ( 6) {return 30;}
      when ( 7) {return 31;}
      when ( 8) {return 31;}
      when ( 9) {return 30;}
      when (10) {return 31;}
      when (11) {return 30;}
      when (12) {return 31;}
      default   {die "Illegal month.";}
   }
} # end sub days_per_month

sub print_elapsed_time ($$$$$$)
{
   my ($y1,$m1,$d1,$y2,$m2,$d2)=@_;
   my $years    = 0;
   my $days     = 0;
   if ( $y1 < $y2 )                                # y2 is after y1
   {
      if ( $m1 < $m2 )                             # y2/m1 is before y2/m2
      {
         $years = $y2 - $y1;
         $days += days_per_month($y2,$m1) - $d1;   # add-in days from m1 in y2
         for ( my $m = $m1 + 1 ; $m < $m2 ; ++$m )
         {
            $days += days_per_month($y2,$m);       # add-in days from intervening months of y2
         }
         $days += $d2;                             # add-in days from m2 in y2
      }
      elsif ( $m1 == $m2 && $d1 <= $d2 )           # m1==m2 && y2/m1/d1 is on-or-before y2/m2/d2
      {
         $years = $y2 - $y1;
         $days += $d2 - $d1;
      }
      else                                         # y2/m1/d1 is after y2/m2/d2
      {
         $years = $y2 - $y1 - 1;
         $days += days_per_month($y2-1,$m1)-$d1;   # add-in days from m1 in y2-1
         for ( my $m = $m1+1 ; $m <= 12 ; ++$m )
         {
            $days += days_per_month($y2-1,$m);     # add-in days from remaining months of y2-1
         }
         for ( my $m = 1 ; $m < $m2 ; ++$m )
         {
            $days += days_per_month($y2,$m);       # add-in days from initial months of y2
         }
         $days += $d2;                             # add-in days from m2 in y2
      }
   }
   elsif ( $y2 == $y1 && ( $m1 < $m2 || $m1 == $m2 && $d1 <= $d2 ) ) # same year and y1/m1/d1 is on-or-before y2/m2/d2
   {
      $years=0;
      if ($m1<$m2) # same year, different month
      {
         $days += days_per_month($y1,$m1)-$d1;     # add-in days from initial month
         for ( my $m = $m1+1 ; $m < $m2 ; ++$m )
         {
            $days += days_per_month($y1,$m);       # add-in days from intervening months
         }
         $days += $d2;                             # add-in days from final month
      }
      else # same year and month
      {
         $days = $d2-$d1;
      }
   }
   else # Date1 > Date2
   {
      say "Error in print_elapsed_time: Date1 > Date2.";
      exit(666);
   }
   if($years>0)
   {
      print($years, " year");
      print('s')if($years>1);
      print(' ')if($years>0 && $days>0);
   }
   if ($days > 0 || $years == 0)
   {
      print($days, " day");
      print('s')if($days!=1);
   }
   print("\n");
} # end sub print_elapsed_time ($$$$$$)

sub help ()
{
   print ((<<'   END_OF_HELP') =~ s/^   //gmr);
   To use this program, feed it two command-line arguments, which must be
   dates in the format YYYY-MM-DD, like so:
   
   ./pwc-183b-date-difference-rh.pl 1854-10-07 1972-02-27
   
   The dates must be valid dates from 0001-01-01 to 9999-12-31 Gregorian,
   and the first date must not be earlier than the second date. This program
   will then print the time difference in years and days from the first date
   to second date.
   
   Warning: The Gregorian calendar was not created until Oct 15, 1582,
   and was not adopted in the English-speaking world until Sept 14, 1752,
   so any date calculations before those dates may be off by up to two weeks
   due to the differences between the Julian and Gregorian calendars.
   END_OF_HELP
   return 1;
} # end sub help
