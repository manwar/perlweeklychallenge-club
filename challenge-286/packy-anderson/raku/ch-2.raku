#!/usr/bin/env raku
use v6;

sub orderGame(@ints is copy) {
  my $loop = 0;
  my @explain;
  while (@ints.elems > 1) {
    my @new;
    $loop++;
    @explain.push("Operation $loop:");
    @explain.push("");
    my $flip = 1;
    for @ints -> $a, $b {
      my ($val, $func);
      if ($flip == 1) {
        $val = min($a, $b);
        $func = 'min';
      }
      else { # $flip is -1
        $val = max($a, $b);
        $func = 'max';
      }
      @new.push($val);
      @explain.push("    $func" ~ "($a, $b) = $val");
      $flip *= -1; # switch from min to max and back
    }
    @explain.push("");
    @ints = @new; # replace list with new list
  }
  return @ints[0], @explain.join("\n");
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my ($output, $explain) = orderGame(@ints);
  say 'Output: ' ~ $output;
  say "\n$explain";
}

say "Example 1:";
solution([2, 1, 4, 5, 6, 3, 0, 2]);

say "\nExample 2:";
solution([0, 5, 3, 2]);

say "\nExample 3:";
solution([9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]);
