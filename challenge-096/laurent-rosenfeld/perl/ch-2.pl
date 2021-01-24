use strict;
use warnings;
use feature qw/say/;

sub min {
    my $rv = shift;
    for my $tmp (@_) {
        $rv = $tmp if $tmp < $rv;
    }
    return $rv;
}

sub edit_distance {
    my ($left, $right) = @_;

    # If one of the substrings is empty, return the length of the other
    return length $right unless $left;
    return length $left  unless $right;

    my $shortened_left  = substr $left,  0, -1;
    my $shortened_right = substr $right, 0, -1;
    # In the last chars are the same, we ignore them
    # and call edit_distance on shortened strings
    return edit_distance ($shortened_left, $shortened_right) if substr($left, -1) eq substr($right, -1);

    # Else find the minimum between the three operations
    return 1 + min(
        edit_distance($left, $shortened_right), #insert
        edit_distance($shortened_left, $right), #remove
        edit_distance($shortened_left, $shortened_right) #replace
    );
}

# The decorator returns the edit_distance subroutine wrapped in
# code lines performing the caching of values
sub decorate {
    my $coderef = shift;
    my %cache;
    return sub {
        my ($l, $r) = @_;
        $cache{"$l;$r"} = $coderef->(@_) unless exists $cache{"$l;$r"};
        return $cache{"$l;$r"};
    }
}

{
    # local scope for the deactivation of the redefine warning
    no warnings 'redefine';
    # we replace the edit-distance subrouytine by its
    # decorated version in the main symbol table
    *main::edit_distance = decorate(\&edit_distance);
}

my @test_pairs = (
    [ qw<kitten sitting> ],
    [ qw<Monday Friday> ],
    [ qw<Sunday Saturday> ],
    [ qw<January February> ],
    [ qw<November December > ],
    [ qw<constitutionally anticonstitutional > ],
    [ qw<LMIjkHFSAE dmqkdjfERZG>],
);
for my $ar (@test_pairs) {
    my ($str1, $str2) = @$ar;
    say edit_distance($str1,$str2), " $str1 - $str2 ";
}
