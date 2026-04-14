#!/opt/homebrew/bin/tclsh

while {[gets stdin input] >= 0} {
    #
    # * Remove leading white space
    # * Remove non-letters, but keep space
    # * Remove trailing white space
    #
    regsub               {^\s+}            $input {}               input
    regsub -all          {[^[:alpha:]\s]+} $input {}               input
    regsub               {\s+$}            $input {}               input

    #
    # Lower case entire string
    #
    set input [string tolower $input]

    #
    # * For each sequence of letters (a word), upper case its first letter.
    #   This upper cases the first letter of the string, hence
    # * Lower case the first letter
    # * Remove all white space
    #
    regsub -all -command {[[:alpha:]]+}    $input {string totitle} input
    regsub      -command {^[[:alpha:]]}    $input {string tolower} input
    regsub -all          {\s+}             $input {}               input

    #
    # Add leading '#', and print at most 100 characters
    #
    puts [string range "#${input}" 0 99]
}
