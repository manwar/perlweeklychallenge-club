sub MAIN( *@files )
{
    .say for @files
        .map({ |.IO.lines.lc.comb( /\w/ ) })
        .Bag
        .sort
        .map({  "{.key}: {.value}" })
    ;
}

