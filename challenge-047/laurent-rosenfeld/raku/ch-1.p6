use v6;
use MONKEY-SEE-NO-EVAL;

subset Roman-str of Str where $_ ~~ /^<[IVXLCDMivxlcdm]>+$/;

my %rom-tab = < I 1   V 5   X 10   L 50   C 100  D 500  M 1000
               IV 4  IX 9   XL 40  XC 90  CD 400   CM 900 >;
my @ordered_romans = reverse sort { %rom-tab{$_} }, keys %rom-tab;

sub from-roman (Roman-str $roman) {
    my $numeric = 0;
    my $prev_letter = "M";
    for $roman.uc.comb -> $letter {
        $numeric -= 2 * %rom-tab{$prev_letter}
            if %rom-tab{$letter} > %rom-tab{$prev_letter};
        $numeric += %rom-tab{$letter};
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

my @input;
for @*ARGS {
    push @input, $_ if /<[-+*\/]>/;
    push @input, from-roman $_ if m:i/<[ivxlcdm]>+/;
}
die "Need at least three parameters" if @input < 3; # we need at least 1 operator and two operands
my $result = EVAL join ' ', @input;
say "@*ARGS[] = ", to-roman $result;
