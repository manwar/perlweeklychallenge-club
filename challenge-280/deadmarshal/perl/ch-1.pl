#!usr/bin/env perl
use strict;
use warnings;

sub twice_appearance{
  reverse($_[0]) =~ /.*(.).*?\1/
}

printf "%s\n",twice_appearance('acbddbca');
printf "%s\n",twice_appearance('abccd');
printf "%s\n",twice_appearance('abcdabbb');

