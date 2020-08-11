# Test: perl6 ch2.p6
use v6.d;

sub MAIN () {
    generate-x-table(11);
}

# Generates the multiplication table
sub generate-x-table (Int $num) {
    table-content($_, $num).say for (0..$num);
}

# Returns the table head string
multi table-content(Int $current where { $current == 0}, Int $num) {
    my $line = "%4s|".sprintf("x");
    $line ~= "%4i".sprintf($_) for (1..$num);
    return $line ~ "\n" ~ '----+' ~ '----' x $num;
}

# Returns the table row string for $i
multi table-content(Int $current, Int $num) {
    my $line = "%4i|".sprintf($current);

    for (1..$num) -> $i {
        $line ~= ($current <= $i) ??
            "%4i".sprintf($i * $current) !! ' ' x 4;
    }

    return $line;
}
