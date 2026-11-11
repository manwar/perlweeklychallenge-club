#!/usr/bin/env raku
use v6;

sub longestAbsolutePath($fs) {
  my (@files, @level, $explain);
  my @entries = $fs.split("\n");
  for @entries <-> $entry {
    my $deep = $entry.indices("\t").elems; # count the tabs
    if ($deep > 0) {
      $entry ~~ s:g/\t//; # eliminate the tabs
      my $dir = @level[$deep-1];
      $entry = ($dir, $entry).join("/");
      if (@files.elems > 0 && $dir eq @files[*-1]) {
        $explain ~= qq|"{$dir}" is a directory |
                 ~ "(it has children beneath it).\n";
        @files.pop;
      }
    }
    @level[$deep] = $entry;
    @files.push($entry) if $entry ~~ m|<-[/]>+\.<-[/]>+$|;
  }
  if (@files.elems == 0) {
    return
      0,
      "There are no files in the system (a file must contain " ~
      "a . character\nseparating a name and extension).\n" ~
      "Since there are no files, the answer is 0.";
  }
  $explain ~= "Found File Paths:\n";
  $explain ~= @files.map({
    qq|    "$_" (length {$_.chars})|
  }).join("\n");
  return @files.map( *.chars ).max, $explain;
}

sub solution($fs) {
  my $display = S:g/\n/\\n/ given $fs;
  $display ~~ s:g/\t/\\t/;
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
