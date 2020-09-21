use v6.d;

my @A = (9, 10, 7, 5, 6, 1);
my @B = (3, 4, 5);

sub get-leaders(@a where .all > 0) {
    my @leaders = gather for ^@a -> $i {
	take @a[$i] if @a[$i + 1..*].grep( {@a[$i] < $_} ).elems == 0;
    }
    if @leaders == Empty { return (0).List }
    return @leaders;
}

say get-leaders(@A);
say get-leaders(@B);
