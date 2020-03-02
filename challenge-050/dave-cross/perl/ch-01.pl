#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $data = get_input();
$data    = merge_intervals($data);
show_output($data);

sub get_input {
  die "No input given\n" unless @ARGV;

  my $input = join '', @ARGV;

  if ($input =~ /[^\[\],\d\s]/) {
    die "Invalid input: $input\n";
  }

  return eval '[' . $input . ']';
}

sub merge_intervals {
  my $intervals_in = shift;
  my $intervals_out;

  $_ = 0;
  while ($_ <= $#{$intervals_in} - 1) {
    if ($intervals_in->[$_ + 1][0] <= $intervals_in->[$_][1]) {
      warn "Merging [$intervals_in->[$_][0],$intervals_in->[$_][1]] ",
        "with [$intervals_in->[$_ + 1][0],$intervals_in->[$_ + 1][1]]\n";
      push @$intervals_out, [
        $intervals_in->[$_][0],
	$intervals_in->[$_ + 1][1]
      ];
      $_ += 2;
    } else {
      push @$intervals_out, $intervals_in->[$_];
      $_++;
    }
  }

  return $intervals_out;
}

sub show_output {
  my $data = shift;

  say join(', ', map { '[' . join(',', @$_) . ']' } @$data);
}
