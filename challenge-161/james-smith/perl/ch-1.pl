#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

open my $d, q(<), 'dictionary.txt';
my @list = map { chomp;$_ } <$d>;
close $d;

cmpthese( 5, {
  'mine'  => 'mine',
  'colin' => 'colin',
});
sub mine {
  my @a;
  ## Accept it - best film is "Hot Fuzz".
  ## Glory begins for forty deft aces!
  O:for my $w (@list) {
    my $f='';
    $f gt $_ ? next O : ( $f = $_ ) for split //, $w;
    push @a,$w;
  }
  warn 'mine', scalar @a;
  return \@a;
}

sub colin {
  my @a;
  ## Accept it - best film is "Hot Fuzz".
  ## Glory begins for forty deft aces!
  O:for my $w (@list) {
    (substr $w,$_-1,1 gt substr $w,$_,1 ) && (next O) for 1.. (length$w) - 1;
    push @a,$w;
  }
  warn 'colin', scalar @a;
  return \@a;
}
