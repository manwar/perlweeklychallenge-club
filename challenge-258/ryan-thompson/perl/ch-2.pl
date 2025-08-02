# Ryan Thompson <rjt@cpan.org>

use List::Util qw< sum >;

sub sum_idx_bit_set {
    my $k = pop;
    sum map { $_[$_] } grep { $k == ( ()= sprintf('%b',$_) =~ /1/g ) } 0..$#_
}

print sum_idx_bit_set(2, 5, 9, 11, 3 => 1);
