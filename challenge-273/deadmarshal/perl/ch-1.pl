#!/usr/bin/env perl
use strict;
use warnings;
use POSIX qw(round);

sub percentage_of_character{
  my ($str,$char) = @_;
  my $count =()= $str =~ /\Q$char/g;
  round(100 * $count / length $str)
}

printf "%d\n",percentage_of_character('perl','e');
printf "%d\n",percentage_of_character('java','a');
printf "%d\n",percentage_of_character('python','m');
printf "%d\n",percentage_of_character('ada','a');
printf "%d\n",percentage_of_character('ballerina','l');
printf "%d\n",percentage_of_character('analitik','k');

