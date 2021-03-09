#!/usr/bin/env lua

--[[
Challenge 090

TASK #1 > DNA Sequence
Submitted by: Mohammad S Anwar
DNA is a long, chainlike molecule which has two strands twisted into a
double helix. The two strands are made up of simpler molecules called
nucleotides. Each nucleotide is composed of one of the four nitrogen-containing
nucleobases cytosine (C), guanine (G), adenine (A) and thymine (T).

You are given DNA sequence,
GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG.

Write a script to print nucleiobase count in the given DNA sequence.
Also print the complementary sequence where Thymine (T) on one strand
is always facing an adenine (A) and vice versa; guanine (G) is always
facing a cytosine (C) and vice versa.
--]]

function complement(seq)
    local trans = {T = "A", A = "T", G = "C", C = "G"}
    local compl = string.gsub(seq, "[TAGC]", trans)
    return compl
end

seq = arg[1]
compl = complement(seq)

io.write(#seq, "\n")
io.write(compl)
