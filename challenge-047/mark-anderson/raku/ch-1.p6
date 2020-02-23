#!/usr/bin/env perl6
      
grammar Roman2Arabic {
    token TOP {
        :my $*Arabic;

        <Thousands>? <Hundreds>? <Tens>? <Ones>?
    }

    token Thousands { [M ** 1..3] }

    token Hundreds  { [C [C ** 1..2|D|M]?] || [D [C ** 1..3]?] }

    token Tens      { [X [X ** 1..2|C|L]?] || [L [X ** 1..3]?] }

    token Ones      { [I [I ** 1..2|V|X]?] || [V [I ** 1..3]?] }
}

grammar Arabic2Roman {
    token TOP       { 
        :my $*Roman; 

        <Thousands>? <Hundreds>? <Tens>? <Ones>? 
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
        state %lookup = <C CC CCC CD D DC DCC DCCC CM> Z=> [1 .. 9];
        $*Arabic += %lookup{ $/ } * 100;
    }

    method Tens ($/) {
        state %lookup = <X XX XXX XL L LX LXX LXXX XC> Z=> [1 .. 9];
        $*Arabic += %lookup{ $/ } * 10;
    }

    method Ones ($/) {
        state %lookup = <I II III IV V VI VII VIII IX> Z=> [1 .. 9];
        $*Arabic += %lookup{ $/ };
    }
}
    
class Arabic2RomanActions {
    method TOP ($/) { 
        make $*Roman; 
    } 

    method Thousands ($/) {
        $*Roman = "M" x $/;
    }

    method Hundreds ($/) {
        state @lookup = (q{}, <C CC CCC CD D DC DCC DCCC CM>).flat;
        $*Roman ~= @lookup[ $/ ];
    }

    method Tens ($/) {
        state @lookup = (q{}, <X XX XXX XL L LX LXX LXXX XC>).flat;
        $*Roman ~= @lookup[ $/ ];
    }
    
    method Ones ($/) {
       state @lookup = (q{}, <I II III IV V VI VII VIII IX>).flat; 
       $*Roman ~= @lookup[ $/ ];
    }
}

grammar Calculator {
    rule  TOP      { 
        :my @*Arabics; 
        :my $*Answer;
        :my $*Operator;

        <Roman> <Operator> <Roman> 
    }

    token Roman    { <[I V X L C D M]>+ }
 
    token Operator { <[+ x / -]> }
}

class CalculatorActions {
    method TOP ($/) { 
        make $*Answer if $*Answer;
    }

    method Roman ($match) {
        push(@*Arabics, Roman2Arabic.parse($match, :actions(
                        Roman2ArabicActions)).made); 
        
        if ($*Operator) {
            given $*Operator {
                when "+" { $*Answer = [+] @*Arabics }
                when "-" { $*Answer = [-] @*Arabics }
                when "x" { $*Answer = [*] @*Arabics }
                when "/" { $*Answer = [/] @*Arabics }
            }
        
            $*Answer = Arabic2Roman.parse($*Answer, :actions(
                       Arabic2RomanActions)).made;
        }
    }

    method Operator ($/) {
        $*Operator = $/;
    }
}

sub MAIN(*@args) {
    Calculator.parse(@args.Str, :actions(CalculatorActions)).made.say;
}
