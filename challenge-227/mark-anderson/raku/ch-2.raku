#!/usr/bin/env raku
use MONKEY-SEE-NO-EVAL;
use Test;

is roman-maths('IV + V'),     'IX';
is roman-maths('M - I'),      'CMXCIX';
is roman-maths('X / II'),     'V';
is roman-maths('XI * VI'),    'LXVI';
is roman-maths('VII ** III'), 'CCCXLIII';
is roman-maths('V - V'),      'nulla';
is roman-maths('V / II'),     'non potest';
is roman-maths('MMM + M'),    'non potest';
is roman-maths('V - X'),      'non potest';

sub roman-maths($s)
{
    my ($a, $op, $b) = $s.split(/\s+/);

    given EVAL "{r2a($a)} $op {r2a($b)}"
    {
        when 0  { 'nulla' }
        when    any($_ > 3999, .narrow !~~ UInt) { 'non potest' }
        default { a2r($_) }
    }
}

sub a2r($a)
{
    my @a = $a.polymod(10 xx 3);

    my @r = [ flat q{}, <I II III IV V VI VII VIII IX> ],
            [ flat q{}, <X XX XXX XL L LX LXX LXXX XC> ],
            [ flat q{}, <C CC CCC CD D DC DCC DCCC CM> ],
            [ flat q{}, <M MM MMM> ];

    (3...0).map({ @r[$_; @a[$_]] }).join
}

sub r2a($r)
{
    grammar Roman
    {
        has $.arabic is rw;

        token TOP 
        { 
            <thousands>? <nine-hundred>? <five-hundred>? <four-hundred>?  
            <hundreds>?  <ninety>?       <fifty>?        <forty>?         
            <tens>?      <nine>?         <five>?         <four>? 
            <ones>?  
        }
    
        token thousands    { M+ { $.arabic += $/.chars * 1000 } }
        token nine-hundred { CM { $.arabic += 900             } }
        token five-hundred { D  { $.arabic += 500             } }
        token four-hundred { CD { $.arabic += 400             } }
        token hundreds     { C+ { $.arabic += $/.chars * 100  } }
        token ninety       { XC { $.arabic += 90              } }
        token fifty        { L  { $.arabic += 50              } }
        token forty        { XL { $.arabic += 40              } }
        token tens         { X+ { $.arabic += $/.chars * 10   } }
        token nine         { IX { $.arabic += 9               } }
        token five         { V  { $.arabic += 5               } }
        token four         { IV { $.arabic += 4               } }
        token ones         { I+ { $.arabic += $/.chars        } } 
    }
    
    Roman.parse($r).arabic
}
