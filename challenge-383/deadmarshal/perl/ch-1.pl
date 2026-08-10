#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub similar_list{
  return 0 unless @{$_[0]} == @{$_[1]};
 OUTER:
  foreach my $i(0..$#{$_[0]}){
    next OUTER if $_[0]->[$i] eq $_[1]->[$i];
    foreach my $sub(@{$_[2]}){
      next OUTER if in($_[0]->[$i],$sub) &&
	in($_[1]->[$i],$sub)
      }
    return 0
  }
  1
}

sub in{
  my ($e,$l) = @_;
  grep {$_ eq $e} @$l
}

is similar_list(['great','acting'],
		['fine','drama'],
		[['great','fine'],
		 ['acting','drama']]),1,'Example 1';
is similar_list(['apple','pie'],
		['banana','pie'],
		[['apple','peach'],
		 ['peach','banana']]),0,'Example 2';
is similar_list(['perl4','python'],
		['raku','python'],
		[['perl4','perl5','raku']]),1,'Example 3';
is similar_list(['enjoy','challenge'],
		['love', 'weekly', 'challenge'],
		[['enjoy','love']]),0,'Example 4';
is similar_list(['fast','car'],
		['quick','vehicle'],
		[['quick','fast'],['vehicle','car']]),1,'Example 5';
done_testing();

