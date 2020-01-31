#! /usr/bin/env perl

my $string = $ARGV[0] || "The quick brown fox jumps over the lazy dog";

$string =~ tr/ //d;

my @a = split(//, lc $string);

@a.shift;
@a.pop;

for my $word (0 .. 7)
{
  my $index = $word;
  while (1)
  {
    defined $a[$index]
      ? print $a[$index]
      : print(" ") && last;

   $index += 8;
  }
}

print "\n";
