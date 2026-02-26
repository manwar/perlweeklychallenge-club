#! /usr/bin/raku

use Test;

plan 5;

is-deeply(spellboundsorting([6, 7, 8, 9, 10]), [8, 9, 7, 6, 10], 'example 1');
is-deeply(spellboundsorting([-3, 0, 1000, 99]), [-3, 99, 1000, 0], 'example 2');
is-deeply(spellboundsorting([1, 2, 3, 4, 5]), [5, 4, 1, 3, 2], 'example 3');
is-deeply(spellboundsorting([0, -1, -2, -3, -4]), [-4, -1, -3, -2, 0], 'example 4');
is-deeply(spellboundsorting([100, 101, 102]), [100, 101, 102], 'example 5');

sub spellboundsorting(@a) {
    my @o = @a;
    @o = @o.sort({towords($_)});
    @o;
}

sub towords($a) {
  if ($a == 0) {
    return 'zero';
  }
  my @components;
  my $b = $a;
  if ($a < 0) {
    $b = -$a;
    @components.push("minus");
  }
  my @vw = [
        [1000000000, "milliard"],
        [1000000, "million"],
        [1000, "thousand"],
        [100, "hundred"],
        [90, "ninety"],
        [80, "eighty"],
        [70, "seventy"],
        [60, "sixty"],
        [50, "fifty"],
        [40, "forty"],
        [30, "thirty"],
        [20, "twenty"],
        [19, "nineteen"],
        [18, "eighteen"],
        [17, "seventeen"],
        [16, "sixteen"],
        [15, "fifteen"],
        [14, "fourteen"],
        [13, "thirteen"],
        [12, "twelve"],
        [11, "eleven"],
        [10, "ten"],
        [9, "nine"],
        [8, "eight"],
        [7, "seven"],
        [6, "six"],
        [5, "five"],
        [4, "four"],
        [3, "three"],
        [2, "two"],
        [1, "one"],
  ];
  for cw($b, @vw) -> $w {
    @components.push($w);
  }
  @components.join(' ');
}

sub cw($n, @vw) {
    my @res = [];
    for @vw -> ($val, $word) {
        if ($n >= $val) {
            my $andflag = False;
            if ($n >= 100) {
                $andflag = True;
                for cw(floor($n / $val), @vw) -> $w {
                    @res.push($w);
                }
            }
            @res.push($word);
            my $p = $n % $val;
            if ($p > 0) {
                if ($andflag) {
                    @res.push("and");
                }
                for cw($p, @vw) -> $w {
                    @res.push($w);
                }
            }
            last;
        }
    }
    @res;
}
