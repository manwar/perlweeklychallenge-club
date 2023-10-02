use v5.36;
use List::Util qw<uniq>;
sub task1 ( @words ) {
    my %h;
    $h{$_}++ for map { uniq split '', lc $_ } @words;

    return [ grep { $h{$_} == @words } sort keys %h ];
}


my @tests = (
    [ [qw<Perl Rust Raku> ] ,  [qw<r>]     ],
    [ [qw<love live leave>] ,  [qw<e l v>] ],
);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ( $in_aref, $expected_aref ) = @{$_};
    is_deeply task1(@{$in_aref}), $expected_aref;
}
