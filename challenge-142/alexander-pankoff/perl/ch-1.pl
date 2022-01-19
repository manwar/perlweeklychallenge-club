use strict;
use warnings;
use feature qw'say signatures';
no warnings 'experimental::signatures';

use FindBin;

package Challenge141Task01 {
    require $FindBin::RealBin
      . '/../../../challenge-141/alexander-pankoff/perl/ch-1.pl';
}

package Challenge141Task02 {
    require $FindBin::RealBin
      . '/../../../challenge-141/alexander-pankoff/perl/ch-2.pl';
}

use constant DEBUG => $ENV{DEBUG} // 0;

run() unless caller();

sub run() {
    my $m = Challenge141Task02::prompt_for_integer('m');
    my $n;
    do {
        $n = Challenge141Task02::prompt_for_integer('n');
    } while ( length $n > 1 && say "Expect 'n' to be a single digit." );

    # from the description of the task I infer, this week the number 'm' itself
    # should not be considered a divisor of 'm'. This is different from last
    # week, where we found numbers with exactly 8 divisors including the number
    # itself
    my @divisors = grep { $_ != $m } Challenge141Task01::find_divisors($m);
    say join( ", ", sort { $a <=> $b } @divisors ) if DEBUG;
    my @result = grep { substr( $_, -1 ) == $n } @divisors;
    say join( ", ", sort { $a <=> $b } @result ) if DEBUG;
    say scalar @result;
}
