#!/usr/bin/perl6

sub MAIN(
    *@files
) {
    my %totals;

    if @files.elems {
        for @files -> $file {
            $file.IO.comb.map({ %totals{$_.lc}++; });
        }
    } else {
        $*IN.comb.map({ %totals{$_.lc}++; });
    }

    %totals.keys.grep({ / <lower> / }).sort.map({
        say "$_: %totals{$_}";
    });
}
