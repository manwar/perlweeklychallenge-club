function validate_a_b( string )
    first_b = findfirst( 'b', string )
    last_a = findlast( 'a', string )
    # there is a 'b' 
    # and ( there are no 'a's or the last 'a' is before the first 'b' )
    first_b != nothing && ( last_a == nothing || last_a < first_b )
end

inputs = ["aabb", "abab", "aaa", "bbb", "aaaffeoioijlkfjoihslkjhfb"]
for s in inputs
    println( s, " :: ", validate_a_b( s ) )
end
