#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       sort-yourself-sleepy.pl
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use Coro;
use Coro::Timer;

my @arr = @ARGV;
scalar @arr == 0 and @arr = (3,2,1,5);



$|=1;
my $idx;

our @out; 
sleep_chamber( @arr );

say "@out";

say sleep_chamber( @arr );


sub sleep_chamber ( @arr ) {

    for $idx ( 0..$#arr ) { 
        async { 
            my $i = $idx;
            say "processing $idx";
            Coro::Timer::sleep($arr[$idx]);
            push @out, $arr[$idx];
            if ($i == $#arr) {
                say "@out";
                exit 1;
            }
        };
    } 
    
    AnyEvent->condvar->recv;
}
