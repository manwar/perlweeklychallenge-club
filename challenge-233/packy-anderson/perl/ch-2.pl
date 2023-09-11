#!/usr/bin/env perl
  
use v5.38;

use Lingua::EN::Inflexion qw( wordlist );

sub solution {
  my @ints = @_;
  say 'Input: @ints = (' . join(', ', @ints) . ')';

  # count how often each integer occurs
  my %counts;
  foreach my $int ( @ints ) {
    $counts{$int}++;
  }

  # now create a hash of arrays listing which integers
  # occur at what frequencies
  my %frequency;
  foreach my $int ( keys %counts ) {
    push @{ $frequency{ $counts{$int} } }, $int;
  }

  my @output;
  my $text;
  foreach my $freq ( sort keys %frequency ) {
    my @list = @{ $frequency{$freq} };
    # get each integer for this frequency in descending order
    foreach my $int ( reverse sort @list ) {
      # we need to put the integer on the list $freq times
      foreach ( 1 .. $freq ) {
        push @output, $int;
      }
    }
    # now let's do the English description of the output.
    # have the integers in ascending order in the text,
    # and wrap them in quotes
    @list = map { "'$_'" } sort @list;
    if (@list == 1) {
      $text .= $list[0] . " has a frequency of $freq\n";
    }
    else {
      $text .= wordlist(@list);
      if (@list == 2) {
        $text .= ' both';
      }
      $text .= " have a frequency of $freq, "
            .  "so they are sorted in decreasing order\n";
    }
  }

  say "Output: (" . join(', ', @output) . ")";
  say "\n$text";
}

say "Example 1:";
solution(1,1,2,2,2,3);

say "";
say "Example 2:";
solution(2,3,1,3,2);

say "";
say "Example 3:";
solution(-1,1,-6,4,5,-6,1,4,1);