#!/usr/bin/raku

sub unprefix(Str $num) {
    my $unprefixed = $num;
    my @from = qw/ CM    CD   XC    XL   IX    IV   /;
    my @to =   qw/ DCCCC CCCC LXXXX XXXX VIIII IIII /;

    for 0 ..^ @from.elems -> $i {
        $unprefixed = $unprefixed.subst(@from[$i], @to[$i], :g);
    }

    return $unprefixed;
}

sub normalize(Str $num) {
    my $normalized = $num;
    my @from = qw/ IIIII IIII VV VIV XXXXX XXXX LL LXL CCCCC CCCC DD DCD /;
    my @to =   qw/ V     IV   X  IX  L     XL   C  XC  D     CD   M  CM  /;

    for 0 .. @from.end -> $i {
        $normalized = $normalized.subst(@from[$i], @to[$i], :g);
    }

    return $normalized;
}

sub toEnglish($num) {
    my %values = (
        'M' => 1000,
        'D' => 500,
        'C' => 100,
        'L' => 50,
        'X' => 10,
        'V' => 5,
        'I' => 1,
    );

    my $english = 0;

    for unprefix($num).comb -> $digit {
        $english += %values{$digit};
    }

    return $english;
}

sub toRoman($num is copy) {
    my $roman;

    while $num > 0 {
        if $num >= 1000 {
            $roman ~= 'M';
            $num -= 1000;
        }
        elsif $num >= 500 {
            $roman ~= 'D';
            $num -= 500;
        }
        elsif $num >= 100 {
            $roman ~= 'C';
            $num -= 100;
        }
        elsif $num >= 50 {
            $roman ~= 'L';
            $num -= 50;
        }
        elsif $num >= 10 {
            $roman ~= 'X';
            $num -= 10;
        }
        elsif $num >= 5 {
            $roman ~= 'V';
            $num -= 5;
        }
        elsif $num >= 1 {
            $roman ~= 'I';
            $num -= 1;
        }
    }

    return normalize($roman);
}

sub MAIN(
    Str $arg1, #= Number in Roman numerals
    Str $op,   #= Arithmetic operation (+, -, *, / or **)
    Str $arg2, #= Number in Roman numerals
) {
    my $val;
    my $eng1 = toEnglish($arg1);
    my $eng2 = toEnglish($arg2);

    given $op {
        when '+'  { $val = $eng1 + $eng2; }
        when '-'  { $val = $eng1 - $eng2; }
        when '*'  { $val = $eng1 * $eng2; }
        when '/'  { $val = $eng1 / $eng2; }
        when '**' { $val = $eng1 ** $eng2; }
        default   {  &*USAGE(); }
    }

    given $val {
        when $_ == 0      { say 'nulla'; }
        when $_ != $_.Int { say 'non potest'; }
        when $_ <= 0      { say 'non potest'; }
        when $_ >= 4000   { say 'non potest'; }
        default           { say toRoman($val); }
    }

}