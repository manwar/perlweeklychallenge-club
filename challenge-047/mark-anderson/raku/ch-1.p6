#!/usr/bin/env perl6

grammar Calculator {
    rule TOP {
        <Roman> <operator> <Roman> {
            my $integer;
            my $i1 = Roman_to_integer($<Roman>[0].Str, 0);
            my $i2 = Roman_to_integer($<Roman>[1].Str, 0);

            given $<operator> {
                when '+' { $integer = $i1 + $i2 }
                when '-' { $integer = $i1 - $i2 }
                when 'x' { $integer = $i1 * $i2 }
                when '/' { $integer = $i1 / $i2 }
            }

            say integer_to_Roman($integer.Int, q{});
        }
    }

    token Roman {
        <[IVXLCDM]>+
    }
 
    token operator {
        <[+x/-]>
    }
}

sub Roman_to_integer(Str $str is copy, Int $int is copy) {
    given $str {
        when * ~~ /^M/  { $int += 1000; $str .= subst(/^M/ , q{}) }
        when * ~~ /^CM/ { $int += 900;  $str .= subst(/^CM/, q{}) }
        when * ~~ /^D/  { $int += 500;  $str .= subst(/^D/ , q{}) }
        when * ~~ /^CD/ { $int += 400;  $str .= subst(/^CD/, q{}) }
        when * ~~ /^C/  { $int += 100;  $str .= subst(/^C/ , q{}) }
        when * ~~ /^XC/ { $int += 90;   $str .= subst(/^XC/, q{}) }
        when * ~~ /^L/  { $int += 50;   $str .= subst(/^L/ , q{}) }
        when * ~~ /^XL/ { $int += 40;   $str .= subst(/^XL/, q{}) }
        when * ~~ /^X/  { $int += 10;   $str .= subst(/^X/ , q{}) }
        when * ~~ /^IX/ { $int += 9;    $str .= subst(/^IX/, q{}) }
        when * ~~ /^V/  { $int += 5;    $str .= subst(/^V/ , q{}) }
        when * ~~ /^IV/ { $int += 4;    $str .= subst(/^IV/, q{}) }
        when * ~~ /^I/  { $int += 1;    $str .= subst(/^I/ , q{}) }
    }

    return $int unless $str;

    Roman_to_integer($str, $int); 
}
            
sub integer_to_Roman(Int $int is copy, Str $str is copy) {
    given $int {
        when * >= 1000 { $str ~= "M" ; $int -= 1000 }
        when * >= 900  { $str ~= "CM"; $int -= 900  }
        when * >= 500  { $str ~= "D" ; $int -= 500  }
        when * >= 400  { $str ~= "CD"; $int -= 400  } 
        when * >= 100  { $str ~= "C" ; $int -= 100  }
        when * >= 90   { $str ~= "XC"; $int -= 90   }
        when * >= 50   { $str ~= "L" ; $int -= 50   }
        when * >= 40   { $str ~= "XL"; $int -= 40   }
        when * >= 10   { $str ~= "X" ; $int -= 10   }
        when * >= 9    { $str ~= "IX"; $int -= 9    }
        when * >= 5    { $str ~= "V" ; $int -= 5    }
        when * >= 4    { $str ~= "IV"; $int -= 4    }
        when * >= 1    { $str ~= "I" ; $int -= 1    }
    }

    return $str unless $int;

    integer_to_Roman($int, $str);
}

sub MAIN(*@args) {
    Calculator.parse(@args.Str);
}
