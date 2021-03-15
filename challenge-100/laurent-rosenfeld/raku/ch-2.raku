use v6;

my @triangle = (1), (2,4), (6,4,9), (5,1,7,2);
my @min-path = map { $_[0] }, @triangle; # pick any path
my $min-path-val = @min-path.sum;
my $index = 0;
traverse @triangle, (), $index;
say @min-path;

sub traverse (@triangle, @path, $index) {
    my @first-line = @triangle[0];
    my @new-triangle = @triangle[1 .. @triangle.end];
    say "First-line: ", @first-line;
    my @new-path = | (@path, @first-line[$index]);
    say @new-path, "  ", "\n";
    if @new-triangle.elems > 0 {
        traverse(@new-triangle, @new-path, $index);
        traverse(@new-triangle, @new-path, $index + 1);
    } else {
        my $new-path-val = @new-path.sum;
        if $new-path-val < $min-path-val {
            @min-path = @new-path;
            $min-path-val = $new-path-val
        }
    }
}
