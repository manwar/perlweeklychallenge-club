use Test::More tests=>2; use strict; use warnings;

sub one_bit_count {
    sprintf("%b", pop) =~ y/1//
}

sub sort_by_one_bits {
    map $$_[0],
    sort {    $$a[1] <=> $$b[1]
	   || $$a[0] <=> $$b[0] }
    map [$_, one_bit_count($_) ],
    @_
}

for my $test (
    {
      input  => [0, 1, 2, 3, 4, 5, 6, 7, 8],
      output => [0, 1, 2, 4, 8, 3, 5, 6, 7]
    },
    {
      input  => [1024, 512, 256, 128, 64],
      output => [64, 128, 256, 512, 1024]
    }
) {
    my @got = sort_by_one_bits( @{ $$test{input} } );
    is_deeply( \@got, $$test{output}, "got: @got   exp: @{$$test{output}}" );
}
