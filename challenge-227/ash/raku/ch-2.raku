# Solution to the Task 1 of the Weekly Challenge 227
# https://theweeklychallenge.org/blog/perl-weekly-challenge-227/#TASK1

# Explanations: 
# https://andrewshitov.com/2023/07/24/calculator-with-roman-numbers-in-raku/

# Test run:
# $ raku ch-2.raku
# IV + V => (9) IX
# M - I => (999) CMXCIX
# X / II => (5) V
# XI * VI => (66) LXVI
# VII ** III => (343) CCCXLIII
# V - V => (0) nulla (they knew about zero but didn't have a symbol)
# V / II => (2.5) non potest (they didn't do fractions)
# MMM + M => (4000) non potest (they only went up to 3999)
# V - X => (-5) non potest (they didn't do negative numbers)

grammar RomanArithmetics {
    rule TOP {
        <roman-number> <op> <roman-number> {
            my $n1 = $<roman-number>[0].made;
            my $n2 = $<roman-number>[1].made;

            my $n;
            given ~$<op> {
                when '+'  {$n = $n1 +  $n2}
                when '-'  {$n = $n1 -  $n2}
                when '*'  {$n = $n1 *  $n2}
                when '/'  {$n = $n1 /  $n2}
                when '**' {$n = $n1 ** $n2}
            }

            $/.make($n)
        }
    }

    token op {
        '+' | '-' | '*' | '/' | '**'
    }

    token roman-number {
        <thousands>? <hundreds>? <tens>? <ones>? {
            $/.make(
                ($<thousands>.made // 0) +
                ($<hundreds>.made  // 0) +
                ($<tens>.made      // 0) +
                ($<ones>.made      // 0)
            )
        }
    }

    token thousands {
        | M    { $/.make(1000) }   | MM   { $/.make(2000) }
        | MMM  { $/.make(3000) }   | MMMM { $/.make(4000) }
    }

    token hundreds {
        | C    { $/.make(100) }    | CC   { $/.make(200) }
        | CCC  { $/.make(300) }    | CD   { $/.make(400) }
        | D    { $/.make(500) }    | DC   { $/.make(600) }
        | DCC  { $/.make(700) }    | DCCC { $/.make(800) }
        | CM   { $/.make(900) }
    }

    token tens {
        | X    { $/.make(10) }     | XX   { $/.make(20) }
        | XXX  { $/.make(30) }     | XL   { $/.make(40) }
        | L    { $/.make(50) }     | LX   { $/.make(60) }
        | LXX  { $/.make(70) }     | LXXX { $/.make(80) }
        | XC   { $/.make(90) }
    }

    token ones {
        | I    { $/.make(1) }      | II   { $/.make(2) }
        | III  { $/.make(3) }      | IV   { $/.make(4) }
        | V    { $/.make(5) }      | VI   { $/.make(6) }
        | VII  { $/.make(7) }      | VIII { $/.make(8) }
        | IX   { $/.make(9) }
    }
}

sub to-roman($n is copy) {
    state @roman = 
        1000 => < M MM MMM >,
        100 => < C CC CCC CD D DC DCC DCCC CM >,
        10  => < X XX XXX XL L LX LXX LXXX XC >,
        1   => < I II III IV V VI VII VIII IX >;

    my $roman;

    for @roman -> $x {
        my $digit = ($n / $x.key).Int; 
        $roman ~= $x.value[$digit - 1] if $digit;
        $n %= $x.key;
    }

    return $roman;
}

sub compute($input) {
    my $answer = RomanArithmetics.parse($input).made;

    my $output = "$input => ($answer) ";

    if $answer != $answer.round {
        $output ~= "non potest (they didn't do fractions)";
    }
    elsif $answer >= 4000 {
        $output ~= "non potest (they only went up to 3999)";
    }
    elsif $answer == 0 {
        $output ~= "nulla (they knew about zero but didn't have a symbol)";
    }
    elsif $answer < 0 {
        $output ~= "non potest (they didn't do negative numbers)";
    }
    else {
        $output ~= to-roman($answer);
    }

    return $output;
}

my @test-cases =
    'IV + V',
    'M - I',
    'X / II',
    'XI * VI',
    'VII ** III',
    'V - V',
    'V / II',
    'MMM + M',
    'V - X'
;

say compute($_) for @test-cases;
