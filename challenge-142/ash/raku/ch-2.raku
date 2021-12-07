# Running:
# raku ./ch-2.raku 4 7 2 3 1 6

await gather for @*ARGS {
    take start {
        sleep $_/10;
        .say;
    }
}
