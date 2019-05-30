unit module RomanNumerals;

constant @letters   = ｢IVXLCDM｣.comb;
constant @overlines = "\c[combining overline]", "\c[combining double overline]";

constant %letter-map = ( 1, |( * X* 5, 10 ) … ∞ ) Z=>
  |@letters, |( @overlines XR~ @letters[1..*] );

constant %prefixes = %letter-map{ 10 X** 3, 6 } Z=> ( %letter-map<1> X~ @overlines );

sub to-roman (
  UInt() $_ where 0 < * < 4e9,
  --> Str:D
) is pure is export {
  return [~] gather {
    for .flip.comb.pairs.reverse {
      given 10 ** .key -> $key {
        when .value == 4 | 9 {
          take %prefixes{ %letter-map{$key} } || %letter-map{$key};
          take %letter-map{ $key * (.value + 1) };
        }
        if .value ≥ 5 {
          take %letter-map{ $key * 5 };
        }
        take %letter-map{ $key } x .value % 5;
      }
    }
  };
}
