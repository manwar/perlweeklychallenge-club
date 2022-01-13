#!/usr/bin/raku
# use Grammar::Tracer;

grammar Calculator {
    rule TOP { <expression> }

    rule expression {
        <term>+ % $<op>=(['+'|'-'])
    }

    rule group { '(' <expression> ')' }

    rule term { <factor>+ % '*' }

    rule factor { <number> | <group> }

    token number { '-'?\d+ ('.' \d+)? }
}

class CalculatorActions {
    method TOP($/) {
        make($<expression>.made);
    }

    method expression($/) {
        my $result = $<term>.shift.made;

        if ($<op>) {
            my @ops = $<op>.map({ $_.Str; });
            my @values = $<term>.map({ $_.made; });
 
            for @ops -> $op {
                given $op {
                    when '+' { $result += @values.shift; }
                    when '-' { $result -= @values.shift; }
                }
            }
        }

        make($result);
    }

    method group($/) {
        make($<expression>.made);
    }

    method term($/) {
        make([*] $<factor>.map({ $_.made; }));
    }

    method number($/) {
        make $/.Num;
    }

    method factor($/) {
        make($<number> ?? $<number>.made !! $<group>.made);
    }
}

sub MAIN(Str $expression) {
    say Calculator.parse($expression, actions => CalculatorActions.new ).made;
}