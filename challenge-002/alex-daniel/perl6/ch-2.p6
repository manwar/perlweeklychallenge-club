#| From base 10 to base 35
sub postfix:<₃₅>(Real() $a) { $a.base:       35 }
#| From base 35 to base 10
sub postfix:<₁₀>( Str() $a) { $a.parse-base: 35 }

say ‘ALEXDANIEL’₁₀;
say 836407881643061₃₅;

# You can do non-ints too, but they won't roundtrip as you might expect
