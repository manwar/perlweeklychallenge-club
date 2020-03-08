use v6;

my $list-size = (3..11).pick;
my @list = (1..50).pick($list-size).sort.reverse;
say @list;
for (0..@list.end) {
    say "@list[$_] is noble." if @list[$_] == $_;
}
