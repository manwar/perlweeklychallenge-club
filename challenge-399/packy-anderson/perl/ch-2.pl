#!/usr/bin/env perl
use v5.44;

use List::AllUtils qw( max );

sub longestAbsolutePath($fs) {
  my (@files, @level, $explain);
  for my $entry (split /\n/, $fs) {
    my $deep = $entry =~ tr/\t//d; # count and eliminate tabs
    if ($deep > 0) {
      my $dir = $level[$deep-1];
      $entry = join "/", $dir, $entry;
      if (@files > 0 && $dir eq $files[-1]) {
        $explain .= qq|"@{[$dir]}" is a directory |
                 . "(it has children beneath it).\n";
        pop @files;
      }
    }
    $level[$deep] = $entry;
    push @files, $entry if $entry =~ m|[^/]+\.[^/]+$|;
  }
  if (@files == 0) {
    return
      0,
      "There are no files in the system (a file must contain " .
      "a . character\nseparating a name and extension).\n" .
      "Since there are no files, the answer is 0.";
  }
  $explain .= "Found File Paths:\n";
  $explain .= join "\n", map {
    qq|    "$_" (length @{[length $_]})|
  } @files;
  return max(map { length($_) } @files), $explain;
}

sub solution($fs) {
  my $display = $fs =~ s/\n/\\n/gr;
  $display =~ s/\t/\\t/g;
  say qq/Input: \$fs = "$display"/;
  my ($len, $explain) = longestAbsolutePath($fs);
  say "Output: $len\n\n$explain";
}

say "Example 1";
solution("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2");

say "\nExample 2";
solution("file1.txt\nfile2.ext\na.png");

say "\nExample 3";
solution("my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png");

say "\nExample 4";
solution("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt");

say "\nExample 5";
solution("a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt");
