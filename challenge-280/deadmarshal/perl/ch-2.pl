#!usr/bin/env perl
use strict;
use warnings;

sub count_asterisks{
  my $str = $_[0] =~ s/\|[^\|]*\|//gmixr;
  $_ = () = $str =~ /(\*)/gmix;
}

printf "%d\n",count_asterisks('p|*e*rl|w**e|*ekly|');
printf "%d\n",count_asterisks('perl');
printf "%d\n",count_asterisks('th|ewe|e**|k|l***ych|alleng|e');

