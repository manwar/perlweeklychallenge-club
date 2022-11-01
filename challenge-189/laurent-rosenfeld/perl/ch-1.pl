use strict;
use warnings;
use feature qw/say/;

sub greater_char  {
    my @eligible_input = grep { $_ gt $_[0]} @{$_[1]};
    return (sort @eligible_input)[0];
}

for my $test (['b', [<e m u g>]], ['a', [<d c e f>]],
    ['o', [<j a r>]], ['a', [<d c a f>]], ['v', [<t g a l>]]) {
    say "$test->[0] (@{$test->[1]}) \t -> ", greater_char($test->[0], $test->[1]);
}
