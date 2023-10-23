use Test;

sub create-new-array(@old) {
    my @new;
    for 0..^@old.elems -> $i {
        @new.push(@old[@old[$i]]);
    }
    return @new;
}

plan 2;

is-deeply create-new-array([0, 2, 1, 5, 3, 4]), [0, 1, 2, 4, 5, 3], 'Test Case 1';
is-deeply create-new-array([5, 0, 1, 2, 3, 4]), [4, 5, 0, 1, 2, 3], 'Test Case 2';
