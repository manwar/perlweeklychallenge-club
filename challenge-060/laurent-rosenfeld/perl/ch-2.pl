use strict;
use warnings;
use feature qw /say/;

my $length = shift;
my $max_val = shift;
my @L = @ARGV;

sub permute {
    my ($seed, @list) = @_;
    return if length $seed > $length;
    for my $val (@list) {
        next if $seed eq "" and $val == 0;
        my $new_seed = 0 + ($seed . $val);
        say $new_seed if length $new_seed == $length
            and $new_seed < $max_val;
        permute($new_seed, @list);
    }
}

permute "", @L;
