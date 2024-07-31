
function reverse_substring( char, string )
    index = findfirst( char, string )
    if isnothing(index)
        return string
    end

    chars = split( string, "" )
    join( vcat( ( sort( chars[1:index] ) ), chars[index+1:end] ), "" )
end

inputs = [["challenge", 'e'],
          ["programming", 'a'],
          ["champion", 'b'],
          ["and2 Raku3 cou4sins5 Perl are4", 'e']]

for input = inputs
    string = input[1]
    char = input[2]
    println( string )
    println( reverse_substring( char, string ) )
    println()
end
