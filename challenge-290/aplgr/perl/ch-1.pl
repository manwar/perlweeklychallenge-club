use strict;
use warnings;

sub double_exist {
    my %seen;

    foreach my $num (@_) {
        return 1 if exists $seen{$num / 2} || exists $seen{$num * 2};
        $seen{$num} = 1;
    }

    return 0;
}

1;