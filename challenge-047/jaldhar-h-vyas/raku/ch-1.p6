#!/usr/bin/perl6

sub unprefix(Str $num) {
    my $unprefixed = $num;
    my @from = qw/ CM    CD   XC    XL   IX    IV   /;
    my @to =   qw/ DCCCC CCCC LXXXX XXXX VIIII IIII /;

    for 0 ..^ @from.elems -> $i {
        $unprefixed = $unprefixed.subst(@from[$i], @to[$i], :g);
    }

    return $unprefixed;
}

sub reorder(Str $num) {
    my %order = (
        'M' => 0, 'D' => 1, 'C' => 2, 'L' => 3, 'X' => 4, 'V' => 5, 'I' => 6
    );

    return $num.comb.sort({ %order{$^a} <=> %order{$^b} }).join; 
}

sub normalize(Str $num) {
    my $normalized = $num;
    my @from = qw/ IIIII IIII VV VIV XXXXX XXXX LL LXL CCCCC CCCC DD DCD /;
    my @to =   qw/ V     IV   X  IX  L     XL   C  XC  D     CD   M  CM  /;

    for 0 ..^ @from.elems -> $i {
        $normalized = $normalized.subst(@from[$i], @to[$i], :g);
    }

    return $normalized;
}

sub substrings(Str $num) {
    my %substrings;

    for 0 ..^ $num.chars -> $i {
        for 1 .. $num.chars - $i -> $j {
            my $ss = $num.substr($i, $j);
            %substrings{$ss}++;
        }
    }

    return %substrings.keys.sort({ $^b.chars <=> $^a.chars });
}

sub removeCommon(Str $num1, Str $num2) {
    my $n1 = $num1;
    my $n2 = $num2;

    for substrings($n1) -> $ss {
        if $n1 ~~ /$ss/ && $n2 ~~ /$ss/ {
            $n1 ~~ s/$ss//;
            $n2 ~~ s/$ss//;
        }
    }

    return ($n1, $n2);
}

sub largestOrder(Str $num1, Str $num2) {
    my $n1 = $num1;
    my %order = (
        'M' => 0, 'D' => 1, 'C' => 2, 'L' => 3, 'X' => 4, 'V' => 5, 'I' => 6
    );
    my @reverseOrder = qw/ M D C L X V I /;
    my %expansion = (
        'M' => 'DCCCCC', 'D' => 'CCCCC', 'C' => 'LXXXXX', 'L' => 'XXXXX',
        'X' => 'VIIIII', 'V' => 'IIIII', 'I' => q{}
    );

    my $first = $num2.substr(0, 1);
    if $first {
        my $i = ($first eq 'M') ?? 0 !! %order{$first} - 1;
        while $i >= 0 && !$num1.match(@reverseOrder[$i]) {
            $i--;
        } 
        $n1 = $num1.subst(@reverseOrder[$i], %expansion{@reverseOrder[$i]});
    }

    return (reorder($n1), $num2);
}

multi sub MAIN(
    Str $num1, #= Number in Roman numerals
    Str $op where { /\+/ || /\-/ }, #= Arithmetic operation (+ or -)
    Str $num2, #= Number in Roman numerals
    ) {
    if $op eq '+' {

        say normalize(reorder(unprefix($num1) ~ unprefix($num2)));

    } elsif $op eq '-' {

        my $un1 = unprefix($num1);
        my $un2 = unprefix($num2);

        while ($un2.chars) {
            ($un1, $un2) = largestOrder(|removeCommon($un1, $un2));
        }

        say normalize($un1);
    }
}