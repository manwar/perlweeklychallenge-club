#! /usr/bin/env raku

unit sub MAIN (*@arr where @arr.elems > 0 && all(@arr) ~~ Int,
               :v(:$verbose));

my @qualifying = @arr.grep: * %% 6;

if $verbose
{
  for @arr -> $n
  {
    say ": $n " ~ (
        $n %% 6
            ?? "is even and divisible by 3"
            !! $n % 2
            ?? "is not even"
            !! "is not divisible by 3"
    );
  }
  say ": average is {@qualifying.sum / @qualifying.elems}" if @qualifying;
}

say @qualifying.elems
    ?? (@qualifying.sum / @qualifying.elems).round
    !! 0;