my %words;
for "words.txt".IO.lines -> $line {
    next unless $line ~~ /\w/;  # skipping empty lines if any
    $line ~~ s/\s+$//;          # removing trailing spaces if any
    next if $line.chars < 3;
    my $key = $line.comb.sort.join('');
    push %words{$key}, $line;
}
my $max = max map { .elems }, values %words;
say "$_:\t %words{$_}" if %words{$_}.elems == $max for %words.keys;
