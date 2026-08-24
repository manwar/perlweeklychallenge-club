#!/usr/bin/perl
use 5.40.1;
use feature qw/ class /;
no warnings qw / experimental::class /;

class Fraction {
    field $numerator :reader;
    field $denominator :reader;
    field $rat :param;

    ADJUST {
        $self->parse($rat);
    }

    method parse($rat) {
        my ($integer, $decimal) = split /\./, $rat;
        
        $integer //= '0';
        $decimal //= q{};
        
        my $nonRepeating = q{};
        my $repeating = q{};
        
        if ($decimal =~ /^(.*)\((.*)\)$/) {
            $nonRepeating = $1;
            $repeating = $2;
        } else {
            $nonRepeating = $decimal;
            $repeating = q{};
        }
        
        $self->makeFraction($integer, $nonRepeating, $repeating);
    }

    method makeFraction($integer, $nonRepeating, $repeating) {
        my $a = $integer;
        my $n = length $nonRepeating;
        my $m = length $repeating;
        
        my $num;
        my $den;
        
        if ($m == 0) {
            my $b = $nonRepeating || '0';
            $num = $a * (10 ** $n) + $b;
            $den = 10 ** $n;
        } else {
            my $full = $integer . $nonRepeating . $repeating;
            my $partial = $integer . $nonRepeating;
            
            my $shifts1 = 10 ** $n;
            my $shifts2 = 10 ** ($n + $m);
            
            $num = $full - $partial;
            $den = $shifts2 - $shifts1;
        }

        my $g = $self->gcd($num, $den);
        $numerator = int($num / $g);
        $denominator = int($den / $g);
    }

    method equalTo($other) {
        return $self->numerator == $other->numerator &&
            $self->denominator == $other->denominator;
    }

    method gcd($a, $b) {
        if ($b == 0) {
            return  $a;
        }

        $self->gcd($b, $a % $b);
    }

}

my ($rat1, $rat2) = @ARGV;

my $fraction1 = Fraction->new(rat => $rat1);
my $fraction2 = Fraction->new(rat => $rat2);

say $fraction1->equalTo($fraction2) ? 'true' : 'false';
