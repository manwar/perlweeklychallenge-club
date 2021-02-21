#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a time (12 hour / 24 hour). Write a script to convert the given time from 12 hour format to 24 hour format and vice versa. Ideally we expect a one-liner.
Example 1: Input: 05:15 pm or 05:15pm Output: 17:15
Example 2: Input: 19:15 Output: 07:15 pm or 07:15pm
=cut









use Test::More;

sub fun_time
{
     my $time_string = $_[0];
     my $time_re = qr/([0-9]{2}):([0-9]{2}) ?([a|p]m)?/;
     my ($hour, $min, $format) = $time_string =~ /$time_re/;

     $format //='';

     
     if ( length($format) ) # 'am/pm'
     {
          if ( $format eq 'am' )
          {
               return $hour == 12 ? "00:${min}" : "${hour}:${min}";
          }
          else # pm
          {
               $hour = ($hour < 12) ? $hour += 12 : $hour;


               return "${hour}:${min}";
          }
     }

     else # ISO
     {
          if ( $hour eq '00' ) { return "12:${min} am"; }
          elsif ( $hour == 12 ) {return "${hour}:${min} pm";}

          elsif ($hour > 12 ) 
          { 
               $hour = sprintf("%02d", $hour - 12);
               return "${hour}:${min} pm";
          }
          else { return "${hour}:${min} am"; }
     }
}


# https://en.wikipedia.org/wiki/12-hour_clock 
is(fun_time(q(12:00 am)), q(00:00), q(Midnight No.1));
is(fun_time(q(00:00)), q(12:00 am), q(Midnight No.2));
is(fun_time(q(01:00 am)), q(01:00), q(01:00 No.1));
is(fun_time(q(01:00)), q(01:00 am), q(01:00 No.2));
is(fun_time(q(11:59 am)), q(11:59), q(11:59 No.1));
is(fun_time(q(11:59)), q(11:59 am), q(11:59 No.2));

is(fun_time(q(12:00 pm)), q(12:00), q(Midday 1));
is(fun_time(q(12:00)), q(12:00 pm), q(Midday 2));
is(fun_time(q(01:00 pm)), q(13:00), q(13:00 No.1));
is(fun_time(q(13:00)), q(01:00 pm), q(13:00 No.2));
is(fun_time(q(11:59 pm)), q(23:59), q(23:59 No.1));
is(fun_time(q(23:59)), q(11:59 pm), q(23:59 No.2));
done_testing();