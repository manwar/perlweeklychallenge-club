use v6;

sub proc(@int) {
    say "Input: ", @int;
    my ($min, $max) = (@int.min, @int.max);
    my @out = @int.grep({$_ != $min && $_ != $max});
    say "Output: ", @out.elems;
}

my @int = (2,4);
proc(@int);

@int = (1,1,1,1);
proc(@int);

@int = (1, 1, 4, 8, 12, 12);
proc(@int);

@int = (3,6,6,9);
proc(@int);

@int = (0, -5, 10, -2, 4);
proc(@int);
