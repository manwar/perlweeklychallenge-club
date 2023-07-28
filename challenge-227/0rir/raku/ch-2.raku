#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

constant \ROMAN-ZERO-MARKER = 'z';

my @roman;
my %roman;
{ use Math::Roman;
    @roman = gather for ^4000 { take ($_)R.Str }
    @roman[0] = ROMAN-ZERO-MARKER;
    %roman = @roman.antipairs;
}

grammar Roman {
    rule TOP { ^ <expression> $ }
    rule expression {
        <lhs=.roman>
        $<op>=( [ '+' | '-' | '*' | '×' | '/'| '÷' | '**' ] )   # ???
        <rhs=.roman>
    }
    token roman { <[IVXLCDM]>+ <?{ %roman{$/} :exists or die 'ERRROMAN' }> }
}

class RomanCalc  {
    method TOP($/) { $/.make:  @roman[ $/.<expression>.made ]; }

    method expression($/) {
        given $<op>.Str.trim {                             # ???
            when '+'  { $/.make: $/.<lhs>.made +  $/.<rhs>.made }
            when "-"  { $/.make: $/.<lhs>.made -  $/.<rhs>.made }
            when '×'  { $/.make: $/.<lhs>.made ×  $/.<rhs>.made }
            when '*'  { $/.make: $/.<lhs>.made ×  $/.<rhs>.made }
            when '/'  { $/.make: $/.<lhs>.made ÷  $/.<rhs>.made }
            when '÷'  { $/.make: $/.<lhs>.made ÷  $/.<rhs>.made }
            when '**' { $/.make: $/.<lhs>.made ** $/.<rhs>.made }
            default   { die 'no match' }
        }
    }
    method roman($/)  { $/.make: %roman{$/.Str} }
}

my @Test = 
    "MMMCMXCIX - I",    'MMMCMXCVIII',
    "IV + V",           "IX",
    "M - I",            "CMXCIX",
    "X / II",           "V",
    "XI * VI",          "LXVI",
    "VII ** III",       "CCCXLIII",
    "V - V",            ROMAN-ZERO-MARKER,
    "II ** II",         "IV",
    "II ** III",        "VIII",
    "II ** IV",         "XVI",
    "II ** V",          "XXXII",
    "II ** VI",         "LXIV",
    "II ** VII",        "CXXVIII",
    "II ** VIII",       "CCLVI",
    "II ** IX",         "DXII",
    "II ** X",          "MXXIV",
    "II ** XI",         "MMXLVIII",
;

sub rocalc( Str $in -->Str) {
    my $m = Roman.parse: $in, :actions(RomanCalc);
    die "dying no match >" ~  $in ~ "<"  unless  $m;
    $m.made;
}

plan @Test ÷ 2;

for @Test -> $in, $exp {
    is rocalc( $in), $exp, "$exp | %roman{$exp} <- $in" ;
}

print "\n";
for @Test[0,2,4,6,8,10,12] -> $input {
    printf "%-13s => %s\n", $input, rocalc( $input);
}

=finish
277-2: Roman Maths  Submitted by: Peter Campbell Smith
Write a script to handle a 2-term arithmetic operation expressed in Roman
numeral.

Example
IV + V     => IX
M - I      => CMXCIX
X / II     => V
XI * VI    => LXVI
VII ** III => CCCXLIII
V - V      => nulla (they knew about zero but didn't have a symbol)
V / II     => non potest (they didn't do fractions)
MMM + M    => non potest (they only went up to 3999)
V - X      => non potest (they didn't do negative numbers)


