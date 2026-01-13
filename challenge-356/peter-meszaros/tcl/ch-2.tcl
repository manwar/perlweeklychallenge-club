#!/usr/bin/env tclsh
#
# Task 2: Who Wins
# 
# Submitted by: Simon Green
# 
# It's NFL playoff time. Since the 2020 season, seven teams from each of the
# league's two conferences (AFC and NFC) qualify for the playoffs based on
# regular season winning percentage, with a tie-breaking procedure if required.
# The top team in each conference receives a first-round bye, automatically
# advancing to the second round. The following games are played. Some times the
# games are played in a different order. To make things easier, assume the order
# is always as below.
# 
#     Week 1: Wild card playoffs
# 
#         - Team 1 gets a bye
# 
#         - Game 1: Team 2 hosts Team 7
# 
#         - Game 2: Team 3 hosts Team 6
# 
#         - Game 3: Team 4 hosts Team 5
# 
#     - Week 2: Divisional playoffs
# 
#         - Game 4: Team 1 hosts the third seeded winner from the previous week.
# 
#         - Game 5: The highest seeded winner from the previous week hosts the second seeded winner.
# 
#     - Week 3: Conference final
# 
#         - Game 6: The highest seeded winner from the previous week hosts the other winner
# 
# You are given a six character string containing only H (home) and A away which
# has the winner of each game. Which two teams competed in the the conference
# final and who won?
# 
# Example 1
# 
#     NFC Conference 2024/5. Teams were Detroit, Philadelphia, Tampa Bay, Los Angeles
#     Rams, Minnesota, Washington and Green Bay. Philadelphia - seeded second - won.
# 
#     Input: $results = "HAHAHH"
#     Output: "Team 2 defeated Team 6"
# 
#     In Week 1,
# 
#         Team 2 (home) won against Team 7,
# 
#         Team 6 (away) defeated Team 3 and
# 
#         Team 4 (home) were victorious over Team 5.
# 
#         This means the second week match ups are
#         Team 1 at home to Team 6, and Team 2 hosted Team 4.
# 
#     In week 2,
# 
#         Team 6 (away) won against Team 1, while
# 
#         Team 2 (home) beat Team 4.
# 
#         The final week was Team 2 hosting Team 6
# 
#     In the final week,
# 
#         Team 2 (home) won against Team 6.
# 
# Example 2
# 
#     AFC Conference 2024/5. Teams were Kansas City, Buffalo, Baltimore, Houston, Los
#     Angeles Charges, Pittsburgh and Denver. Kansas City - seeded first - won.
# 
#     Input: $results = "HHHHHH"
#     Output: "Team 1 defeated Team 2"
# 
# Example 3
# 
#     AFC Conference 2021/2. Teams were Tennessee, Kansas City, Buffalo, Cincinnati,
#     Las Vegas, New England and Pittsburgh. Cincinnati - seeded fourth - won.
# 
#     Input: $results = "HHHAHA"
#     Output: "Team 4 defeated Team 2"
# 
# Example 4
# 
#     NFC Conference 2021/2. Teams were Green Bay, Tampa Bay, Dallas, Los Angeles
#     Rams, Arizona, San Francisco and Philadelphia. The Rams - seeded fourth - won.
# 
#     Input: $results = "HAHAAH"
#     Output: "Team 4 defeated Team 6"
# 
# Example 5
# 
#     NFC Conference 2020/1. Teams were Green Bay, New Orleans, Seattle, Washington,
#     Tampa Bay, Los Angeles Rams and Chicago. Tampa Bay - seeded fifth - won.
# 
#     Input: $results = "HAAHAA"
#     Output: "Team 5 defeated Team 1"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"HAHAHH" "Team 2 defeated Team 6" "Example 1"}
    {"HHHHHH" "Team 1 defeated Team 2" "Example 2"}
    {"HHHAHA" "Team 4 defeated Team 2" "Example 3"}
    {"HAHAAH" "Team 4 defeated Team 6" "Example 4"}
    {"HAAHAA" "Team 5 defeated Team 1" "Example 5"}
}

proc who_wins {results} {
    set games [dict create]
    # week 1
    dict append games 1 {2 7}
    dict append games 2 {3 6}
    dict append games 3 {4 5}
    dict append games 4 {1 {}}
    set winners {}
    # week 1
    lset winners 0 [lindex [dict get $games 1] [expr {[string index $results 0] == "H" ? 0 : 1}]]
    lset winners 1 [lindex [dict get $games 2] [expr {[string index $results 1] == "H" ? 0 : 1}]]
    lset winners 2 [lindex [dict get $games 3] [expr {[string index $results 2] == "H" ? 0 : 1}]]

    # week 2
    set wsort [lsort -integer $winners]
    dict set games 4 [lreplace [dict get $games 4] 1 1 [lindex $wsort 2]]
    lset winners 3 [lindex [dict get $games 4] [expr {[string index $results 3] eq "H" ? 0 : 1}]]

    dict set games 5 [list [lindex $wsort 0] [lindex $wsort 1]]
    lset winners 4 [lindex [dict get $games 5] [expr {[string index $results 4] eq "H" ? 0 : 1}]]

    # week 3
    dict set games 6 [lsort -integer [list [lindex $winners 3] [lindex $winners 4]]]
    lset winners 5 [lindex [dict get $games 6] [expr {[string index $results 5] eq "H" ? 0 : 1}]]  

    set loser [lindex [dict get $games 6] [expr {[string index $results 5] eq "A" ? 0 : 1}]]

    return "Team [lindex $winners 5] defeated Team $loser"
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        who_wins [lindex $case 0]
    } [lindex $case 1]
}

exit 0

