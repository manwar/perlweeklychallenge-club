use strict; use warnings; use Test::More;

sub a33 {
    my %times;
    (
      sort { $a <=> $b}
      grep { 100 * ++$times{$_} / @_ >= 33 }
      @_
    ) [0]
}



my @tests = (
    {
        input  => [1,2,3,3,3,3,4,2],
        output => 3
    },
    {
        input  => [1,1],
        output => 1
    },
    {
        input  => [1,2,3],
        output => 1
    }
);
for my $test ( @tests ){
    my $got = a33( @{ $$test{input} } );
    is( $got, $$test{output} );
}
done_testing;
