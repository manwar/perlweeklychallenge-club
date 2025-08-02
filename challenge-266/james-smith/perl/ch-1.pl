sub uncommon_words {
    my %counts;
    for (@_) {
    	$counts{$_}++ for split /\W+/, lc
    }
    my @solo = grep { $counts{$_}==1 } keys %counts;
    @solo ? @solo : '';
}
