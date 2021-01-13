use strict;
use warnings;
use feature "say";
use Data::Dumper;

sub create_lru {
    my $capacity = shift;
    my (%cache, @order);
    sub display { say "Order: @{$_[0]} \n", "Cache: ", Dumper $_[1];}
    my $setter = sub {
        my ($key, $val) = @_;
        $cache{$key} = $val;
        push @order, $key;
        if (@order > $capacity) {
            my $invalid = shift @order;
            delete $cache{$invalid};
        }
        display \@order, \%cache;
    };
    my $getter = sub {
        my $key = shift;
        return -1 unless exists $cache{$key};
        @order = grep { $_ != $key } @order;
        push @order, $key;
        display \@order, \%cache;
        return $cache{$key}
    };
    return $setter, $getter;
}

my ($set, $get) = create_lru(3);
$set->(1, 3);
$set->(2, 5);
$set->(3, 7);
say "should print  5: ", $get->(2);
say "should print  3: ", $get->(1);
say "should print -1: ", $get->(4);
$set->(4, 9);
say "should print -1: ", $get->(3);
