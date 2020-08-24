use v6;
unit sub MAIN(**@a where .all ~~ UInt:D) {
    [X..] @a.keys xx 2
==> grep(+*)
==> map({ +$_ * @a[$_].min })
==> max()
==> say();
}
