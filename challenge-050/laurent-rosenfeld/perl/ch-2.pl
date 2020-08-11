use strict;
use warnings;
use feature "say";

my $list_size = int(rand 10) + 3;
my @list = map {int(rand 50) + 1 } 1..$list_size;
say $list_size, "/", "@list";

# my @list = (2, 6, 1, 3,5, 8);

@list = sort {$b <=> $a} @list; #descending sort
say $list_size, " / ", "@list";
for (0..$#list) {
    say "$list[$_] is noble." if $list[$_] == $_;
}
