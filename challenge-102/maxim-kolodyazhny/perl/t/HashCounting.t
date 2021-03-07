use strict;
use warnings;

use lib './lib';

use Test::More tests => 4;

use English;

my $hash_re = qr{
    # the string consists only of digits 0-9 and hashes, ‘#’
    (*positive_lookahead: ^ [0-9#]+ $ )

    # there are no two consecutive hashes: ‘##’ does not appear in your string
    (*negative_lookahead: .*\#{2,} )

    # the last character is a hash
    (*positive_lookahead: .*\#$ )

    # the number immediately preceding each hash (if it exists)
    # is the position of that hash in the string, with the
    # position being counted up from 1
    ^
        ( (\d*) (??{
            my $num     = $LAST_SUBMATCH_RESULT || 1;
            my $cur_pos = pos() +1;

            $cur_pos == $num ? '(*ACCEPT)' : '(*FAIL)'
        }) \# )+
    $
}x;


my %good_examples = (
         1 => '#',
         2 => '2#',
         3 => '#3#',
        10 => '#3#5#7#10#',
        14 => '2#4#6#8#11#14#',
);

my @bad_examples = ( '', '1#', '1#2', '#2#', '0#' );

subtest 'RegExp for hashes' => sub {

    plan tests => 2;

    subtest 'Bad examples' => sub {

        plan tests => 5;

        foreach my $bad_val ( @bad_examples ) {
            unlike( $bad_val, $hash_re );
        }
    };

    subtest 'Good examples' => sub {

        plan tests => 5;

        foreach my $ok_val ( values %good_examples ) {
            like( $ok_val, $hash_re );
        }
    };
};

subtest 'Succesfully loaded' => sub {

    plan tests => 2;

    local *STDERR;
    open STDERR, '>>', \my( $load_warns ) or die $!;

    use_ok 'HashCounting', 'h';

    close( STDERR );

    is(
        $load_warns, undef,
        'no warnings (e.g. about experimental::signatures)'
    );
};

subtest 'h() vs test data' => sub {

    plan tests => 7 + 1;

    local *STDERR;
    open STDERR, '>>', \my( $execution_warns ) or die $!;

    my %t = (
        -1 => '',
         0 => '',
        %good_examples,
    );

    foreach my $q ( sort keys %t ) {

        my $an = $t{$q};

        subtest "h($q)" => sub {

            plan tests => 2;

            my $out = h($q);
            cmp_ok( $out, 'eq', $an );

            $q < 1 ? pass( "'' for bad input" ) : ok( $out =~ $hash_re );
        }
    }

    close( STDERR );

    is(
        $execution_warns, undef,
        'no warnings'
    );
};

subtest 'Tail call optimization' => sub {

    plan tests => 2;

    local *STDERR;
    open STDERR, '>>', \my( $recursion_warns ) or die $!;

    ok( h( 100_500 ) =~ $hash_re );

    close( STDERR );

    is(
        $recursion_warns, undef,
        'no warnings (e.g. about deep recursion)'
    );
};
