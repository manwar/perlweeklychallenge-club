#! /usr/bin/env raku

unit sub MAIN (Str $fs is copy where $fs.chars > 0,
               :v(:$verbose));

$fs = $fs.subst(/\\n/, "\n", :g).subst(/\\t/, "\t", :g);

my @lines = $fs.split: /\n/;
my @depth = @lines.map: { .comb(/\t/).elems };
my @name  = @lines.map: { .subst(/^ \t* /, '') };

my @dir;
my $best = 0;

for ^ @lines.elems -> $i
{
  my $d    = @depth[$i];
  my $name = @name[$i];
  my $next-depth = $i + 1 < @lines.elems ?? @depth[$i + 1] !! -1;

  if $name.contains('.') && $next-depth <= $d
  {
    my $path = (|@dir[0 .. $d - 1], $name).join: '/';
    say ": $name => $path ({ $path.chars })" if $verbose;
    $best = max($best, $path.chars);
  }
  else
  {
    @dir[$d] = $name;
    say ": $name (directory)" if $verbose;
  }
}

say $best;