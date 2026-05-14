#! /usr/bin/env raku

unit sub MAIN (*@list is copy where @list.elems > 1,
               :$n,
               :v(:$verbose));

if $n > @list.elems
{
  say -1;
  exit;
}

my $bucket-size = @list.elems div $n;
my $extra       = @list.elems % $n;

if $verbose
{
  say ":Bucket size: $bucket-size";
  say ":Extra values: $extra";
}

my @output = gather
{
  while @list.elems
  {
    my $count = $bucket-size;
    if $extra { $count++; $extra--; }
    take @list.splice(0, $count);
  }
}

say "(" ~ @output.map({"(" ~ $_.join(",") ~ ")"}).join(", ") ~ ")";
