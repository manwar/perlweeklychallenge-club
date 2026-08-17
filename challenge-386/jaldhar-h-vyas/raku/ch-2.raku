#!/usr/bin/raku

class Fraction {
    has $.numerator;
    has $.denominator;

    method new($rat) {
        self.bless(:$rat);
    }

    submethod BUILD(:$rat) {
        self!parse($rat);
    }

    method !parse($rat) {
        my ($integer, $decimal) = $rat.split('.');
        
        $integer //= '0';
        $decimal //= q{};
        
        my $nonRepeating = q{};
        my $repeating = q{};
        
        if $decimal ~~ /^(.*)\((.*)\)$/ {
            $nonRepeating = $0.Str;
            $repeating = $1.Str;
        } else {
            $nonRepeating = $decimal;
            $repeating = '';
        }
        
        self!makeFraction($integer, $nonRepeating, $repeating);
    }

    method !makeFraction($integer, $nonRepeating, $repeating) {
        my $a = $integer.Int;
        my $n = $nonRepeating.chars;
        my $m = $repeating.chars;
        
        my $numerator;
        my $denominator;
        
        if $m == 0 {
            # No repeating part: a.b = (a * 10^n + b) / 10^n
            my $b = ($nonRepeating || '0').Int;
            $numerator = $a * (10 ** $n) + $b;
            $denominator = 10 ** $n;
        } else {
            # With repeating part: a.b(c)
            # Combine digits: int-part + non-repeating + repeating
            my $full = ($integer ~ $nonRepeating ~ $repeating).Int;
            my $partial = ($integer ~ $nonRepeating).Int;
            
            my $shifts1 = 10 ** $n;
            my $shifts2 = 10 ** ($n + $m);
            
            $numerator = $full - $partial;
            $denominator = $shifts2 - $shifts1;
        }

        my Int $g = $numerator gcd $denominator;
        $!numerator = $numerator div $g;
        $!denominator = $denominator div $g;
    }
}

multi infix:<==> (Fraction $a, Fraction $b) {
    return $a.numerator == $b.numerator && $a.denominator == $b.denominator;
}

sub MAIN(
    $rat1,
    $rat2
) {
    my $fraction1 = Fraction.new($rat1);
    my $fraction2 = Fraction.new($rat2);

    say $fraction1 == $fraction2;
}