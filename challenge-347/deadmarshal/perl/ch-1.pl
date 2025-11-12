#!/usr/bin/env perl
use strict;
use warnings;

sub format_date{
  my @s = split ' ',$_[0];
  my $months = "JanFebMarAprMayJunJulAugSepOctNovDec";
  my $day = substr $s[0],0,length($s[0]) - 2;
  my $month = index($months,$s[1]) / 3 + 1;
  sprintf "%s-%02d-%02d",$s[2],$month,$day
}

printf "%s\n",format_date("1st Jan 2025");
printf "%s\n",format_date("22nd Feb 2025");
printf "%s\n",format_date("15th Apr 2025");
printf "%s\n",format_date("23rd Oct 2025");
printf "%s\n",format_date("31st Dec 2025");

