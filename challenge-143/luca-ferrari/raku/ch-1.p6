#!raku


my Str $OPERATOR_ADD      = '+';
my Str $OPERATOR_MINUS    = '-';
my Str $OPERATOR_MULTIPLY = '*';
my Str $OPERATOR_DIVIDE   = '/';




grammar Calculator {
    rule TOP {
        ^ <expression> $
    }

    rule expression {
        | <operation>+ %% $<operator>=([$OPERATOR_ADD|$OPERATOR_MINUS])
        | <parenthesized-expression>
    }
    rule operation {
        <operand>+  %% $<operator>=([$OPERATOR_MULTIPLY|$OPERATOR_DIVIDE])
    }

    rule operand {
        | <number>
        | <parenthesized-expression>
    }

    rule parenthesized-expression {
        '(' <expression> ')'
    }

    token number { \d+ }
}


class CalculatorActions {
    method TOP($/) {
        $/.make: $<expression>.made
    }


    method parenthesized-expression($/) {
        $/.make: $<expression>.made
    }

    method number($/) {
        $/.make: +$/
    }


    method operand($/) {
        $/.make: $<number> ?? $<number>.Int !! $<parenthesized-expression>.made;
    }


    # Computes a single operation in the form
    # a + b
    method do-compute( $left-operand, $operator, $right-operand ) {
        given $operator {
            when $OPERATOR_ADD      { $left-operand + $right-operand }
            when $OPERATOR_MINUS    { $left-operand - $right-operand }
            when $OPERATOR_MULTIPLY { $left-operand * $right-operand }
            when $OPERATOR_DIVIDE   { $left-operand / $right-operand }
        }
    }


    # Computes all the operation given the first operand, the set of operators
    # and the other operands.
    # For example:
    # 1 + 2 * 3
    # becomes
    # do-compute-all( 1, [+,*], [2,3])
    method do-compute-all( $left-operand is rw, @operators, @operands ) {
        while ( @operators.elems > 0 ) {
            $left-operand = self.do-compute( $left-operand,
                                             @operators.pop,
                                             @operands.pop );
        }
    }

    method operation($/) {
        # left part
        my $result = $<operand>[ 0 ].made;

        # if there is a right part ...
        if $<operator> {
            my @operators = $<operator>.map( *.Str );
            my @operands  = $<operand>[ 1..* ].map( *.made );

            self.do-compute-all( $result, @operators, @operands );
        }

        $/.make: $result;
    }



    method expression($/) {
        if $<parenthesized-expression> {
            $/.make: $<parenthesized-expression>.made
        }
        else {
            my $result = $<operation>[ 0 ].made;     

            if $<operator> {
                my @operators = $<operator>.map( *.Str );
                my @operands  = $<operation>[ 1..* ].map( *.made );

                self.do-compute-all( $result, @operators, @operands );

            }

            $/.make: $result;
        }
    }
}

sub MAIN( Str $expr ) {
    my $calculator = Calculator.parse( $expr, :actions( CalculatorActions ) );
    "{ $expr } = { $calculator.made }".say;
}
