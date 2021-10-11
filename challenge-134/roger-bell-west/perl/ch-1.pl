#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(pandigital(10),[1023456789, 1023456798, 1023456879, 1023456897, 1023456978, 1023456987, 1023457689, 1023457698, 1023457869, 1023457896],'example 1');

use Algorithm::Permute;

sub pandigital {
  my $count=shift;
  my $digits=1;
  my $cc=1;
  while ($cc<$count) {
    $digits++;
    $cc*=$digits;
    if ($digits > 10) {
      die "too large\n";
    }
  }
  my @template=(reverse (1,0,2..9));
  my @o;
  my @lead=reverse splice @template,$digits;
  my $p=Algorithm::Permute->new(\@template);
  while (my @r=$p->next) {
    push @o,join('',@r);
  }
  @o=sort @o;
  splice @o,$count;
  my $l=join('',@lead);
  @o=map {"$l$_"} @o;
  return \@o;
}
