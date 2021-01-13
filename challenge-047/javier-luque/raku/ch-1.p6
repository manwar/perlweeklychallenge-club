# Test: perl6 ch1.p6 "V + VI"
use v6.d;

sub MAIN($equation) {
    my %operators = (
        '+' => -> $a , $b { rtoa($a) + rtoa($b) },
        '-' => -> $a , $b { rtoa($a) - rtoa($b) },
        'x' => -> $a , $b { rtoa($a) * rtoa($b) },
        '/' => -> $a , $b { rtoa($a) / rtoa($b) },
    );

    if ($equation ~~ /^(\w+)\s*(\+|\-|x|\/)\s*(\w+)$/) {
        say ator(%operators{$1}($0.Str, $2.Str).Int);
    } else {
        say "Invalid input";
    }
}


# Inspired by:
# https://examples.p6c.dev/categories/euler/prob089-andreoss.html

multi rtoa() { 0 }
multi rtoa(Str $r where $r.chars > 1 ) {
    rtoa(| $r.comb)
}

multi rtoa('I',      |a) { 1   + rtoa(|a) }
multi rtoa('I', 'V', |a) { 4   + rtoa(|a) }
multi rtoa('V',      |a) { 5   + rtoa(|a) }
multi rtoa('I', 'X', |a) { 9   + rtoa(|a) }
multi rtoa('X',      |a) { 10  + rtoa(|a) }
multi rtoa('X', 'L', |a) { 40  + rtoa(|a) }
multi rtoa('L'     , |a) { 50  + rtoa(|a) }
multi rtoa('X', 'C', |a) { 90  + rtoa(|a) }
multi rtoa('C',      |a) { 100 + rtoa(|a) }
multi rtoa('C', 'D', |a) { 400 + rtoa(|a) }
multi rtoa('D',      |a) { 500 + rtoa(|a) }
multi rtoa('C', 'M', |a) { 900 + rtoa(|a) }
multi rtoa('M',      |a) { 1000 + rtoa(|a) }

sub ator(Int $n) returns Str {
    given $n {
        when $n >= 1000 { 'M'  ~ ator($n- 1000) }
        when $n >= 900  { 'CM' ~ ator($n - 900) }
        when $n >= 500  { 'D'  ~ ator($n - 500) }
        when $n >= 400  { 'CD' ~ ator($n- 400) }
        when $n >= 100  { 'C'  ~ ator($n - 100) }
        when $n >= 90   { 'XC' ~ ator($n - 90) }
        when $n >= 50   { 'L'  ~ ator($n - 50) }
        when $n >= 40   { 'XL' ~ ator($n - 40) }
        when $n >= 10   { 'X'  ~ ator($n - 10) }
        when $n >= 9    { 'IX' ~ ator($n- 9) }
        when $n >= 5    { 'V'  ~ ator($n - 5) }
        when $n >= 4    { 'IV' ~ ator($n - 4) }
        when $n >= 1    { 'I'  ~ ator($n - 1) }
        default        { '' }
    }
}
