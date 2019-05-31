my role X::RomanNumerals is X::AdHoc {}

my class X::RomanNumerals::InvalidRomanString does X::RomanNumerals {
  method message {
    "Input ｢$.payload｣ was not understood.";
  }
}

my class X::RomanNumerals::NumberTooLarge does X::RomanNumerals {
  method message {
    'Numbers ≥ 4,000,000,000 not supported.';
  }
}

my class X::RomanNumerals::NonPositiveNumber does X::RomanNumerals {
  method message {
    ｢Can't convert number < 1.｣;
  }
}

module RomanNumerals {

  constant @letters   = ｢IVXLCDM｣.comb;
  constant @overlines = "\c[combining overline]", "\c[combining double overline]";
  constant @letter-pairs = reverse @letters[0],
    |('', |@overlines).map( @letters X~ * ).map({
      gather {
        for .rotor(3 => -1) -> @group {
          for 1, 2 {
            take @group[0, $_].join;
            take @group[$_];
          }
        }
      }
    }).flat Z=> ( 1, |( * X* 4, 5, 9, 10 ) … ∞ );

  multi to-roman (
    Int() $number where 0 < * < 4e9,
    --> Str:D
  ) is pure is export {
    given %(@letter-pairs.Map.antipairs) -> %letter-map {
      return [~] gather {
        for $number.flip.comb.pairs.reverse {
          given 10 ** .key -> $key {
            when .value == 4 | 9 {
              take %letter-map{ $key * .value };
            }
            take %letter-map{ $key * 5 } if .value ≥ 5;
            take %letter-map{ $key } x .value % 5;
          }
        }
      };
    }
  }

  multi to-roman ( Int() $_ --> Nil ) {
    when * ≥ 4e9 {
      X::RomanNumerals::NumberTooLarge.new.throw;
    }
    when * < 1 {
      X::RomanNumerals::NonPositiveNumber.new.throw;
    }
  }

  multi from-roman (
    Str() $roman-string,
    --> UInt:D
  ) is pure is export {
    return [+] gather {
      my $str = $roman-string.uc;
      for @letter-pairs -> $pair {
        if $str ~~ / ^ ( $($pair.key) )+ / {
          take ($pair.value xx $0).Slip;
          $str.=substr($0.join.chars);
        }
      }
      X::RomanNumerals::InvalidRomanString.new(:payload($roman-string)).throw if $str;
    }
  }

  multi from-roman (
    Str() $_ where { .chars == 0 || .uc.comb ⊈ @letter-pairs.Hash.keys.join.comb },
    --> Nil
  ) {
    X::RomanNumerals::InvalidRomanString.new(:payload($_)).throw
  }
}
