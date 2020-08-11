my $digitstr = "123456789";
my @digits = split("", $digitstr, :skip-empty);
my $n = @digits.elems;
my $target = 100;

grammar Evaluate {
  token TOP {<INT> | <INT> <TOP>}
  token INT {<[+-]>?\d+}
}

class Calc {
  method TOP ($/) {make ($<TOP>.made || 0) + $<INT>.made}
  method INT ($/) {make $/.Str.Num}
}

sub infix:<~->(Str $x, Str $y){$y~$x};

my $c = -1;

for ([X~] [$@(@digits[0])].Array.append($((@digits[1 .. $n-1])>>.Str X[~-] ("", "+", "-"))[++$c*3 .. $c*3 +2] xx $n-1)) -> $str {
  if Evaluate.parse($str, actions => Calc).made == $target {
    say $str;
    #last;
  }
}
