#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    gsub (/\s+/, "")                                # Remove whitespace
    gsub (/\./,  "")                                # Remove dots
    split ($0, parts, ";")                          # Split on ;
    print parts [1] == parts [2] ? "true" : "false" # Equal?
}
