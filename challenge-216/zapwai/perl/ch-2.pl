use v5.30.0;
my @stickers = ('perl','raku','python');my $word = 'peon';
#my @stickers = ('love','hate','angry');my $word = 'goat';
#my @stickers = ('come','nation','delta');my $word = 'accommodation';
say "Input: \@stickers = (" . join(",", @stickers) . "), \$word = $word";
print "Output: ";
my @L = split("",$word);
my %L;
L: foreach my $l (@L) {
    foreach (0 .. $#stickers) {

       	if ($stickers[$_] =~ /$l/) {
	    my $ind = $_ . $l;
	    $L{$ind}++;
	    next L;
	}
    }
}
my %bin;
foreach (keys %L) {
    my ($num, $let) = split("",$_);
    $bin{$num} = $L{$_} if ($L{$_} > $bin{$num});
#    say "$_ $L{$_}";
}
my $tot;
$tot += $bin{$_} for (0 .. $#stickers);
say $tot;
say "One solution is: ";
foreach (0 .. $#stickers) {
    say "$bin{$_} from '$stickers[$_]'" if ($bin{$_});
}
# Not the most efficient solution.
