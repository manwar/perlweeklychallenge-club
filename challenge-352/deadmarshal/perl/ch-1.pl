#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(any);

sub match_string{
  my ($arr) = @_;
  my @res;
  foreach my $i(0..$#$arr) {
    my $x = $arr->[$i];
    foreach my $j(0..$#$arr) {
      my $y = $arr->[$j];
      if($i != $j && index($y,$x) != -1 && !any{$_ eq $x} @res) {
	push @res,$x;
	last
      }
    }
  }
  @res
}

printf "(%s)\n",join ', ',match_string(['cat','cats','dog','dogcat',
				       'dogcat','rat','ratcatdogcat']);
printf "(%s)\n",join ', ',
  match_string(['hello','hell','world','wor','ellow','elloworld']);
printf "(%s)\n",join ', ',
  match_string(['a', 'aa', 'aaa', 'aaaa']);
printf "(%s)\n",join ', ',
  match_string(['flower','flow','flight','fl','fli','ig','ght']);
printf "(%s)\n",join ', ',
  match_string(['car','carpet','carpenter','pet',
		'enter','pen','pent']);

