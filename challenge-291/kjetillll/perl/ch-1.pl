use strict; use warnings; use List::Util 'first';

sub accumulated_sums_before(@) { my $sum = 0; pop; map $sum+=$_, 0, @_ }

sub leftmost_middle_index {
    my @ints = @_;
    my @leftsums = accumulated_sums_before @ints;
    my @rightsums = reverse accumulated_sums_before reverse @ints;
    ( first { $leftsums[$_] == $rightsums[$_] } 0 .. $#ints ) // -1
}

print leftmost_middle_index(@ARGV) and exit if @ARGV;

for my $test (
    [ 2, 3, -1, 8, 4        => 3 ],
    [ 1, -1, 4              => 2 ],
    [ 2, 5                  => -1 ],
    [ 1, 2, 3, 4, 5, 5, 5   => 4  ],
    [ 9, 2, -2, -1, 1, 5, 3 => 3 ], #rightmost MI is 4
){
    my $expected = pop@$test;
    my @input = @$test;
    my $got = leftmost_middle_index(@input);
    printf"%s   input: %-20s   expected: %3d   got: %3d\n",
	$got == $expected ? 'ok test' : '***ERROR',
	"@input",
	$expected,
	$got;
}
