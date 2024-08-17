function make_to_goat_latin_v1( str_in )
    suffix = "ma"
    goat_words = []
    for word in split(
        replace(
            str_in,
            r"\b([BCDFGHJKLMNPQRSTVWXYZ])(\w+)\b"i => s"\2\1"
        )
        )
        word *= suffix
        suffix *= 'a'
        println(word)
        push!( goat_words, word )
    end
    join(goat_words, " ") 
end

function make_to_goat_latin_v2( str_in )
    word_chars = ['A':'Z';'a':'z']
    
    current_word = []
    out_vec = []
    suffix = "ma"

    for char in str_in
        if char in word_chars
            push!( current_word, char )
        else
            if size( current_word, 1 ) > 0
                suffix *= 'a'
                word = join( current_word, "" )
                current_word = []
                word = replace( word, r"([^AEIOU])(.*)"i => s"\2\1" )
                push!( out_vec, word * suffix )
            end
            push!( out_vec, char )
        end
    end
    join( out_vec, "" )
end

inputs = [
"I love Perl",
"Perl and Raku are friends",
"The Weekly Challenge",
"Perl! and Raku?     are... friends>",
"ya wanna do mathy stuff? then ya got Julia!!!"
]

for input = inputs
    println( make_to_goat_latin_v2(input) )
end
