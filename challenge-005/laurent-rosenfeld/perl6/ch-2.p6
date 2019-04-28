my %words;
for "words.txt".IO.lines -> $line {
    next unless $line ~~ /\w/;  # skipping empty lines if any
    $line ~~ s/\s+$//;          # removing trailing spaces if any
    next if $line.chars < 3;
    my $key = $line.comb.sort.join('');
    push %words{$key}, $line;
}
my @max-anagrams;
my $max = 5;
for %words.keys -> $key {
    given %words{$key}.elems {
        when $_ < $max  { next }
        when $_ == $max { @max-anagrams.push($key) }
        default         { @max-anagrams = $key,; $max = $_}
    }
}
say "$_:\t %words{$_}" for (@max-anagrams);
