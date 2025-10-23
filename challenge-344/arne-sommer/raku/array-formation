#! /usr/bin/env raku

unit sub MAIN (*@rows where @rows.elems > 0
                  && all(@rows) ~~ /^ <[0..9,]>+ $/,
                :t(:$target) where $target ~~ /^ <[0..9,]>+ $/,
		:v(:$verbose));

my @source = @rows>>.split(',')>>.Int;
my @target = $target.split(',')>>.Int;

for @source.permutations -> @combo
{
  my @flat  = @combo[*;*];
  my $equal = @flat eqv @target;

  say ": ({ @combo.map({ "[{ $_.join(",")}]" }).join(", ") }) eq ({ @target.join(",") }): { $equal }" if $verbose;

  if $equal
  {
    say 'true';
    exit;
  }
}

say 'false';
