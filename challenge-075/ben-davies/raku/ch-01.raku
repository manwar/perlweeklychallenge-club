use v6;
unit sub MAIN(**@c where .all ~~ UInt:D, UInt:D :$s!) {
    say @c.map({ slip $_ xx $s div $_ })\
          .combinations\
          .grep(*.sum == $s)\
          .unique(with => &[eqv])\
          .elems;
}
