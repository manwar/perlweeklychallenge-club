#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(variations_with_repetition);
use List::Util qw(mesh);
use Data::Show;

sub magic_expression{
  my ($str,$target) = @_;
  my @ds = split '',$str;
  my $it = variations_with_repetition(['+','-',,'*',''],$#ds);
  my @res;
  while(my $ops = $it->next) {
    my $expr = join '',mesh(\@ds,[@$ops,'']);
    next if $expr =~ /\b0[0-9]/;
    my $eval = $expr =~ s/-/+-/gr;
    $eval =~ s/(\d+)\*(\d+)/$1*$2/ge while $eval =~ /\*/;
    $eval =~ s/(-?\d+)\+(-?\d+)/$1+$2/ge while $eval =~ /\+/;
    push @res,$expr if $eval == $target
  }
  @res
}

show magic_expression("123",6);
show magic_expression("105",5);
show magic_expression("232",8);
show magic_expression("1324",10);
show magic_expression("1001",2)

