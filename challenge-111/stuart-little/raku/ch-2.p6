#!/usr/bin/env perl6
use v6;

# run <script> <path-to-dict-file, one word per line>

sub isSorted($word) {
    my @word = $word.lc.split("", :skip-empty);
    my @diffs = zip @word[0..^$word.chars-1], @word[1..$word.chars-1], :with({ord($^b) - ord($^a)});
    return ($word.lc ~~ /^<[a..z]>+$/).Bool && @diffs.map({$_ >= 0}).all.Bool;
}

sub longestWith(@list,&pred) {
    my $length=0;
    my @res=();
    for (@list) {
	my $l=$_.chars;
	next if (! &pred($_));
        $l > $length && do {
	    $length = $l;
	    @res=($_,);
	    next;
	};
	$l == $length && push @res, $_;
    }
    return @res;
}

my @words = @*ARGS[0].IO.lines;
for (longestWith(@words,&isSorted)) {
    .say;
}
