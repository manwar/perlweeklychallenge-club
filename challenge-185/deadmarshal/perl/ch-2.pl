#!/usr/bin/env perl
use strict;
use warnings;

sub mask_code{
  my ($arr) = @_;
  my $j = 0;
  for(my $i = 0; $i < @$arr; ++$i){
    $arr->[$i] = join '', map{$j < 4 && ($j += s/[a-z0-9]/x/); $_}
      split '', $arr->[$i];
    $j = 0;
  }
  return wantarray ? @$arr : $arr;
}

my @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy');
my @list2 = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f');
print "$_ " foreach mask_code(\@list);
print "\n";
print "$_ " foreach mask_code(\@list2);

