constant $MAX = 55;

my $paragraph = q:to/END/;
    All he could think about was how it would all end. There was
    still a bit of uncertainty in the equation, but the basics
    were there for anyone to see. No matter how much he tried to
    see the positive, it wasn't anywhere to be seen. The end was
    coming and it wasn't going to be pretty.
    END

my @words;
for $paragraph.split(/'.'/) -> $sentence {
    next if $sentence ~~ /^\s*$/;   # remove any empty line
    @words.append(sort { $_.lc }, $sentence.split(/\s/));
    @words[*-1] ~= ".";
}
my $line = "";
for @words -> $w {
    $line ~= "$w ";
    if $line.chars > $MAX {
        say $line;
        $line = "";
    }
}
say $line;
