#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub dyck_words{
  my ($n) = @_;
  return [''] if $n == 0;
  my @res;
  my @stack = [0,0,''];
  while(@stack){
    my $state = pop @stack;
    my ($o,$c,$curr) = @$state;
    if($o == $n && $c == $n) {
      push @res,$curr;
      next
    }
    push @stack,[$o+1,$c,$curr . 'U'] if $o < $n;
    push @stack,[$o,$c+1,$curr . 'D'] if $c < $n && $o > $c;
  }
  @res = sort @res;
  \@res
}

is_deeply dyck_words(1),['UD'],'Example 1';
is_deeply dyck_words(2),['UDUD','UUDD'],'Example 2';
is_deeply dyck_words(3),['UDUDUD','UDUUDD','UUDDUD','UUDUDD',
			 'UUUDDD'],'Example 3';
is_deeply dyck_words(0),[''],'Example 4';
is_deeply dyck_words(4),['UDUDUDUD','UDUDUUDD','UDUUDDUD',
			 'UDUUDUDD','UDUUUDDD','UUDDUDUD',
			 'UUDDUUDD','UUDUDDUD','UUDUDUDD',
			 'UUDUUDDD','UUUDDDUD','UUUDDUDD',
			 'UUUDUDDD','UUUUDDDD'],'Example 5';

done_testing();

