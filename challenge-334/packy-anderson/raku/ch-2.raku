#!/usr/bin/env raku
use v6;

sub manhattanDistance(@a, @b) {
  return (
    abs(@a[0] - @b[0]) + abs(@a[1] - @b[1]),
    "|@a[0] - @b[0]| + |@a[1] - @b[1]|"
  );
}

sub formatPoint(@p) {
  return "[@p[0], @p[1]]";
}

sub NVP($x, $y, @points) {
  my $explanation;

  # find the "valid" points
  my %valid;
  for 0 .. @points.end -> $i {
    next unless @points[$i][0] == $x || @points[$i][1] == $y;
    %valid{$i} = 1;
  }
  unless (%valid) {
    return (-1, "No point shares x or y with ($x, $y).");
  }
  if (%valid.elems == @points.elems) {
    $explanation = 'Valid points: all of them';
  }
  else {
    $explanation = 'Valid points: ' ~ @points[%valid.keys]
            .map({ formatPoint($_) }).join(", ");
  }

  # now find the distances from the valid points to (x,y)
  $explanation ~= "\n\nManhattan distances:\n";
  my %dist;
  for 0 .. @points.end -> $i {
    next unless %valid{$i}:exists;
    my ($d, $e) = manhattanDistance([$x, $y], @points[$i]); 
    $explanation ~= "    " ~ formatPoint(@points[$i])
                 ~  " => $e => $d\n";
    %dist{ $d }.push($i); # add the index to a list for this dist
  }

  # the minimum key in the %dist hash is the minimum distance
  my $min = min(%dist.keys);

  # pick the lowest index from the min distance array
  my $i = %dist{$min}[0];

  if (%dist{$min}.elems == 1) { # only one min distance
    $explanation ~= "\nClosest valid point is "
                 ~  formatPoint(@points[$i]) ~ " at index $i.";
  }
  elsif (%dist{$min}.elems < %valid.elems) {
    $explanation ~= "\nTie between index "
                 ~  %dist{$min}.join(" and ")
                 ~ ", pick the smaller index: $i.";
  }
  else {
    $explanation ~= "\nAll tie, return the one with "
                 ~  "the lowest index: $i.";
  }

  return ($i, $explanation);
}

sub solution($x, $y, @points) {
  my $str_list = @points.map({ formatPoint($_) }).join(', ');
  say "Input: \$x = $x, \$y = $y, \@points ($str_list)";
  my ($output, $explanation) = NVP($x, $y, @points);
  say 'Output: ' ~ $output;
  say "\n$explanation";
}

say "Example 1:";
solution(3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]]);

say "\nExample 2:";
solution(2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]]);

say "\nExample 3:";
solution(1, 1, [[2, 2], [3, 3], [4, 4]]);

say "\nExample 4:";
solution(0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]]);

say "\nExample 5:";
solution(5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]]);
