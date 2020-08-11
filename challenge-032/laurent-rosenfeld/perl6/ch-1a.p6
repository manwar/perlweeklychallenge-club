use v6;
subset file of Str where *.IO.f;

multi sub MAIN (Int $csv, *@files where all(@files) ~~ file) {
    my $*format = $csv ?? "%s,%d\n" !! "%-20s%d\n";
    readfiles @files;
}
multi sub MAIN (*@files where all(@files) ~~ file) {
    my $*format = "%-20s%d\n";
    readfiles @files;
}
sub readfiles (@files) {
    my $histo = @files.map({.IO.lines}).Bag;
    for reverse sort {$histo{$_}}, keys $histo -> $key {
        printf $*format, $key, $histo{$key};
    }
}
