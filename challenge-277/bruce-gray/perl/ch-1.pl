use v5.40;
use Set::Bag;

package Set::Bag { # Extending the class with methods I wish were already included.
    use List::Util qw<pairgrep>;
    sub new_from_list ($self, $list_aref) {
        my $bag = Set::Bag->new();
        $bag->insert($_ => 1) for @{$list_aref};
        return $bag;
    }
    sub singles ($self) {
        return Set::Bag->new( pairgrep { $b == 1 } $self->grab );
    }
    sub count ($self) {
        my @e = $self->elements();
        return 0 + @e;
    }
}

use List::Util qw<reduce>;
sub task1 ( @LoLists ) {
    my $intersections_bag =
        reduce { $a & $b }
        map { Set::Bag->new_from_list($_)->singles }
        @LoLists;

    return $intersections_bag->count;
}


my @tests = (
    [ 2, [qw<Perl is my friend>], [qw<Perl and Raku are friend>] ],
    [ 1, [qw<Perl and Python are very similar>], [qw<Python is top in guest languages>] ],
    [ 0, [qw<Perl is imperative Lisp is functional>], [qw<Crystal is similar to Ruby>] ],

    [ 1, [qw<Perl is Perl>], [qw<Java is not>] ],
);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ($expected, $in1, $in2) = @{$_};
    is task1($in1, $in2), $expected;
}
