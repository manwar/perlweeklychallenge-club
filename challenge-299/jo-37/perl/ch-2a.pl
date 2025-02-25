#!/usr/bin/perl

use v5.32;
use Test2::V0 qw(!float -no_srand);
use PDL;
use PDL::NiceSlice;
use PDL::Char;
use PDL::CCS v1.23.28;
use experimental 'signatures';
use Benchmark 'cmpthese';


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/01/09/ch-299.html#task-2

our $verbose;

# Moving forward along a walk by calculating c *= A x b. "A" as an
# PDL::CCS::Nd object must be handed as "otherPar". Using fast low-level
# matrix product from PDL::CCS::MatrixOps. Result is a binary vector.
broadcast_define 'x_forward(b(n);c(n)), NOtherPars => 1', over {
    my ($b, $c, $a) = @_;
    my $p = zeroes long, 1, $c->dim(0);
    ccs_matmult2d_zdd($a->_whichND, $a->_nzvals,
        $b->dummy(0), $p);
    $p->inplace->hclip(1);
    $c *= $p((0));
    die "result is null" if !$c->any;
};

sub find_word ($matrix, $word) {
    my $m = PDL::Char->new($matrix);
    my $w = PDL::Char->new([$word]);
    my $chars = $w->long->clump(2);

    # create a layered mask for word's characters in the grid
    my $mw = $m((0))->long->dummy(2, $chars->dim(0))
        ->reorder(2, 0, 1) == $chars;
    # combine layers
    my $mask = $mw->orover;

    # side action from this state:
    # flatten matrix structure in the layers and drop all empty slots
    my $p = $mw->clump(1, 2)->reorder(1, 0)->(which $mask)->sever;

    # continue with mask:
    # set unmasked elements to BAD
    $mask->inplace->setvaltobad(0);

    # enumerate vertices
    my $asize = $mask->ngood->sclr;
    $mask->where($mask->isgood) .= sequence long, $asize;

    # create row and column pairs
    my $r = $mask(0:-2)->clump(2)->glue(1, $mask(1:-1)->clump(2));
    my $c = $mask(,0:-2)->clump(2)->glue(1, $mask(,1:-1)->clump(2));

    # concat pairs
    my $rc = $r->glue(0, $c);

    # find indices of good pairs
    my $igood = which !$rc->reorder(1, 0)->nbadover;
    ($verbose && say("no good pairs") && 0) ||
    return 0 if $igood->isempty;

    # pick good pairs
    my $good = $rc($igood)->reorder(1, 0);

    # symmetrize
    my $which = $good->glue(1, $good(-1:0));

    # create sparse adjacency matrix from pairs
    my $adj = PDL::CCS::Nd->newFromWhich($which, ones(long, $which->dim(1)),
        pdims => [$asize, $asize], missing => 0);

    # try to find a walk along the word's characters, dropping all
    # vertices that are not on a forward walk. Broadcast over layers.
    eval {
        x_forward($p(,0:-2), $p(,1:-1), $adj);
        1;
    } || return 0;

    say "found walk" if $verbose;

    ($verbose && say("all walks are paths") && 0) ||
    return 1 if $p->xchg(0, 1)->sumover->max == 1;

    # search backward for a path
    find_path($adj, $p(,-1:0));
}

# search for a path: start paths from unique vertices or each
# individual non-unique vertex, remove the starting vertex and
# recursively try to reach the target
sub find_path($adj, $p) {
    # count start vertex appearances
    my $vc = $p->xchg(0, 1)->sumover * $p(,(0));
    # create matrix with one row for all unique vertices at once and
    # one row for each non-unique vertex
    my $uniq = which $vc == 1;
    my $nu = which $vc > 1;
    my $q = zeroes long, !$uniq->isempty + $nu->nelem, $vc->dim(0);
    $q(0,$uniq) .= 1 unless $uniq->isempty;
    $q(-$nu->nelem:-1,$nu)->diagonal(0, 1) .= 1 unless $nu->isempty;

    for my $p0 ($q->xchg(0, 1)->dog) {
        # pick second to last column from p
        my $p1 = $p(,1:-1)->sever;
        # step forward
        eval {
            x_forward($p0, $p1(,(0)), $adj);
            1;
        } || next;
        return 1 if $p->dim(1) == 2;
        # delete selected vertices
        $p1(which $p0) .= 0;

        return 1 if find_path($adj, $p1);
    }

    0;
}


# Copied from https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-299/e-choroba/perl/ch-2.pl:

sub word_search($chars, $str) {
    return 1 if "" eq $str;

    for my $y (0 .. $#$chars) {
        for my $x (0 .. $#{ $chars->[$y] }) {
            return 1 if _word_search($x, $y, $chars, $str, {});
        }
    }
    return
}


BEGIN {   my @DIRS = ([0, 1], [1, 0], [0, -1], [-1, 0]);
    sub _word_search($x, $y, $chars, $str, $visited) {
        my $first_char = substr $str, 0, 1, "";

        return if $chars->[$y][$x] ne $first_char;
        return 1 if "" eq $str;

        undef $visited->{"$x:$y"};
        for my $dir (@DIRS) {
            my $nx = $x + $dir->[0];
            my $ny = $y + $dir->[1];
            next if $nx < 0 || $ny < 0
                 || $ny > $#$chars || $nx > $#{ $chars->[0] }
                 || exists $visited->{"$nx:$ny"};

            return 1 if _word_search($nx, $ny, $chars, $str,
                                     {%$visited, "$nx:$ny" => undef});
        }
        return
    }
}

### End of copied code


### Main
my $seed = 1736365876;
say "seed: $seed";
srandom($seed);

SKIP: {
    my @arr;
    my $size = 100;
    my $chars = 20;
    my $samples = 25;
    for (1..$samples) {
        my $pdl = PDL::Char->new((65 + ($chars * random $size, $size)->byte)
            ->dummy(0));
        my $ar =  [map {[map chr, $_->list]} $pdl->long->clump(2)->dog];
        push @arr, [$pdl, $ar];
    }
    my $word = "ABCBD";
    for my $sample (@arr) {
        my $expected = !!word_search($sample->[1], $word);
        is !!find_word($sample->[0], $word), $expected,
                "cross-check: " . ("not " x !$expected) . "found";
    }
    my ($cs, $cg);
    cmpthese(0, {
            scan => sub {word_search($arr[$cs++ % @arr][1], $word)},
            graph => sub {find_word($arr[$cg++ % @arr][0], $word)},
        });
}

done_testing;
