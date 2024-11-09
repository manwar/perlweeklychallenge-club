#!/usr/bin/env perl
use v5.40;

sub isSimilar($d1, $d2) {
  return (
    ($$d1[0] == $$d2[0] && $$d1[1] == $$d2[1])
    ||
    ($$d1[0] == $$d2[1] && $$d1[1] == $$d2[0])
  );
}

sub similarDominos(@dominos) {
  my %already_matched;
  my @similar;
  my $sim_count = 0;
  foreach my $i ( 0 .. $#dominos - 1) {
    next if $already_matched{$i};
    my @sim = ();
    foreach my $j ( $i + 1 .. $#dominos ) {
      next if $already_matched{$j};
      if (isSimilar($dominos[$i], $dominos[$j])) {
        # only push $i onto the list if this is the first match
        unless ($already_matched{$i}) {
          push @sim, "\$dominos[$i]";
          $sim_count++;
          $already_matched{$i} = 1;
        }
        push @sim, "\$dominos[$j]";
        $sim_count++;
        $already_matched{$j} = 1;
      }
    }
    push @similar, \@sim if @sim > 0;
  }
  my $explain = "Similar Dominos: ";
  if ($sim_count == 0) {
    $explain .= "none";
  }
  elsif (@similar == 1) {
    $explain .= join(", ", @{$similar[0]});
  }
  else {
    my @s = map { join(", ", @$_) } @similar;
    $explain .= "\n + " . join("\n + ", @s);
  }
  return $sim_count, $explain;
}

sub solution($dominos) {
  my @d = map { '[' . join(', ', @$_) . ']' } @$dominos;
  say 'Input: @arr = (' . join(', ', @d) . ')';
  my ($count, $explain) = similarDominos(@$dominos);
  say "Output: $count\n\n$explain";
}

say "Example 1:";
solution([[1, 3], [3, 1], [2, 4], [6, 8]]);

say "\nExample 2:";
solution([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]]);

say "\nExample 3:";
solution([[1, 2], [3, 4], [2, 1], [4, 3], [1, 2]]);
