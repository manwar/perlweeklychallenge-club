#! /usr/bin/env raku

unit sub MAIN (UInt $n, :v(:$verbose));

my @done;
my @todo = ( { word => "", height => 0, D => $n, U => $n }, );

while @todo
{
  my $current = @todo.shift;

  say ": Working on word:'$current<word>', todo D:$current<D> todo U:$current<U> height:$current<height>" if $verbose;

  if $current<D> == $current<U> == 0
  {
    @done.push: $current<word>;
    next;
  }

  if $current<D> && $current<height>
  {
    @todo.push: { word   => $current<word> ~ "D",
                  height => $current<height> -1,
                  D      => $current<D> -1,
                  U      => $current<U>  };
  }

  if $current<U>
  {
    @todo.push: { word   => $current<word> ~ "U",
                  height => $current<height> +1,
                  D      => $current<D>,
                  U      => $current<U> -1 };
  }
}

say "({ @done.join(", ") })";
