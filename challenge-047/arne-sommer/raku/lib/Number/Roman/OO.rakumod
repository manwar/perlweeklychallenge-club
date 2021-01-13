use v6;

use Number::Roman :to, :from;

unit class Number::Roman::OO;

has Int $.value;

multi method new (Str $string) { self.bless(value => from-roman($string)) }
multi method new($value)       { self.bless(:$value)                      }

multi method add (Number::Roman::OO:D $obj) { return self.new(self.value + $obj.Int) }
multi method add (Int $int) { return self.new(self.value - $int) }

multi method sub (Number::Roman::OO:D $obj) { return self.new(self.value + $obj.Int) }
multi method sub (Int $int) { return self.new(self.value - $int) }

multi method mul (Number::Roman::OO:D $obj) { return self.new(self.value * $obj.Int) }
multi method mul (Int $int) { return self.new(self.value * $int) }

multi method div (Number::Roman::OO:D $obj) { return self.new(Int(self.value / $obj.Int)) }
multi method div (Int $int) { return self.new(Int(self.value / $int)) }

method Str  { to-roman(self.value) }
method gist { to-roman(self.value) }
method Int  { self.value }
method Real { self.value }

multi sub infix:<+> (Number::Roman::OO:D $a, Number::Roman::OO:D $b) is export
{
  Number::Roman::OO.new($a.Int + $b.Int);
}

multi sub infix:<+> (Number::Roman::OO:D $a, Int:D $b)
{
  Number::Roman::OO.new($a.Int + $b);
}

multi sub infix:<-> (Number::Roman::OO:D $a, Number::Roman::OO:D $b) is export
{
  Number::Roman::OO.new($a.Int - $b.Int);
}

multi sub infix:<-> (Number::Roman::OO:D $a, Int:D $b)
{
  Number::Roman::OO.new($a.Int - $b);
}

multi sub infix:<*> (Number::Roman::OO:D $a, Number::Roman::OO:D $b) is export
{
  Number::Roman::OO.new($a.Int * $b.Int);
}

multi sub infix:<*> (Number::Roman::OO:D $a, Int:D $b)
{
  Number::Roman::OO.new($a.Int * $b);
}

multi sub infix:</> (Number::Roman::OO:D $a, Number::Roman::OO:D $b) is export
{
  Number::Roman::OO.new(Int($a.Int / $b.Int));
}

multi sub infix:</> (Number::Roman::OO:D $a, Int:D $b)
{
  Number::Roman::OO.new(Int($a.Int / $b));
}
