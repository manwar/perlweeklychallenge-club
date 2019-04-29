my %dict = "/usr/share/dict/words".IO.lines().map({ $_.lc => True});
my %rev-dict;
push %rev-dict{$_.comb.sort.join}, $_ for %dict.keys;
my @variation = reverse 
                sort { %rev-dict{$_}.elems }, %rev-dict.keys;
my $max-anagrams = %rev-dict{@variation[0]}.elems;
for @variation {
  last if %rev-dict{$_}.elems != $max-anagrams;
  say "$_ ($max-anagrams): " ~ %rev-dict{$_}.join(',');
}
