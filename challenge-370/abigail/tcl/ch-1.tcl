#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    #
    # Split the input into the paragraph and list of banned words.
    # Since tcl doesn't have a split working on multi-char strings,
    # we first replace the '//' with a NUL character, then split
    # on the NUL character
    #
    lassign [split [string map {// \0} $line] \0] paragraph banned_str

    #
    # Populate the banned dictionary. If we treat a string as a list,
    # tcl will split the string on white space, and the result as the list.
    #
    set banned [dict create]
    foreach ban [string tolower $banned_str] {
        dict set banned $ban 1
    }

    #
    # Replace all sequences of non-letters with a single space
    #
    regsub -all {[^[:alpha:]]+} [string tolower $paragraph] { } paragraph

    #
    # Iterate over the words in paragraph, and if they aren't banned,
    # count them using the ok dictionary
    #
    set ok [dict create {} 0]
    foreach word $paragraph {
        if {![dict exists $banned $word]} {
            dict incr ok $word
        }
    }

    #
    # Find the word which occurs most frequently
    #
    set max {}
    dict for {word count} $ok {
        if {$count > [dict get $ok $max]} {
            set max $word
        }
    }

    puts $max
}
