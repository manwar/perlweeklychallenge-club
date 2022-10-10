unit sub MAIN(*@codes);

for @codes -> $code {
    my Int $count;
    for $code.comb {
        given $_ {
            when /\w/ { print ($count++ < 4 ?? "x" !! $_) }
            default { .print }
        }
    }
    put "";
}
