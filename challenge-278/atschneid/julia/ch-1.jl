
function unshuffle_string( string )
    words = split( string )
    keywords = Dict{Int, String}()

    re = r"(?<word>^\w+?)(?<index>\d+$)"
    for word in words
        m = match( re, word )
        if ~isnothing(m)
            keywords[ parse( Int, m["index"] ) ] = m["word"]
        end
    end

    max_key = maximum( keys( keywords ); init=1 )
    out_words = [get!( keywords, i, "REDACTED" ) for i = 1:max_key]
    join( out_words, " " )
end
        
strings = ["and2 Raku3 cousins5 Perl1 are4",
           "guest6 Python1 most4 the3 popular5 is2 language7",
           "Challenge3 The1 Weekly2",
           "abc1 abc 23 a1s2d3f4",
           "cool10 and2 Raku3 cou4sins5 Perl are4"]
for string = strings          
    println( string )
    println( unshuffle_string( string ) )
    println()
end
