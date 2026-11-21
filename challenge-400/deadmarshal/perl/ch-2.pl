#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub minimum_genetic_mutation{
  my ($start,$end,$bank) = @_;
  return 0 if $start eq $end;

  my %valid = map{$_ => 1} @$bank;
  return -1 unless $valid{$end};

  my %seen = ($start => 1);
  my @queue = ([$start,0]);

  while(@queue){
    my ($gene,$steps) = @{shift @queue};
    foreach my $i(0..length($gene)-1){
      foreach my $c(qw(A C G T)){
	next if substr($gene,$i,1) eq $c;

	my $next = $gene;
	substr($next,$i,1) = $c;
	
	next unless $valid{$next};
	next if $seen{$next}++;

	return $steps+1 if $next eq $end;
	push @queue,[$next,$steps+1]
      }
    }
  }
  -1
}

is minimum_genetic_mutation('AACCGGTT',
			    'AACCGGTA',
			    ['AACCGCTA','AAACGGTA']),-1,'Example 1';
is minimum_genetic_mutation('AACCGGTT',
			    'AACCGGAA',
			    ['AACCGGTA','AACCGGAA','AACCGCTA',
			     'AACCCTAA','AACCGTAA']),2,'Example 2';
is minimum_genetic_mutation('AAAAAAAA',
			    'AAAAACCC',
			    ['CAAAAAAA',
			     'CCAAAAAA','AAAAAAAC']),-1,'Example 3';
is minimum_genetic_mutation('GAAAAAAA',
			    'GCCCCCCC',
			    ['GCAAAAAA','GCCAAAAA','GCCCAAAA',
			     'GCCCCAAA','GCCCCCAA',
			     'GCCCCCCA','GCCCCCCC']),7,'Example 4';
is minimum_genetic_mutation('AACCGGTT',
			    'AACCGGTT',['AACCGGTA']),0,'Example 5';

