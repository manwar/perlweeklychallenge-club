#!/usr/bin/perl6

sub MAIN(
    Bool :$csv, #= output results in CSV format
    *@files
) {
    my %totals;

    if @files.elems {
        for @files -> $file {
            $file.IO.lines.map({ %totals{$_}++; });
        }
    } else {
        $*IN.lines.map({ %totals{$_}++; });
    }

    if $csv {
        %totals.keys.sort.map({ say "$_,%totals{$_}"; });
    } else {
        my $width =
            %totals.keys.sort({$^b.chars <=> $^a.chars}).first.chars;

        %totals.keys.sort.map({
            printf("% -*s  %s\n", $width, $_, %totals{$_});
        });
    }
}