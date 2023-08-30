#!/bin/env raku

my @RomanNumerals = <I V X L C D M>;
my %Roman2Digits = @RomanNumerals Z=> +«<1 5 10 50 100 500 1000>;

grammar RomanExpr {
    rule TOP { <Number> <Op> <Number> }
    rule Number { <RomanDigit>+ }

    token RomanDigit { 'I' || 'V' || 'X' || 'L' || 'C' || 'D' || 'M' }
    token Op         { '**' || '+' || '-' || '*' || '/' }
}

# returns sign of the corresponding Roman digit
proto LessThanRight(UInt:D \ndx, *@nums --> Int:D) {*}

multi LessThanRight(\ndx, *@nums where ndx ≥ +@nums - 1) { 1 }

multi LessThanRight(\ndx, *@nums) {
    my $ndx_ = ndx;

    while $ndx_ < +@nums - 1 {
        if @nums[$ndx_] < @nums[$ndx_+1] {
            return -1;
        } elsif @nums[$ndx_] > @nums[$ndx_+1] {
            return 1;
        }

        ++$ndx_;
    }

    1
}

class RomanExprActions {
    method TOP($/) {
        given $<Op> {
            when '+' {
                my $sum = [+] $<Number>».made;
                make $sum ≤ 3999 ?? $sum !! 'non potest'
            }

            when '*' {
                my $prod = [*] $<Number>».made;
                make $prod ≤ 3999 ?? $prod !! 'non potest'
            }

            when '**' {
                my $pow = $<Number>[0].made ** $<Number>[1].made;
                make $pow ≤ 3999 ?? $pow !! 'non potest'
            }

            when '-' {
                my $diff = [-] $<Number>».made;
                given $diff {
                    when 0      { make 'nulla' }
                    when $_ < 0 { make 'non potest' }
                    default     { make $diff }
                }
            }

            when '/' {
                my $quot = $<Number>[0].made div $<Number>[1].made;
                make ($quot * $<Number>[1].made == $<Number>[0].made) ?? $quot !! 'non potest'
            }
        }
    }

    method RomanDigit($/) { make $/.Str }
    method Number($/) {
        my @numbers = %Roman2Digits{$<RomanDigit>».made};
        make [+] (^+@numbers).map({ LessThanRight($_, @numbers) * @numbers[$_] })
    }
}

my %Digits2Roman =
    |([1..9]          Z=> <I II III IV V VI VII VIII IX>).Hash,
    |([1..9] »*» 10   Z=> <X XX XXX XL L LX LXX LXXX XC>).Hash,
    |([1..9] »*» 100  Z=> <C CC CCC CD D DC DCC DCCC CM>).Hash,
    |([1..3] »*» 1000 Z=> <M MM MMM>).Hash;

multi Decimal2Roman(UInt:D $n where 1000 ≤ * ≤ 3999) { %Digits2Roman{$n div 1000 * 1000} ~ Decimal2Roman($n mod 1000) } 
multi Decimal2Roman(UInt:D $n where 100 ≤ * ≤ 999)   { %Digits2Roman{$n div 100 * 100} ~ Decimal2Roman($n mod 100) } 
multi Decimal2Roman(UInt:D $n where 10 ≤ * ≤ 99)     { %Digits2Roman{$n div 10 * 10} ~ Decimal2Roman($n mod 10) } 
multi Decimal2Roman(UInt:D $d where 1 ≤ * ≤ 9)       { %Digits2Roman{$d} } 
multi Decimal2Roman($msg) { $msg } 

multi MAIN('test') {
    use Test;

    is RomanExpr.parse('I',    :rule('Number'), :actions(RomanExprActions)).made, 1,  'I    => 1';
    is RomanExpr.parse('II',   :rule('Number'), :actions(RomanExprActions)).made, 2,  'II   => 2';
    is RomanExpr.parse('III',  :rule('Number'), :actions(RomanExprActions)).made, 3,  'III  => 3';
    is RomanExpr.parse('IV',   :rule('Number'), :actions(RomanExprActions)).made, 4,  'IV   => 4';
    is RomanExpr.parse('V',    :rule('Number'), :actions(RomanExprActions)).made, 5,  'V    => 5';
    is RomanExpr.parse('VI',   :rule('Number'), :actions(RomanExprActions)).made, 6,  'VI   => 6';
    is RomanExpr.parse('VII',  :rule('Number'), :actions(RomanExprActions)).made, 7,  'VII  => 7';
    is RomanExpr.parse('VIII', :rule('Number'), :actions(RomanExprActions)).made, 8,  'VIII => 8';
    is RomanExpr.parse('IX',   :rule('Number'), :actions(RomanExprActions)).made, 9,  'IX   => 9';
    is RomanExpr.parse('X',    :rule('Number'), :actions(RomanExprActions)).made, 10, 'X   => 10';

    is RomanExpr.parse('DCLVIII',   :rule('Number'), :actions(RomanExprActions)).made, 658,  'DCLVIII   =>  658';
    is RomanExpr.parse('M',         :rule('Number'), :actions(RomanExprActions)).made, 1000, 'M         => 1000';
    is RomanExpr.parse('CMXCIX',    :rule('Number'), :actions(RomanExprActions)).made, 999,  'CMXCIX    =>  999';
    is RomanExpr.parse('MMMCMXCIX', :rule('Number'), :actions(RomanExprActions)).made, 3999, 'MMMCMXCIX => 3999';

    is RomanExpr.parse('V + VI',     :actions(RomanExprActions)).made, 11,           'V + VI     =>  11';
    is RomanExpr.parse('IV + V',     :actions(RomanExprActions)).made, 9,            'IV + V     =>   9';
    is RomanExpr.parse('M - I',      :actions(RomanExprActions)).made, 999,          'M - I      => 999';
    is RomanExpr.parse('X / II',     :actions(RomanExprActions)).made, 5,            'X / II     =>   5';
    is RomanExpr.parse('XI * VI',    :actions(RomanExprActions)).made, 66,           'XI * VI    =>  66';
    is RomanExpr.parse('VII ** III', :actions(RomanExprActions)).made, 343,          'VII ** III => 343';
    is RomanExpr.parse('V - V',      :actions(RomanExprActions)).made, 'nulla',      "V - V      => nulla(they knew about zero but didn't have a symbol)";
    is RomanExpr.parse('V / II',     :actions(RomanExprActions)).made, 'non potest', "V / II     => non potest(they didn't do fractions)";
    is RomanExpr.parse('MMM + M',    :actions(RomanExprActions)).made, 'non potest', 'MMM + M    => non potest(they only went up to 3999)';
    is RomanExpr.parse('V - X',      :actions(RomanExprActions)).made, 'non potest', "V - X      => non potest(they didn't do negative numbers)";

    is Decimal2Roman(5),    'V',         '5 => V';
    is Decimal2Roman(3999), 'MMMCMXCIX', '3999 => MMMCMXCIX';

    done-testing;
}

multi MAIN(Str:D $expr) {
    put Decimal2Roman(RomanExpr.parse($expr, :actions(RomanExprActions)).made);
}
