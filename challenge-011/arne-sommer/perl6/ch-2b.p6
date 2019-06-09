#! /usr/bin/env perl6

unit sub MAIN (Int $size where $size > 0);

# my @im = 0 xx $size xx $size;
# @im[$_;$_] = 1 for ^$size;

my @row = (1, 0 xx $size -1).flat;
my @x; @x.push: @row.rotate(- $_) for ^$size;
my @im = @x;

print @im.&nice-format;

sub nice-format (@array)
{
  return (@($_).join(" ") for @array).join("\n") ~ "\n";
}