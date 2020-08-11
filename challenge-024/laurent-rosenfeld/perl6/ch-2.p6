use v6;

my @files = grep { /\.p6$/ or /\.pl6$/ }, dir('.');
my %dict;
for @files -> $file {
    for $file.IO.lines.words.grep({/^ \w ** 3..* $/}) -> $word {
        %dict{$word}{$file} = True;
    }
}
.say for %dict{'given'}.keys;
