#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $N = @ARGV ? $ARGV[0] : 1;
## works for $N up 5...
my @digits = (0,2,4,6);
my @tens   = (0,30,40,50,60);
my @three_digit_eban_nos =  map { my $a=$_; map { $a+$_ } @digits } @tens;

dump_list( my @next_order = grep {$_} @three_digit_eban_nos );
dump_list( @next_order = map { my $a = $_; map { sprintf "%s,%03d", $a,$_ } @three_digit_eban_nos } @next_order )
  for 2..$N;

sub dump_list {
  say $_ foreach map { $_ ? s{^0+}{}r : () }  @_;
}
