#!/usr/bin/env perl6
      
grammar Roman2Arabic {
    token TOP {
        :my Int $*Arabic;
        <Thousands>? <Hundreds>? <Tens>? <Ones>?
    }

    token Thousands { [M ** 1..3] }

    token Hundreds  { [C [C ** 1..2|D|M]?] || [D [C ** 1..3]?] }

    token Tens      { [X [X ** 1..2|C|L]?] || [L [X ** 1..3]?] }

    token Ones      { [I [I ** 1..2|V|X]?] || [V [I ** 1..3]?] }
}

grammar Arabic2Roman {
    token TOP       { 
        :my Str $*Roman; 
        <Thousands>? <Hundreds>? <Tens>? <Ones> 
    }

    token Thousands { <[123]> <?before \d ** 3> }

    token Hundreds  { \d <?before \d ** 2> }

    token Tens      { \d <?before \d> }

    token Ones      { \d }
}

class Roman2ArabicActions {
    method TOP ($/) {
        make $*Arabic;
    }

    method Thousands ($/) {
        $*Arabic = 1000 * $/.chars;
    }

    method Hundreds ($/) {
        given $/ {
            when "CM"   { $*Arabic += 900 }
            when "DCCC" { $*Arabic += 800 } 
            when "DCC"  { $*Arabic += 700 }
            when "DC"   { $*Arabic += 600 }
            when "D"    { $*Arabic += 500 }
            when "CD"   { $*Arabic += 400 }
            when "CCC"  { $*Arabic += 300 }
            when "CC"   { $*Arabic += 200 }
            when "C"    { $*Arabic += 100 }
        }
    }

    method Tens ($/) {
        given ($/) {
            when "XC"   { $*Arabic += 90 }
            when "LXXX" { $*Arabic += 80 } 
            when "LXX"  { $*Arabic += 70 }
            when "LX"   { $*Arabic += 60 }
            when "L"    { $*Arabic += 50 }
            when "XL"   { $*Arabic += 40 }
            when "XXX"  { $*Arabic += 30 }
            when "XX"   { $*Arabic += 20 }
            when "X"    { $*Arabic += 10 }
        }
    }

    method Ones ($/) {
        given ($/) {
            when "IX"   { $*Arabic += 9 }
            when "VIII" { $*Arabic += 8 } 
            when "VII"  { $*Arabic += 7 }
            when "VI"   { $*Arabic += 6 }
            when "V"    { $*Arabic += 5 }
            when "IV"   { $*Arabic += 4 }
            when "III"  { $*Arabic += 3 }
            when "II"   { $*Arabic += 2 }
            when "I"    { $*Arabic += 1 }
        }
    }
}
    
class Arabic2RomanActions {
    method TOP ($/) { 
        make $*Roman; 
    } 

    method Thousands ($/) {
        $*Roman = "M" x $/.Str;
    }

    method Hundreds ($/) {
        given $/ {
            when 9 { $*Roman ~= "CM"   }
            when 8 { $*Roman ~= "DCCC" }
            when 7 { $*Roman ~= "DCC"  }
            when 6 { $*Roman ~= "DC"   }
            when 5 { $*Roman ~= "D"    }
            when 4 { $*Roman ~= "CD"   }
            when 3 { $*Roman ~= "CCC"  }
            when 2 { $*Roman ~= "CC"   }
            when 1 { $*Roman ~= "C"    }
        } 
    }

    method Tens ($/) {
        given $/ {
            when 9 { $*Roman ~= "XC" }
            when 8 { $*Roman ~= "LXXX" }
            when 7 { $*Roman ~= "LXX" }
            when 6 { $*Roman ~= "LX" }
            when 5 { $*Roman ~= "L"  }
            when 4 { $*Roman ~= "XL" }
            when 3 { $*Roman ~= "XXX" }
            when 2 { $*Roman ~= "XX" }
            when 1 { $*Roman ~= "X"  }
        }
    }
    
    method Ones ($/) {
        given $/ {
            when 9 { $*Roman ~= "IX" }
            when 8 { $*Roman ~= "VIII" }
            when 7 { $*Roman ~= "VII" }
            when 6 { $*Roman ~= "VI" }
            when 5 { $*Roman ~= "V"  }
            when 4 { $*Roman ~= "IV" }
            when 3 { $*Roman ~= "III" }
            when 2 { $*Roman ~= "II" }
            when 1 { $*Roman ~= "I"  }
        }
    }
}

grammar Calculator {
    has Arabic2Roman $.a2r;
    has Roman2Arabic $.r2a;

    rule  TOP      { <Roman> <Operator> <Roman> }

    token Roman    { <[IVXLCDM]>+ }
 
    token Operator { <[+x/-]> }
}

class CalculatorActions {
    method TOP ($/ is copy) { 
        my $calc = $/;

        my $answer;

        my $i1 = $calc.r2a.parse($calc<Roman>[0], 
                                 :actions(Roman2ArabicActions)).made; 

        my $i2 = $calc.r2a.parse($calc<Roman>[1], 
                                 :actions(Roman2ArabicActions)).made; 

        given $calc<Operator> {
            when "+" { $answer = $i1 + $i2 }
            when "-" { $answer = $i1 - $i2 }
            when "x" { $answer = $i1 * $i2 }
            when "/" { $answer = $i1 / $i2 }
        }

        $calc.make($calc.a2r.parse($answer, 
                   :actions(Arabic2RomanActions)).made);
    }
}

sub MAIN(*@args) {
    Calculator.parse(@args.Str, :actions(CalculatorActions)).made.say;
}
