# zip takes two arrays and returns a list.
sub zip(@a, @b --> List) {
    die if @a.elems !== @b.elems;
    my @c;
    @c.push(@a[$_], @b[$_]) for ^@a.elems;
    return @c;
}
