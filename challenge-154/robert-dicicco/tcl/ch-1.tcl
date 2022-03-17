# Author: Robert DiCicco
# Date: 1-MAR-2022
# Challenge #154 Missing Permutation ( Tcl )

proc permutations {list} {
  if {[llength $list] == 1} {
      return $list
  }

  set ret [list]
  set pitem [lindex $list end]
  set rest [permutations [lrange $list 0 end-1]]

  # Right now insert our item at every position in the list

  foreach item $rest {
      for {set i 0} {$i < [llength $item]} {incr i} {
          lappend ret [linsert $item $i $pitem]
      }

      lappend ret [concat $item $pitem]
  }

  return [lsort $ret]
}

set given_perms { PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL ERLP \
  ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP LPER LPRE LEPR LRPE LREP }

set pname  "P E R L"
set a [ permutations $pname ]

foreach x $a {
  set w [join [list {*}$x] ""]                    ;### remove spaces between letters

  if {[lsearch -exact $given_perms $w] == -1} {   ;### check if in given list
    puts "$w Not Found in given list"             ;### print if not in list
  }
}
