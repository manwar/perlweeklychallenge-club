#!perl

use strict;
use Time::Local;
use POSIX qw(strftime);

my @Birth=split('/', $ARGV[0]);
my $epoch_birth=timelocal(0, 0, 0, $Birth[2], $Birth[1]-1, $Birth[0]); # seconds between 1970 and birth

my $epoch_today = time(); # (seconds between 1970 and today
if(scalar(@ARGV) > 1)     # assuming today is another day -)
  {
  my @ref_day     = split('/', $ARGV[1]);
  my $h = (scalar(@ARGV) > 2)? $ARGV[2]:0;
  my $m = (scalar(@ARGV) > 3)? $ARGV[3]:0;
  my $s = (scalar(@ARGV) > 4)? $ARGV[4]:0;
  $epoch_today = timelocal($s, $m, $h, $ref_day[2], $ref_day[1]-1, $ref_day[0]); # at 1.30 AM..
  }

my $age=$epoch_today-$epoch_birth; # in seconds
print strftime("%Y/%m/%d, ", localtime($epoch_today - (2*$age)));
print strftime("%Y/%m/%d\n", localtime($epoch_today +    $age));
