use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;

sub create_linked_list {
    my $input = shift;
    my $L;
    for my $val (reverse split / /, $input) {
        my $pt = { value => $val, next => $L };
        $L = $pt;
    }
    return $L;
}

my $k = shift;
my $list_str = shift // "1 4 3 2 5 2";
my $list = create_linked_list $list_str;
# say Dumper $list;
my (@before, @after);
while (1) {
    last unless defined $list->{value};
    my $temp = $list->{value};
    if ($temp < $k) {
        push @before, $temp;
    } else {
        push @after, $temp;
    }
    $list = $list->{next}
}
say join " → ", @before, @after;
