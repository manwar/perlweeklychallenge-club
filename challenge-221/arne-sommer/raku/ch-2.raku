#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1 && all(@ints) ~~ Int, :v(:$verbose));

my $last  = @ints.end;
my $score = 0;
my @seq;
my %computed;

for 0 .. $last -1 -> $first
{
  for 1 .. $last -> $second
  {
    my $diff    = @ints[$second] - @ints[$first];

    next if %computed{$diff}++;

    my $current = @ints[$first];
    my $count   = 1;
    my @sub     = ($current,);

    for @ints[$first +1 .. *] -> $int
    {
      if $int == $current + $diff
      {
        $count++;
        @sub.push: $int;
        $current += $diff;
      }
    }

    if $count > $score
    {
      @seq   = @sub;
      $score = $count;

      say ": New Longest Sequence: ({ @seq.join(",") }) with size $score" if $verbose;
    }
  }
}

say ": Sequence: ({@seq.join(",") })" if $verbose;

say $score;
