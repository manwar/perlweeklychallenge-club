#!/usr/bin/env raku
use v6.e.PREVIEW;

sub perm2seq-it (($hd,+tail)) {
    $hd -1 , tail.map: { $_ > $hd ?? $_ - 1 !! $_ }
}

sub perm2seq(+@int) {
    (-1,@int), -> ($, @perm) { perm2seq-it @perm } ... !*[1].elems
    andthen .skip
    andthen .map: *[0]
}

sub seq2int (+seq) {
    [+] seq.reverse.skip Z* [\*] 1..*
}

my &perm2int = &perm2seq Ro &seq2int;

sub int2seq ($n, $k) {
    $n
    andthen .polymod(1..*)
    andthen .reverse
    andthen |(0 xx $k - .elems), |$_
}

sub seq2perm-it ($ind, @adept) {
    @adept[ $ind ], @adept.skip($ind,1,*)
}

sub seq2perm (@seq,@adept) {
    ((-1,@adept), |@seq).produce: -> ($, @ad), $ind { seq2perm-it $ind, @ad }\
    andthen .skip
    andthen .map: *[0]
}

sub int2perm($n, @adept) {
    int2seq $n, @adept.elems
    andthen seq2perm $_, @adept;
}

sub next-permutation (+perm) {
    perm2int(perm) + 1
    andthen int2perm $_, 1.. perm.elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is perm2seq-it((2,1,3)), (1,(1,2));
    is perm2seq-it((1,2)), (0,(1));
    is-deeply perm2seq(2,1,3), (1,0,0);
    is perm2seq(5,2,4,1,3), (4,1,2,0,0);
    is perm2seq(4,2,5,3,1), (3,1,2,1,0);
    is seq2int(3,1,2,1,0),  83;
    is perm2int(4,2,5,3,1), 83;
    subtest {
        is perm2int(.value),.key, "perm {.value} is {.key}"  for permutations(1..3).pairs;
    }, 'perm2int 3';
    subtest {
        is perm2int(.value),.key, "perm {.value} is {.key}"  for permutations(1..4).pairs;
    }, 'perm2int 4';
    is int2seq(83,5),(3,1,2,1,0);
    is int2seq(83,7),(0,0,3,1,2,1,0);
    is seq2perm-it(3,(1..5)), (4,(1,2,3,5));
    is-deeply seq2perm((3,1,2,1,0),1..5), (4,2,5,3,1);
    is int2perm(83,1..5), (4,2,5,3,1);
    subtest {
        is int2perm(.key, 1..3), .value, "perm {.value} is {.key}"  for permutations(1..3).pairs;
    }, 'int2perm 3';
    subtest {
        is int2perm(.key, 1..4), .value, "perm {.value} is {.key}"  for permutations(1..4).pairs;
    }, 'int2perm 4';
    is next-permutation(1,2,3),(1,3,2);
    is next-permutation(2,1,3),(2,3,1);
    is next-permutation(3,1,2),(3,2,1);
    done-testing;
}

multi MAIN (+int) {
    put next-permutation int
}
