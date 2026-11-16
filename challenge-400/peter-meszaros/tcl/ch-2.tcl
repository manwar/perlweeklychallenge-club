#!/usr/bin/env tclsh
#
# Task 2: Minimum Genetic Mutation
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given start and end gene string along with gene bank.  Write a script
# to return the minimum number of mutations required to mutate from start to end
# gene. Return -1 if there is no such mutation. A gene must be in a bank to make
# it a valid gene string.  A gene string can be represented by an 8-character
# long string, with choices from 'A', 'C', 'G', and 'T'.
# 
# Example 1
# 
#     Input: $start_gene = "AACCGGTT"
#            $end_gene   = "AACCGGTA"
#            @gene_bank  = ("AACCGCTA", "AAACGGTA")
#     Output: -1
# 
#     To reach end gene, every intermediate gene and the end gene itself must exist in bank.
#     Since "AACCGGTA" is missing from bank, it is impossible to complete the mutation sequence.
# 
# Example 2
# 
#     Input: $start_gene = "AACCGGTT"
#            $end_gene   = "AACCGGAA"
#            @gene_bank  = ("AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA")
#     Output: 2
# 
#     Path 1 (2 steps): "AACCGGTT" => "AACCGGTA" => "AACCGGAA"
#     Path 2 (3 steps): "AACCGGTT" => "AACCGGTA" => "AACCGTAA" => "AACCGGAA"
# 
# Example 3
# 
#     Input: $start_gene = "AAAAAAAA"
#            $end_gene   = "AAAAACCC"
#            @gene_bank  = ("CAAAAAAA", "CCAAAAAA", "AAAAAAAC")
#     Output: -1
# 
# Example 4
# 
#     Input: $start_gene = "GAAAAAAA"
#            $end_gene   = "GCCCCCCC"
#            @gene_bank  = ("GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC")
#     Output: 7
# 
#     "GAAAAAAA" => "GCAAAAAA"
#     "GCAAAAAA" => "GCCAAAAA"
#     "GCCAAAAA" => "GCCCAAAA"
#     "GCCCAAAA" => "GCCCCAAA"
#     "GCCCCAAA" => "GCCCCCAA"
#     "GCCCCCAA" => "GCCCCCCA"
#     "GCCCCCCA" => "GCCCCCCC"
# 
# Example 5
# 
#     Input: $start_gene = "AACCGGTT"
#            $end_gene   = "AACCGGTT"
#            @gene_bank = ("AACCGGTA")
#     Output: 0
# 
#     The current genetic sequence already matches the desired end gene.
#     No mutations are necessary, so the result is 0.
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{AACCGGTT AACCGGTA {AACCGCTA AAACGGTA}}                                             -1 "Example 1"}
    {{AACCGGTT AACCGGAA {AACCGGTA AACCGGAA AACCGCTA AACCCTAA AACCGTAA}}                   2 "Example 2"}
    {{AAAAAAAA AAAAACCC {CAAAAAAA CCAAAAAA AAAAAAAC}}                                    -1 "Example 3"}
    {{GAAAAAAA GCCCCCCC {GCAAAAAA GCCAAAAA GCCCAAAA GCCCCAAA GCCCCCAA GCCCCCCA GCCCCCCC}} 7 "Example 4"}
    {{AACCGGTT AACCGGTT {AACCGGTA}}                                                       0 "Example 5"}
}

proc minimum_genetic_mutation {p} {
    set start_gene [lindex $p 0]
    set end_gene   [lindex $p 1]
    set gene_bank  [lindex $p 2]

    if {$start_gene eq $end_gene} {
        return 0
    }

    set exists 0
    foreach gene $gene_bank {
        if {$gene eq $end_gene} {
            set exists 1
            break
        }
    }
    if {!$exists} {
        return -1
    }
    
    set mutations 0
    for {set i 0} {$i < [string length $start_gene]} {incr i} {
        if {[string index $start_gene $i] ne [string index $end_gene $i]} {
            incr mutations
        }
    }
    return $mutations
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        minimum_genetic_mutation [lindex $case 0]
    } [lindex $case 1]
}

exit 0

