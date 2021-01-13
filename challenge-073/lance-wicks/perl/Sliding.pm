package Sliding;

use List::Util 'min';

sub min_from_windows {
    my ($self, %args) = @_;
    my @numbers = @{$args{array_of_numbers}};
    my $length = @numbers;

    my $the_end = $length - $args{window_size};

    my @array_of_mins;
    for my $i (0 .. $the_end){
        my @slice = @numbers[$i .. ($i-1) + $args{window_size}];

        push @array_of_mins, min @slice;

    }

    return \@array_of_mins;
}

1;
