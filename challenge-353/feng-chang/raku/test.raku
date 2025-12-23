#!/bin/env raku

# The Weekly Challenge 353
use Test;

sub pwc-test(Str:D $script, Bool :$deeply? = False, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    if $deeply {
        is-deeply $p.out.slurp(:close).chomp.words.Bag, $expect, $assertion;
    } else {
        is $p.out.slurp(:close).chomp, $expect, $assertion;
    }
}

# Task 1, Max Words
pwc-test './ch-1.raku',
    'Hello world',
    'This is a test',
    'Perl is great',
    4, 'Max Words: 1st => 4';
pwc-test './ch-1.raku',
    'Single',
    1, 'Max Words: 2nd => 1';
pwc-test './ch-1.raku',
    'Short',
    'This sentence has seven words in total',
    'A B C',
    'Just four words here',
    7, 'Max Words: 3rd => 7';
pwc-test './ch-1.raku',
    'One',
    'Two parts',
    'Three part phrase',
    '',
    3, 'Max Words: 4th => 3';
pwc-test './ch-1.raku',
    'The quick brown fox jumps over the lazy dog',
    'A',
    'She sells seashells by the seashore',
    'To be or not to be that is the question',
    10, 'Max Words: 5th => 10';

# Task 2, Validate Coupon
pwc-test './ch-2.raku', q:to/EOS/, 'true, false, true, false, true', 'Validate Coupon: 1st => (true, false, true, false, true)';
    @codes=("A123","B_456","C789","D@1","E123");
    @names=("electronics","restaurant","electronics","pharmacy","grocery");
    @status=("true","false","true","true","true");
    EOS
pwc-test './ch-2.raku', q:to/EOS/, 'true, true, false, true, false', 'Validate Coupon: 2nd => (true, true, false, true, false)';
    @codes=("Z_9","AB_12","G01","X99","test");
    @names=("pharmacy","electronics","grocery","electronics","unknown");
    @status=("true","true","false","true","true");
    EOS
pwc-test './ch-2.raku', q:to/EOS/, 'true, true, false, true, true', 'Validate Coupon: 3rd => (true, true, false, true, true)';
    @codes=("_123","123","","Coupon_A","Alpha");
    @names=("restaurant","electronics","electronics","pharmacy","grocery");
    @status=("true","true","false","true","true");
    EOS
pwc-test './ch-2.raku', q:to/EOS/, 'true, true, true, true', 'Validate Coupon: 4th => (true, true, true, true)';
    @codes=("ITEM_1","ITEM_2","ITEM_3","ITEM_4");
    @names=("electronics","electronics","grocery","grocery");
    @status=("true","true","true","true");
    EOS
pwc-test './ch-2.raku', q:to/EOS/, 'true, true, true, true, false', 'Validate Coupon: 5th => (true, true, true, true, false)';
    @codes=("CAFE_X","ELEC_100","FOOD_1","DRUG_A","ELEC_99");
    @names=("restaurant","electronics","grocery","pharmacy","electronics");
    @status=("true","true","true","true","false");
    EOS
