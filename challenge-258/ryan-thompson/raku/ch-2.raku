# Ryan Thompson <rjt@cpan.org>

sub sum_idx_bit_set($k, @n) {
    @n[ @n.keys.grep({ (TR:d/10/1/ with .base(2)) == $k }) ].sum
}
