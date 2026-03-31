#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    lassign [split $line ":"] hours minutes
    set h_times 0
    set m_times 0
 
    if     {[regexp {^\?\?$}       $hours]}   {set h_times 24}   \
    elseif {[regexp {^\?[0-3]$}    $hours]}   {set h_times  3}   \
    elseif {[regexp {^\?[4-9]$}    $hours]}   {set h_times  2}   \
    elseif {[regexp {^[01]\?$}     $hours]}   {set h_times 10}   \
    elseif {[regexp {^2\?$}        $hours]}   {set h_times  4}   \
    elseif {[regexp {^[01][0-9]$}  $hours]}   {set h_times  1}   \
    elseif {[regexp {^2[0-3]$}     $hours]}   {set h_times  1}

    if     {[regexp {^\?\?$}       $minutes]} {set m_times 60}   \
    elseif {[regexp {^\?[0-9]$}    $minutes]} {set m_times  6}   \
    elseif {[regexp {^[0-5]\?$}    $minutes]} {set m_times 10}   \
    elseif {[regexp {^[0-5][0-9]$} $minutes]} {set m_times  1}

    puts [expr $h_times * $m_times]
}
