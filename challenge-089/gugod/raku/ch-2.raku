
my @magic-squares = (1..9).permutations.grep(
    -> ($a, $b, $c, $d, $e, $f, $g, $h, $i) {
        all(
            $a + $b + $c == 15,
            $d + $e + $f == 15,
            $g + $h + $i == 15,
            $a + $d + $g == 15,
            $b + $e + $h == 15,
            $c + $f + $i == 15,
            $a + $e + $i == 15,
            $c + $e + $g == 15,
        )
    }
);

for @magic-squares -> @m {
    print-magic-square(@m);
}

sub print-magic-square (@m) {
    say "+-----+";
    say "|" ~ @m[0,1,2].join(" ") ~ "|";
    say "|" ~ @m[3,4,5].join(" ") ~ "|";
    say "|" ~ @m[6,7,8].join(" ") ~ "|";
    say "+-----+";
}
