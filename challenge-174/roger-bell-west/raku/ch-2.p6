#! /usr/bin/perl6

use Test;

plan 4;

is(permutation2rank([1,0,2]),2,'example 1');

is-deeply(rank2permutation([0,1,2],1),[0,2,1],'example 2');

is(permutation2rank([2,0,3,1]),13,'example 3');

is-deeply(rank2permutation([1,3,2,0],7),[1,0,3,2],'example 4');

sub permutation2rank(@perm) {
    my $n = 0;
    my @pp = @perm.sort({ $^a <=> $^b });
    my @oi;
    my $l = 1;
    for (2..@perm.elems) -> $index {
        @oi.push($l);
        $l *= $index;
    }
    @oi = @oi.reverse;
    for (0..@perm.end-1) -> $index {
        my %base;
        for (0..@pp.end) -> $i {
            %base{@pp[$i]} = $i;
        }
        $n += @oi[$index] * %base{@perm[$index]};
        %base{@perm[$index]}:delete;
        @pp = %base.keys.sort({ $^a <=> $^b });
    }
    return $n;
}

sub rank2permutation(@perm, $rank0) {
    my $rank = $rank0;
    my @pp = @perm.sort({ $^a <=> $^b });
    my @o;
    my @oi;
    my $l = 1;
    for (2..@perm.elems) -> $index {
        @oi.push($l);
        $l *= $index;
    }
    @oi = @oi.reverse();
    for (0..@perm.end-1) -> $index {
        my $ix = $rank div @oi[$index];
        @o.push(@pp[$ix]);
        @pp = @pp.grep({$_ != @pp[$ix]});
        $rank %= @oi[$index];
    }
    @o.push(@pp[0]);
    return @o;
}
