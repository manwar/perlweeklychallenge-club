unit sub MAIN ($values = 100) ;

my @triangle;
@triangle[0] = [1];

for 1..$values -> $row {
    @triangle[$row][0] = @triangle[$row-1][*-1];
    for 1..$row -> $i {
        @triangle[$row][$i] = @triangle[$row][$i-1] + @triangle[$row-1][$i-1];
    }
}

say $_[0] for @triangle;
