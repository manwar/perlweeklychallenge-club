#!/usr/bin/env raku

sub challenge(Int $year) returns Str {
    constant $root-year = 1924; # From Wikipedia

    my $difference         = $year - $root-year;
    my $element-difference = $difference < 0 ?? $difference + 10 !! $difference;
    my $animal-difference  = $difference < 0 ?? $difference + 12 !! $difference;

    my $element = do given $element-difference % 10 {
        when 0|1 { 'Wood'  }
        when 2|3 { 'Fire'  }
        when 4|5 { 'Earth' }
        when 6|7 { 'Metal' }
        when 8|9 { 'Water' }
    }
    my $animal = do given $animal-difference % 12 {
        when 0  { 'Rat'     }
        when 1  { 'Ox'      }
        when 2  { 'Tiger'   }
        when 3  { 'Rabbit'  }
        when 4  { 'Dragon'  }
        when 5  { 'Snake'   }
        when 6  { 'Horse'   }
        when 7  { 'Goat'    }
        when 8  { 'Monkey'  }
        when 9  { 'Rooster' }
        when 10 { 'Dog'     }
        when 11 { 'Pig'     }
    }

    "$element $animal";
}

multi sub MAIN(Int $year) {
    say challenge($year);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        (2017, 'Fire Rooster'),
        (1938, 'Earth Tiger'),
        (1924, 'Wood Rat'), # Should work for root case
        (1923, 'Water Pig') # Should work for years < 1924
    );

    for @tests -> ($year, $expected) {
        is(challenge($year), $expected);
    }

    done-testing;
}
