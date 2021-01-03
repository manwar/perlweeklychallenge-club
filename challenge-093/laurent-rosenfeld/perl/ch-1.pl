use strict;
use warnings;
use feature "say";

my @tests = ( [[1,1], [2,2], [5, 5], [5,2], [3,3], [3,1], [2,7], [4, 4]],
              [[1,1], [2,2], [3,1], [1,3], [5,3]],
              [[1,1], [4,2], [1,3], [2,2], [1,2], [5,1], [1,4]],
            );
for my $point_set (@tests) {
    # display_points(@points);
    find_alignments(@$point_set);
}

sub find_alignments  {
    my @points = @_;
    my %directions = (
        N  => sub { $_[0]->[0]    ,  $_[0]->[1] + 1 },
        NE => sub { $_[0]->[0] + 1,  $_[0]->[1] + 1 },
        E  => sub { $_[0]->[0] + 1,  $_[0]->[1]     },
        SE => sub { $_[0]->[0] + 1,  $_[0]->[1] - 1 }
    );
    my %point_hash = map { my @a = @$_; "$$_[0];$$_[1]" => 1 } @points;
    my $max_count = 0;
    for my $point (@points) {
        for my $dir (keys %directions) {
            my $count = 1;
            my @p = $directions{$dir}->($point);
            while ($point_hash{"$p[0];$p[1]"}) {
                @p = $directions{$dir}->([@p]);
                $count++;
            }
            $max_count = $count if $count > $max_count;
        }
    }
    say  join " ", map { "(@{$_})" } @points;
    say "Count: $max_count \n";
}
