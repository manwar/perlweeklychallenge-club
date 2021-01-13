# Test: perl6 ch-2.p6
sub MAIN() {
    # Heights
    my @H = (27, 21, 37,  4, 19, 52, 23, 64,
             1,  7, 51, 17, 24, 50,  3,  2,
             34, 40, 47, 20,  8, 56, 14, 16,
             42, 38, 62, 53, 31, 41, 55, 59,
             48, 12, 32, 61,  9, 60, 46, 26,
             58, 25, 15, 36, 11, 44, 63, 28,
              5, 54, 10, 49, 57, 30, 29, 22,
             35, 39, 45, 43, 18,  6, 13, 33);

    # Number taller people in front
    my @T = ( 6, 41,  1, 49, 38, 12,  1,  0,
             58, 47,  4, 17, 26,  1, 61, 12,
             29,  3,  4, 11, 45,  1, 32,  5,
              9, 19,  1,  4, 28, 12,  2,  2,
             13, 18, 19,  3,  4,  1, 10, 16,
              4,  3, 29,  5, 49,  1,  1, 24,
              2,  1, 38,  7,  7, 14, 35, 25,
              0,  5,  4, 19, 10, 13,  4, 12);

    # Easier to index taller people in front;
    my %data;
    for ^@H.elems -> $i {
    	%data{@H[$i]} = @T[$i];
    }

    # Sort the height
    @H = @H.sort;

    # Process answers
    my @answers;
    for (@H) -> $h {
    	my $index = %data{$h};
    	loop (my $i = 0; $i <= $index; $i++) {
    		$index++ if (@answers[$i]);
    	}
    	@answers[$index] = $h;
    }

    say @answers.perl;
}
