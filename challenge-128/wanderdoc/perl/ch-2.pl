#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two arrays of arrival and departure times of trains at a railway station. Write a script to find out the minimum number of platforms needed so that no train needs to wait.
Example 1:
Input: @arrivals   = (11:20, 14:30)
       @departutes = (11:50, 15:00)
Output: 1
    The 1st arrival of train is at 11:20 and this is the only train at the station, so you need 1 platform.
    Before the second arrival at 14:30, the first train left the station at 11:50, so you still need only 1 platform.

Example 2:
Input: @arrivals   = (10:20, 11:00, 11:10, 12:20, 16:20, 19:00)
       @departutes = (10:30, 13:20, 12:40, 12:50, 20:20, 21:20)
Output: 3
    Between 11:00 and 12:20, there would be at least 3 trains at the station, so we need minimum 3 platforms.
=cut

use Time::Piece;
use Time::Seconds;

use List::MoreUtils qw(pairwise);
use List::Util qw(min max);

sub platforms
{
     my ($arr, $dep) = @_;
     my $max = 0;
     my $min = ONE_DAY;

     for ($arr, $dep)
     {
          @$_ = map { 
               my $t1 = Time::Piece->strptime($_, "%H:%M"); 
               $t1->epoch;} @$_;
     }


     my @pairs = pairwise { $a > $b ? [$a, $b + ONE_DAY] : [$a, $b] } 
               @$arr, @$dep; 
     for my $pair ( @pairs )
     {
          $min = min($min, @$pair);
          $max = max($max, @$pair);
     }


     my %platforms; 
     my %output;
     for my $ts ( $min .. $max )
     {
          for my $pair ( @pairs )
          {
               next if ($ts < $pair->[0] or $ts > $pair->[1]);
               push @{$output{ ++$platforms{$ts} }}, $ts;

          }
     }
     print "1 platform is enough.$/" if max(keys %output == 1);
     for my $platform ( grep $_ > 1, sort {$b <=> $a} keys %output) 
     {
          my @intervals = _num2arr( @{$output{$platform}});
          print "At least ${platform} platforms at", ': ';
          print join(', ',map join(' - ', map _sec2hm($_), $_->[0], $_->[1]), @intervals), $/;

     }
}

print "Example 1 (modified):$/";
my @arrivals   = qw (11:20 14:30 14:59);
my @departutes = qw (11:50 15:00 00:01);
platforms(\@arrivals, \@departutes);


print "Example 2:$/";
@arrivals   = qw(10:20 11:00 11:10 12:20 16:20 19:00);
@departutes = qw(10:30 13:20 12:40 12:50 20:20 21:20);
platforms(\@arrivals, \@departutes);





sub _num2arr
{
     my @numbers = sort { $a <=> $b} @_;
     my @output;
     my $previous = $numbers[0];
     my $from = my $to = $previous;
     my $last;


     for my $num ( @numbers[1 .. $#numbers] )
     {
          if ( 1 >= ($num - $previous) )
          {
               $previous = $num;
          }
          else
          {


               my $to = $previous;
               push @output, [$from, $to];
               $previous = $num;
               $from = $to = $previous;
          }
          $last = $num;
     }
     push @output, [$from, $last];

     return @output;
}


sub _sec2hm
{
     my $seconds = $_[0];
     $seconds -= ONE_DAY if $seconds > ONE_DAY;
     return join(':',
          sprintf("%02d",int($seconds / ONE_HOUR)),
          sprintf("%02d",int(($seconds % ONE_HOUR) / ONE_MINUTE)));
}