#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    set valid 0
    foreach token $line {
        incr valid [regexp {^([a-z]+(-[a-z]+)?)?[!,.]?$} $token]
    }
    puts $valid
}
