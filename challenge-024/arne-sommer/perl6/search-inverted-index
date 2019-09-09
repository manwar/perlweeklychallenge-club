#! /usr/bin/env perl6

sub MAIN ($word, :$index = "index.txt")
{
  for (slurp $index).lines -> $line
  {
    my ($entry, $files) = $line.split(":");

    if $word eq $entry
    {
      say "«$word» found in: $files";
      exit;
    }
  }
  say "Not found.";
}

