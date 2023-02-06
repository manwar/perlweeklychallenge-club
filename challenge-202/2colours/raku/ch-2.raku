#!/usr/bin/env raku

my token unsigned-integer { 0 | <[1..9]><[0..9]>* };
my token integer { '-'? <unsigned-integer> };
subset IntList of Str where /^ '(' <integer>* % ',' ')' $/;


sub MAIN(Str $array) { #using only integer altitudes but the algorithm should work on any real numbers as well
  die 'Please supply a valid list of integers.' unless $array.subst(/\s/, '', :g) ~~ IntList;
  my Int() @array = $<integer>;
  my @comparative = @array.rotor(2 => -1).map({ .[0] <=> .[1] });
  enum <START PREFIX DESC >;
  my @candidate-starts = gather for @comparative.kv -> $pos, $comp-to-next {
    state $fsm-state = START;
    state $possible-start-position;
    when $fsm-state == START && $comp-to-next == Same { # we may start a valley, not sure yet
      $fsm-state = PREFIX;
      $possible-start-position = $pos;
    }
    when $fsm-state == PREFIX && $comp-to-next == Less { # the possible valley failed
      $possible-start-position = Nil;
      $fsm-state = START;
    }
    when $fsm-state == START && $comp-to-next == More { # the valley just started with a slope
      $fsm-state = DESC;
      take $pos;
    }
    when $fsm-state == PREFIX && $comp-to-next == More { # the possible valley turned out to be real, going downhill...
      take $possible-start-position;
      $possible-start-position = Nil;
      $fsm-state = DESC;
    }
    # Note: as long as we are going downhill, there is no point in "starting" a new valley because that would not be optimal
    when $fsm-state == DESC && $comp-to-next == Less { # the downhill part is surely over; we may start looking for new starter positions...
      $fsm-state = START;
    }
  };
  # The starting position should always be considered a starter.
  # Normally, a valley starting by going upwards cannot be optimal because it's better extended in front, with a downwards bit.
  # But what if there is no downwards bit because the values are monotone increasing at the beginning?
  # As a corner case, that needs to be taken into account, hence the first element will always be a starter candidate:
  # - either because a valley starts by going downwards, the usual way
  # - or because the valley starts by going upwards and cannot be improved, simply because there is nothing in front to extend it :) 
  @candidate-starts.unshift(0) unless @candidate-starts[0] == 0;

  my @candidate-ranges = gather for @candidate-starts.rotor(2 => -1, :partial) -> ($start, $trivial-end?) {
    without $trivial-end {
      take $start .. @comparative;
      next;
    }
    my $end = $trivial-end;
    $end++ while @comparative[$end] == Same;
    take $start .. $end; 
  }
  my $best-range = @candidate-ranges.max(*.elems);
  @array[|$best-range].join(', ').say;
}

