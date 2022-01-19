use strict;
use warnings;
use feature qw'say signatures';
no warnings 'experimental::signatures';

use threads;
use threads::shared;

use constant DEBUG => $ENV{DEBUG} // 0;

run() unless caller();

sub run() {
    my @input = map { int( rand(30) ) } 0 .. 1000;
    say join( ", ", sleep_sort(@input) );
}

sub sleep_sort(@xs) {
    my @sorted;
    share(@sorted);
    my @threads =
      map {
        threads->create(
            sub($n) {
                sleep $n;
                push @sorted, $n;
            },
            $_
        )
      } @xs;
    $_->join() for @threads;
    return @sorted;
}

