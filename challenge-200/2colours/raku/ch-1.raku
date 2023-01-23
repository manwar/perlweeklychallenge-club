#!/usr/bin/env raku

my token unsigned-integer { 0 | <[1..9]><[0..9]>* };
my token integer { '-'? <unsigned-integer> };
subset IntList of Str where /^ '(' <integer>* % ',' ')' $/;

proto infix:<l?,>($l, $r) is assoc<left> is equiv(&infix:<,>) {*}
multi infix:<l?,>(Pair $l, Pair $r) {
  samewith([[$l],], $r);
}
multi infix:<l?,>(Array $l, Pair $r) {
  if $l.tail[0].value == $r.value {
    $l.tail.push: $r;
  }
  else {
    $l.push: [$r]
  }
  $l
}


sub MAIN(Str $array) {
  die 'Please supply a valid list of integers.' unless $array.subst(/\s/, '', :g) ~~ IntList;
  my Int() @array = $<integer>;
  my @arithmetic-parts <==
    @array.skip Z- @array andthen
    [l?,] .pairs andthen
    $_>>.key>>.minmax;
  my @good-slices = gather for @arithmetic-parts {
    given .min .. .max+1 { #convert from difference indexes to original indexes
      for .min .. .max - 2 -> $start {
        for $start + 2 .. .max -> $end {
          take @array[$start .. $end];
        }
      }
    }
  }
  @good-slices.map(*[].raku).join(', ').say;
}

