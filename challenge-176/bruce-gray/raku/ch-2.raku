sub is-reversable ( $_ --> Bool ) {
    return so ($_ + .flip).comb.none %% 2;
}
say grep &is-reversable, ^100;

# One-liners:
# raku -e 'say grep { ($_ + .flip).comb.none %% 2 }, ^100;'
# raku -e 'say (1,3…9).map({ (1..$_ X* 9) X+ $_ }).flat.sort;'
