use strict;
use warnings;
use threads;

sub sleep_sort {
    my @numbers = @_;
    my @threads;

    foreach my $number (@numbers) {
        push @threads, threads->create(sub {
            sleep $number;
            print "$number ";
        });
    }

    $_->join for @threads;
}

sleep_sort(3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5);

