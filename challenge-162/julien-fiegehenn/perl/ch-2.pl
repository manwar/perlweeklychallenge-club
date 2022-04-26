#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use constant {ROW => 0, COL => 1};

# Implement encryption and decryption using the Wheatstone-Playfair cipher.
#
# Examples:
#  (These combine I and J, and use X as padding.)
#
#  encrypt("playfair example", "hide the gold in the tree stump") = "bmodzbxdnabekudmuixmmouvif"
#
#  decrypt("perl and raku", "siderwrdulfipaarkcrw") = "thewexeklychallengex"

# Comments based on example in  https://de.wikipedia.org/wiki/Playfair.

# Turn on debugging with the DEBUG=0 environment variable.

say encrypt('playfaire example', 'hide the gold in the tree stump');
say decrypt("perl and raku", "siderwrdulfipaarkcrw");

sub debug($) {
  print @_ if $ENV{DEBUG};
}

sub generate_table {
  my $key = shift;

  my @letters = grep /[A-IK-Z]/, split //, uc $key;
  push @letters, 'A' .. 'I', 'K' .. 'Z';

  my ($table, $seen);

  for my $row (0 .. 4) {
    for my $col (0 .. 4) {
      while (@letters) {
        my $letter = shift @letters;

        # skip the ones we've seen
        redo if $seen->{$letter};

        $table->[$row]->[$col] = $letter;
        $seen->{$letter} = [$row, $col];
        last;
      }
      debug "$table->[$row]->[$col] ";
    }
    debug "\n";
  }
  debug "\n";

  return ($table, $seen);
}

sub encrypt {
  my ($key, $string) = @_;

  my ($table, $lookup) = generate_table($key);

  my $encrypted = q{};

  my @letters = grep /[A-Z]/, split //, uc $string;
  while (my ($first, $second) = splice @letters, 0, 2) {

    # pad to create a pair if we only have one letter left
    $second ||= 'X';

    # handle repeated letters
    if ($first eq $second) {
      unshift @letters, $second;
      $second = 'X';
    }

    debug "$first$second ";

    # 1. The pair HI forms a rectangle, replace it with BM
    if ( $lookup->{$first}->[ROW] != $lookup->{$second}->[ROW]
      && $lookup->{$first}->[COL] != $lookup->{$second}->[COL])
    {
      ($first, $second) = (
        $table->[$lookup->{$first}->[ROW]]->[$lookup->{$second}->[COL]],
        $table->[$lookup->{$second}->[ROW]]->[$lookup->{$first}->[COL]],
      );
    }

    # 2. The pair DE is in a column, replace it with OD
    elsif ($lookup->{$first}->[ROW] != $lookup->{$second}->[ROW]
      && $lookup->{$first}->[COL] == $lookup->{$second}->[COL])
    {
      ($first, $second) = (
        $table->[wrap_number($lookup->{$first}->[ROW] + 1)]
          ->[$lookup->{$first}->[COL]],
        $table->[wrap_number($lookup->{$second}->[ROW] + 1)]
          ->[$lookup->{$second}->[COL]],
      );
    }

    # 10. The pair EX (X inserted to split EE) is in a row, replace it with XM
    elsif ($lookup->{$first}->[ROW] == $lookup->{$second}->[ROW]
      && $lookup->{$first}->[COL] != $lookup->{$second}->[COL])
    {
      ($first, $second) = (
        $table->[$lookup->{$first}->[ROW]]
          ->[wrap_number($lookup->{$first}->[COL] + 1)],
        $table->[$lookup->{$second}->[ROW]]
          ->[wrap_number($lookup->{$second}->[COL] + 1)],
      );
    }
    debug " -> $first$second\n";

    $encrypted .= $first . $second;
  }
  debug "\n";

  return $encrypted;
}

sub decrypt {
  my ($key, $string) = @_;

  my ($table, $lookup) = generate_table($key);

  my $encrypted = q{};

  my @letters = grep /[A-Z]/, split //, uc $string;
  while (my ($first, $second) = splice @letters, 0, 2) {

    # pad to create a pair if we only have one letter left
    $second ||= 'X';

    # handle repeated letters
    if ($first eq $second) {
      unshift @letters, $second;
      $second = 'X';
    }

    debug "$first$second ";

    # 1. The pair HI forms a rectangle, replace it with BM
    if ( $lookup->{$first}->[ROW] != $lookup->{$second}->[ROW]
      && $lookup->{$first}->[COL] != $lookup->{$second}->[COL])
    {
      ($first, $second) = (
        $table->[$lookup->{$first}->[ROW]]->[$lookup->{$second}->[COL]],
        $table->[$lookup->{$second}->[ROW]]->[$lookup->{$first}->[COL]],
      );
    }

    # 2. The pair DE is in a column, replace it with OD
    elsif ($lookup->{$first}->[ROW] != $lookup->{$second}->[ROW]
      && $lookup->{$first}->[COL] == $lookup->{$second}->[COL])
    {
      ($first, $second) = (
        $table->[wrap_number($lookup->{$first}->[ROW] - 1)]
          ->[$lookup->{$first}->[COL]],
        $table->[wrap_number($lookup->{$second}->[ROW] - 1)]
          ->[$lookup->{$second}->[COL]],
      );
    }

    # 10. The pair EX (X inserted to split EE) is in a row, replace it with XM
    elsif ($lookup->{$first}->[ROW] == $lookup->{$second}->[ROW]
      && $lookup->{$first}->[COL] != $lookup->{$second}->[COL])
    {
      ($first, $second) = (
        $table->[$lookup->{$first}->[ROW]]
          ->[wrap_number($lookup->{$first}->[COL] - 1)],
        $table->[$lookup->{$second}->[ROW]]
          ->[wrap_number($lookup->{$second}->[COL] - 1)],
      );
    }
    debug " -> $first$second\n";

    $encrypted .= $first . $second;
  }
  debug "\n";

  return $encrypted;
}

sub wrap_number {
  my $number = shift;

  return 4 - $number if $number > 4;
  return $number;
}

__END__

use Test::More;

is lc encrypt("playfair example", "hide the gold in the tree stump"),
  "bmodzbxdnabekudmuixmmouvif";
is lc decrypt("perl and raku", "siderwrdulfipaarkcrw"), "thewexeklychallengex";

done_testing;