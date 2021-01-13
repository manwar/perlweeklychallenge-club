#! /usr/bin/env perl

use feature 'say';
use feature 'signatures';
no warnings qw(experimental::signatures);

my $S = shift(@ARGV) || die 'Specify $S';

my %button =
(
 '1' => [ '_', ',', '@'],
 '2' => [ 'a', 'b', 'c'],
 '3' => [ 'd', 'e', 'f'],
 '4' => [ 'g', 'h', 'i'],
 '5' => [ 'j', 'k', 'l'],
 '6' => [ 'm', 'n', 'o'],
 '7' => [ 'p', 'q', 'r', 's'],
 '8' => [ 't', 'u', 'v'],
 '9' => [ 'w', 'x', 'y', 'z'],
 '*' => [ ' ']
);

my @solutions;

off_we_go("", $S);

say "[", join(", ", map { "\"$_\"" } @solutions), "]" if @solutions;

sub off_we_go ($so_far, $to_do)
{
  if (length($to_do) == 0)
  {
    push(@solutions, $so_far);
    return;
  }

  my $current   = substr($to_do, 0,1);
  my $remainder = substr($to_do, 1);

  die "Illegal character $current" unless $button{$current};

  for my $character (@{$button{$current}})
  {  
    off_we_go($so_far . $character, $remainder);
  }
}
