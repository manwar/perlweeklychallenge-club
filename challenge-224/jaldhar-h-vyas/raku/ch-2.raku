#!/usr/bin/raku

# Checks whether num is valid or not, by checking first character and size
sub isValid($num) {
    return $num.chars < 2 || $num.substr(0, 1) != '0';
}

# returns int value at pos string, if pos is out of bound then returns 0
sub val($a, $pos) {
    if $pos < 0 || $pos >= $a.chars {
        return 0;
    }

    return $a.substr($pos, 1).Int;
}

sub checkAddition(@res, $a, $b, $c) {
    if !isValid($a) || !isValid($b) {
        return False;
    }
    my $sum = $a + $b;

    if $sum == $c {
        @res.push($sum);
        return True;
    }

    if $c.chars <= $sum.chars || $sum != $c.substr(0, $sum.chars) {
        return False;
    } else {
        @res.push($sum);

        return checkAddition(@res, $b, $sum, $c.substr($sum.chars));
    }
}

sub additiveSequence($n) {
    my @res;
    my $l = $n.chars;

    for 1 .. $l div 2 + 1 -> $i {
        for 1 .. ($l - $i) div 2 + 1 -> $j {
            if checkAddition(@res, $n.substr(0, $i), $n.substr($i, $j), $n.substr($i + $j)) {
                @res.unshift($n.substr($i, $j));
                @res.unshift($n.substr(0, $i));
                return @res;
            }
        }
    }

    return ();
}

sub MAIN(
    $string where { $string.chars > 2 && $string ~~ /^ <[0 .. 9]>+ $/ },
) {
    say additiveSequence($string).elems > 0;
}
