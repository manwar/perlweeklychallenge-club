#!/usr/bin/env raku

sub is-valid-time ($s) {
    my ($hour,$minute) = $s.split: ':';
    so try DateTime.now.clone: :$hour, :$minute
}

sub digital-clock ($s) {
    9...0
    andthen .first: {
        is-valid-time $s.trans: '?' => "$_"
    }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is digital-clock('?5:00'),1;
    is digital-clock('?3:00'),2;
    is digital-clock('1?:00'),9;
    is digital-clock('2?:00'),3;
    is digital-clock('12:?5'),5;
    is digital-clock('12:59'),9;
    done-testing;
}

multi MAIN ($s) {
    say digital-clock $s
}
