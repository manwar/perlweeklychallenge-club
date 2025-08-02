use strict; use warnings; use Test::More;

sub target_index { my $k = pop; my @s = sort {$a<=>$b} @_; grep $s[$_]==$k, 0..$#s }

my @tests = (
    {
	list => [1, 5, 3, 2, 4, 2],
	k    => 2,
	want => [1, 2]
    },
    {
	list => [1, 2, 4, 3, 5],
	k    => 6,
	want => []
    },
    {
	list => [5, 3, 2, 4, 2, 1],
	k    => 4,
	want => [4]
    }
);
for my $test (@tests) {
    my @got = target_index( @{$$test{list}}, $$test{k} );
    is_deeply(\@got, $$test{want});
}
done_testing;
