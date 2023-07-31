subset Roman-str of Str where $_ ~~ /^<[IVXLCDMivxlcdm]>+$/;

my %rom-tab = < I 1  V 5  X 10  L 50  C 100  D 500  M 1000
               IV 4  IX 9  XL 40  XC 90  CD 400  CM 900 >;
my @ordered_romans = reverse sort { %rom-tab{$_} }, keys %rom-tab;

sub from-roman (Roman-str $roman) {
    my $numeric = 0;
    my $prev_letter = "M";
    for $roman.uc.comb -> $letter {
        $numeric -= 2 * %rom-tab{$prev_letter}
            if %rom-tab{$letter} > %rom-tab{$prev_letter};
        $numeric += %rom-tab{$letter};
        # say "$letter $numeric";
        $prev_letter = $letter;
    }
    return $numeric;
}

sub to-roman (Int $arabic is copy where  { 0 < $_ < 4000 }) {
    my $roman = "";
    for @ordered_romans -> $key {
        my $num = ($arabic / %rom-tab{$key}).Int;
        $roman ~= $key x $num;
        $arabic -= %rom-tab{$key} * $num;
    }
    return $roman;
}
sub process-input (Str $in) {
    my ($rom1, $op, $rom2) = split /\s+/, $in;
    my $arabic1 = from-roman $rom1;
    my $arabic2 = from-roman $rom2;
    my $result;
    given $op {
        when '+' { $result = $arabic1 + $arabic2 }
        when '-' { $result = $arabic1 - $arabic2 }
        when '*' { $result = $arabic1 * $arabic2 }
        when '/' { $result = $arabic1 / $arabic2 }
        when '**' { $result = $arabic1 ** $arabic2 }
    }
    return "nulla (they didn't have a symbol for 0)"
        if $result == 0;
    return "non potest (they didn't do fractions)"
        if $result.round != $result;
    return "non potest (they only went up to 3999)"
        if $result >= 4000;
    return "non potest (no negative numbers)"
        if $result < 0;
    return to-roman $result.round;
}

for "IV + V", "M - I", "X / II", "XI * VI",
  "VII ** III", "V - V", "V / II", "MMM + M",
  "V - X ", "X - V"  -> $test-expr {
    printf "%-10s => ", $test-expr;
    say process-input $test-expr;
}
