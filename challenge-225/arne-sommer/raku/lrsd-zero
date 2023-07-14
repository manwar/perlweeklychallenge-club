#! /usr/bin/env raku

unit sub MAIN (*@int, :v(:$verbose));

if @int.elems == 0
{
  say '()';
  exit;
}

my $size = @int.elems;

my @reverse = @int.reverse;
my @left    = (0,);
my @right   = (0,);

for 0 .. $size -2 -> $i
{
  @left.push:  sum(@int[0 .. $i]);
  @right.push: sum(@reverse[0 .. $i]);
}

@right .= reverse;

say ":Left: @left[]\n:Right: @right[]" if $verbose;

say '(', (@left Z @right).map({ ( $_[0] - $_[1] ).abs }).join(", "), ')';
