<?php
/**
 * DNA is a long, chainlike molecule which has two strands twisted into a double helix. 
 * The two strands are made up of simpler molecules called nucleotides. 
 * Each nucleotide is composed of one of the four nitrogen-containing nucleobases 
 * 
 * cytosine (C), 
 * guanine (G), 
 * adenine (A) and thymine (T).
 * 
 * You are given DNA sequence, 
 * GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG
 * 
 * Write a script to print nucleiobase count in the given DNA sequence. 
 * Also print the complementary sequence where Thymine (T) on one strand is 
 * always facing an adenine (A) and vice versa; guanine (G) 
 * is always facing a cytosine (C) and vice versa. 
 */

 function nucleiobase_count($DNA) {
    return array_count_values(str_split($DNA));

 }

 function complementary($DNA) {
    return strtr($DNA, 'TAGC', 'ATCG');
 }

$test_dna = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';
print_r(nucleiobase_count($test_dna));
echo complementary($test_dna), "\n";