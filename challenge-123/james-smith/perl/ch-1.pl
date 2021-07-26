#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $N = @ARGV ? shift @ARGV : 1000;
my $C = @ARGV ? shift @ARGV : 2e5/$N;
my @uglies = qw(1 2 3 4 5 6 8 9 10 12 15 16 18 20 24 25 27 30 32 36 40 45 48 50 54 60 64 72 75 80 81 90 96 100 108 120 125 128 135 144 150 160 162 180 192 200 216 225 240 243 250 256 270 288 300 320 324 360 375 384 400 405 432 450 480 486 500 512 540 576 600 625 640 648 675 720 729 750 768 800 810 864 900 960 972 1000);

my %cache;
my $c=0;
my @TESTS = map { [ ++$c, $_ ] } @uglies;

is( nth_ugly_scan($_->[0]), $_->[1] ) foreach @TESTS;
is( nth_ugly_scan_rec($_->[0]), $_->[1] ) foreach @TESTS;
is( nth_ugly($_->[0]), $_->[1] ) foreach @TESTS;
is( nth_ugly_opt($_->[0]), $_->[1] ) foreach @TESTS;
done_testing();

cmpthese(int $C,{
  'scan' => sub { nth_ugly_scan($N) },
  'orig' => sub { nth_ugly($N) },
  'opt'  => sub { nth_ugly_opt($N) },
});
#say  nth_ugly($N);
say  nth_ugly_opt($N);
sub nth_ugly {
  my $n = shift;
  my @uglies = (1);
  while(1) {
    return $uglies[$n-1] if $n <= @uglies;
    ## Get the next ugly....
    my $next = 0;
    foreach my $l (5,3,2) {
      foreach(@uglies) {
        next if $_ * $l <= $uglies[-1];
        $next = $_*$l if !$next || $next > $_*$l;
        last;
      }
    }
    push @uglies, $next;
  }
}

sub nth_ugly_opt {
  my $n = shift;
  my @uglies = (1);
  my @starts = (0,0,0,0,0,0);
  while(1) {
    return $uglies[$n-1] if $n <= @uglies;
    ## Get the next ugly....
    my $next = 0;
    foreach my $l (5,3,2) {
      foreach ( $starts[$l] .. $#uglies ) {
        next if $uglies[$_] * $l <= $uglies[-1];
        $starts[$l]=$_;
        $next = $uglies[$_]*$l if !$next || $next > $uglies[$_]*$l;
        last;
      }
    }
    push @uglies, $next;
  }
}

sub nth_ugly_scan {
  %cache=();
  my $n = shift;
  my $r = 0;
  while(1) {
    $r++;
    next unless is_ugly($r);
    $n--;
    return $r unless $n;
  }
}

sub is_ugly {
  my $v = shift;
  return $cache{$v} if exists $cache{$v};
  $v >>=1 until $v & 1;
  $v/=3   until $v % 3;
  $v/=5   until $v % 5;
  return $cache{$v} = $v == 1;
}

