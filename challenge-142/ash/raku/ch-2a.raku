# Running:
# raku ./ch-2a.raku 4 7 2 3 1 6

await @*ARGS.map({
    start {
        sleep $_/10;
        .say;
    }
})
