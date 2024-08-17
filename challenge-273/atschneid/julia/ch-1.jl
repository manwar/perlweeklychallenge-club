function percent_char_v1(string, char)
    # the simplest and cheapest algorithm
    # also the most boring
    # 
    # step through each char of the string
    # count the matches, count all chars
    # one pass through the string
    #
    # divide matches by total chars and convert to integer percent 
    count_c = 0
    count_all = 0
    for c in string
        count_c += c == char ? 1 : 0
        count_all += 1
    end
    Int( round( count_c / count_all * 100 ) )
end

percent_char_v2(string, char) =
    # size( findall( char, string ), 1 ) gives the count of all char in string
    # divide by length of string, times 100 and convert to Int
    Int( round( size( findall( char, string ), 1 ) / length( string ) * 100 ) )

inputs = [("perl", 'e'), ("julia", 'j'), ("java", 'a')]
for (s, c) in inputs
    println( "char:", c, ", string:", s, " => ", percent_char_v2( s, c ) )
end
 
