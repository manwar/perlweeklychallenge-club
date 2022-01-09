#!/usr/bin/env perl
use Modern::Perl;
use experimental qw<signatures>;
use File::Slurp;
use Test::More;

sub task2 ( $s ) {
    $s =~ m{ \A (\d+) / (\d+) \z }msx
        or die;
    my $parent = Calkin_Wilf_tree_parent([$1,$2]);
    my $grand  = Calkin_Wilf_tree_parent($parent);

    return map { $_->[0] . '/' . $_->[1] } $parent, $grand;
}
sub Calkin_Wilf_tree_parent ( $aref ) {
    die if @{$aref} != 2;
    my ( $numer, $denom ) = @{$aref};

    my $diff = $numer - $denom;

    return $diff > 0 ? [ $diff  ,  $denom ]
                     : [ $numer , -$diff  ];
}


sub run_test_suite ( ) {
    my @tests = map { /\S/ ? [split] : ()    }
                map { s{ \s* \# .* $ }{}msxr }
                read_file './Test_data/ch-2_tests.txt';

    plan tests => 0+@tests;

    for (@tests) {
        die if @{$_} != 3;
        my ( $in, $exp1, $exp2 ) = @{$_};
        my ( $got1, $got2 ) = task2($in);

        is_deeply [$got1, $got2], [$exp1, $exp2], "task2($in) == $exp1, $exp2";
    }
}

if (@ARGV) {
    say "$_ has CW parent,grandparent : ", join ',', task2($_) for @ARGV;
}
else {
    run_test_suite();
}
