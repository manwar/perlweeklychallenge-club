#!tclsh.exe

# AUTHOR: Robert DiCicco
# DATE: 23-MAR-2022
# Challenge 157 Pythagorean Means  ( Tcl )

proc mean  L {
  expr ([join $L +])/[llength $L].
}

proc gmean L {
  expr pow([join $L *],1./[llength $L])
}

proc hmean L {
  expr [llength $L]/(1./[join $L +1./])
}

#set L { 1 3 5 6 9 }           # uncomment one of these to use as input list
#set L { 2 4 6 8 10 }
set L { 1 2 3 4 5 }

set M [ mean $L]
set M  [format "%.1f" $M]
puts -nonewline "AM = $M   "

set G [ gmean $L]
set G  [format "%.1f" $G]
puts -nonewline "GM = $G   "

set H [ hmean $L]
set H  [format "%.1f" $H]
puts "HM = $H"
