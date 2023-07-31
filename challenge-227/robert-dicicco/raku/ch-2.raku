#!/usr/bin/env raku
=begin comment
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-25
Challenge 227 Task 2 Roman Maths ( Raku )
--------------------------------------
=end comment
use v6;
use Math::Roman;

my ($left,$right, $op);

if @*ARGS == 0 {
   say "Please enter a math problem using Roman numerals";
   exit(1);
}

for @*ARGS -> $problem {
    my @parts = $problem.split(" ");
    $left = @parts[0];
    $op = @parts[1];
    $right = @parts[2];
}

my $lft = to-arabic($left);
my $rt = to-arabic($right);

if ($lft - $rt == 0) {
    print("$left $op $right est nulla\n");
    exit;
} elsif ($op eq '/' and ($lft % $rt) > 0 ) {
    print("$left $op $right non potest\n");
    exit;
} elsif ($lft + $rt > 3999) {
    print("$left $op $right non potest\n");
    exit;
} elsif ($op eq '-' and ($lft - $rt < 0)) {
    print("$left $op $right non potest\n");
    exit;
}

if ( $op eq '+') {
    say "$left + $right => ",($lft + $rt)R;
} elsif ($op eq '-') {
    say "$left - $right => ",($lft - $rt)R;
} elsif ($op eq '/') {
    say "$left / $right => ",($lft div $rt)R;
} elsif ($op eq '*') {
    say "$left * $right => ",($lft * $rt)R;
} elsif ($op eq '**') {
    say "$left ** $right => ",($lft ** $rt)R;
}

=begin comment
--------------------------------------
SAMPLE OUTPUT
raku .\RomanMath.rk "IV + V"
IV + V => IX

raku .\RomanMath.rk "M - I"
M - I => CMXCIX

raku .\RomanMath.rk "X / II"
X / II => V

raku .\RomanMath.rk "XI * VI"
XI * VI => LXVI

raku .\RomanMath.rk "VII ** III"
VII ** III => CCCXLIII

raku .\RomanMath.rk "V - V"
V - V est nulla

raku .\RomanMath.rk "V / II"
V / II non potest

raku .\RomanMath.rk "MMM + M"
MMM + M non potest

raku .\RomanMath.rk "V - X"
V - X non potest
--------------------------------------
=end comment



