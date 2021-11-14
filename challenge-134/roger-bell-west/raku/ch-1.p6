#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(pandigital(10),[1023456789, 1023456798, 1023456879, 1023456897, 1023456978, 1023456987, 1023457689, 1023457698, 1023457869, 1023457896],'example 1');

sub pandigital($count) {
  my $digits=1;
  my $cc=1;
  while ($cc < $count) {
    $digits++;
    $cc*=$digits;
    if ($digits > 10) {
      die "too large\n";
    }
  }
  my @template=reverse (1,0,2,3,4,5,6,7,8,9);
  my @o;
  my @lead=reverse splice @template,$digits;
  for @template.permutations -> @r {
    push @o,join('',@r);
  }
  @o=sort @o;
  splice @o,$count;
  my $l=join('',@lead);
  @o=map {"$l$_"+0},@o;
  return @o;
}
