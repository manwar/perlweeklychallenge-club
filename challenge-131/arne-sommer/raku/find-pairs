#! /usr/bin/env raku

unit sub MAIN ($pairs = '""[]()',
               $search = '"I like (parens) and the Apple ][+" they said.',
               :v(:$verbose));

my @pairs = $pairs.comb;

my @open  = @pairs[0, 2 ... *];
my @close = @pairs[1, 3 ... *];

say ": Open: @open[]"  if $verbose;
say ": Close @close[]" if $verbose;

my $open  = "";
my $close = "";

for $search.comb -> $char
{
  $open  ~= $char if any(@open)  eq $char;
  $close ~= $char if any(@close) eq $char;
}

say $open;
say $close;
