#!/usr/bin/env raku
use v6;

sub isSimilar(@d1, @d2) {
  return (
    (@d1[0] == @d2[0] && @d1[1] == @d2[1])
    ||
    (@d1[0] == @d2[1] && @d1[1] == @d2[0])
  );
}

sub similarDominos(@dominos) {
  my %already_matched;
  my @similar;
  my $sim_count = 0;
  for 0 .. @dominos.end - 1 -> $i {
    next if %already_matched{$i};
    my @sim;
    for $i + 1 .. @dominos.end -> $j {
      next if %already_matched{$j};
      if (isSimilar(@dominos[$i], @dominos[$j])) {
        # only push $i onto the list if this is the first match
        unless %already_matched{$i} {
          @sim.push("\$dominos[$i]");
          $sim_count++;
          %already_matched{$i} = 1;
        }
        @sim.push("\$dominos[$j]");
        $sim_count++;
        %already_matched{$j} = 1;
      }
    }
    @similar.push(@sim) if @sim.elems > 0;
  }
  my $explain = "Similar Dominos: ";
  if ($sim_count == 0) {
    $explain ~= "none";
  }
  elsif (@similar.elems == 1) {
    $explain ~= @similar[0].join(", ");
  }
  else {
    my @s = @similar.map({ .join(", ") });
    $explain ~= "\n + " ~ @s.join("\n + ");
  }
  return $sim_count, $explain;
}

sub solution(@dominos) {
  my @d = @dominos.map({ '[' ~ .join(', ') ~ ']' });
  say 'Input: @arr = (' ~ @d.join(', ') ~ ')';
  my ($count, $explain) = similarDominos(@dominos);
  say "Output: $count\n\n$explain";
}

say "Example 1:";
solution([[1, 3], [3, 1], [2, 4], [6, 8]]);

say "\nExample 2:";
solution([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]]);

say "\nExample 3:";
solution([[1, 2], [3, 4], [2, 1], [4, 3], [1, 2]]);
