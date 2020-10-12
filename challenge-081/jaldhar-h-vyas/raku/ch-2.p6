#!/usr/bin/perl6

sub readText($filename) {
    my $text;

    return $filename.IO.slurp;
}

sub removePunctuation($text) {
    my $processed = $text;

    $processed ~~ s:g/ '.' | '"' | '(' | ')' | ',' | "'s" | '--'/ /;

    return $processed;
}

sub countWords($text) {
    my %count = $text.split( /\s+/ ).classify({ $_; });
    return %count.keys.map({ %count{$_}.elems => $_; });
}

sub display(@count) {
    my %frequency;

    @count.sort.map({ %frequency{$_.key}.push($_.value); });

    %frequency.keys.sort.map({
        say "$_ ", %frequency{$_}.join(q{ }), "\n";
    });
}

sub MAIN() {
    readText('./input')
        ==> removePunctuation()
        ==> countWords()
        ==> display()
    ;
}