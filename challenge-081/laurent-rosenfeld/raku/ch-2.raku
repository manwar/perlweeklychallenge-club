my Str $str = slurp "./WestSideStory.txt";
$str ~~ s:g/<[."(),]>+//;
$str ~~ s:g/[\'s]||['--']//;
my $h = bag $str.words; # histogram by words
my %summary;    # histogram by values
push %summary{$h{$_}}, $_ for $h.keys;
for %summary.keys.sort -> $k {
  say "$k ", %summary{$k}.sort.join(" ");
}
