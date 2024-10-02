#!/usr/bin/env tclsh
#
# Task 2: Jumbled Letters
# 
# Submitted by: Ryan Thompson
# 
# An Internet legend dating back to at least 2001 goes something like this:
# 
#     Aoccdrnig to a rscheearch at Cmabrigde Uinervtisy, it deosn’t mttaer in
#     waht oredr the ltteers in a wrod are, the olny iprmoetnt tihng is taht the
#     frist and lsat ltteer be at the rghit pclae. The rset can be a toatl mses
#     and you can sitll raed it wouthit porbelm. Tihs is bcuseae the huamn mnid
#     deos not raed ervey lteter by istlef, but the wrod as a wlohe.
# 
# This supposed Cambridge research is unfortunately an urban legend. However, the
# effect has been studied. For example—and with a title that probably made the
# journal’s editor a little nervous—Raeding wrods with jubmled lettres: there is
# a cost by Rayner, White, et. al. looked at reading speed and comprehension of
# jumbled text.
# 
# Your task is to write a program that takes English text as its input and
# outputs a jumbled version as follows:
# 
#     1. The first and last letter of every word must stay the same
#     2. The remaining letters in the word are scrambled in a random order (if
#        that happens to be the original order, that is OK).
#     3. Whitespace, punctuation, and capitalization must stay the same
#     4. The order of words does not change, only the letters inside the word
# 
# So, for example, “Perl” could become “Prel”, or stay as “Perl,” but it could
# not become “Pelr” or “lreP”.
# 
# I don’t know if this effect has been studied in other languages besides
# English, but please consider sharing your results if you try!
# 
package require tcltest

set cases {
    {{But I must explain to you how all this mistaken idea of denouncing
    pleasure and praising pain was born and I will give you a complete
    account of the system, and expound the actual teachings of the great
    explorer of the truth, the master-builder of human happiness. No one
    rejects, dislikes, or avoids pleasure itself, because it is pleasure,
    but because those who do not know how to pursue pleasure rationally
    encounter consequences that are extremely painful. Nor again is there
    anyone who loves or pursues or desires to obtain pain of itself,
    because it is pain, but because occasionally circumstances occur in
    which toil and pain can procure him some great pleasure. To take a
    trivial example, which of us ever undertakes laborious physical
    exercise, except to obtain some advantage from it? But who has any
    right to find fault with a man who chooses to enjoy a pleasure that has
    no annoying consequences, or one who avoids a pain that produces no
    resultant pleasure?} {} "Example 1"}
}

proc shuffle {list} {
    set n [llength $list]
    for {set i 1} {$i < $n} {incr i} {
        set j [expr {int(rand() * $n)}]
        set temp [lindex $list $i]
        lset list $i [lindex $list $j]
        lset list $j $temp
    }
    return $list
}

proc jumbled_letters {txt} {

    set words [regexp -inline -all -- {\S+} $txt]

    for {set i 0} {$i < [llength $words]} {incr i} {
        set w [lindex $words $i]
        if {[string length $w] == 1} {
            continue
        }
        set ll [split $w {}]
        set lastl [lindex $ll end]

        if [regexp {[\.!\?,:]} $lastl] {
            set p 2
        } else {
            set p 1
        }
        set len [llength $ll]
        incr len -1
        lset words $i [join [list \
                                [lindex $ll 0] \
                                [join [shuffle [lrange $ll 1 [expr $len - $p]]] {}] \
                                [join [lrange $ll [expr $len + 1 - $p] $len] {}]\
                            ] {}]
    }
    puts [join $words]
    return {}
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       jumbled_letters [lindex $case 0]
    } [lindex $case 1]
}

exit 0

