#!/usr/bin/env raku
use v6;

sub reorder(@melody) {
  # unpack data
  my $composer = @melody[0].uc;
  my @notes = @melody[1].flat; # otherwise we get [[notes],]
  my @order = @melody[2].flat;
  # reorder data
  my @new;
  for (@notes Z @order) -> ($note, $i) { @new[$i-1] = $note; }
  "$composer => " ~ @new.join(" ")
}

sub solution(@melody) {
  # unpack data
  my $composer = @melody[0];
  my $notes = @melody[1].join(' ');
  my $order = @melody[2].join(', ');
  say qq/Input: \$melody = ['$composer', [qw($notes)], [$order]]/;
  say 'Output: ' ~ reorder(@melody);
}

say "Example 1:";
solution(['Bach', [qw|C D E F# G A B|], [7, 1, 6, 2, 5, 3, 4]]);

say "\nExample 2:";
solution(['Beethoven', [qw|C D F# G Ab|], [1, 3, 5, 2, 4]]);

say "\nExample 3:";
solution(['Brahms', [qw|C Db Eb F G Ab Bb C D|], [9, 3, 7, 1, 8, 5, 2, 6, 4]]);

say "\nExample 4:";
solution(['Bruckner', [qw|G F# Bb C D Eb F|], [4, 7, 2, 6, 1, 5, 3]]);

say "\nExample 5:";
solution(['Berg', [qw|C#|], [1]]);
