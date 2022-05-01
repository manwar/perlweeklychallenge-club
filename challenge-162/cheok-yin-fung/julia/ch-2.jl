# The Weekly Challenge 162
# Task 2 Wheatstone-Playfair cipher
# Julia Solution, 
#     Partial (only encrypt has been implemented yet)
#         -- 1st May 2022 11AM HKT
# Usage: codify( key , word-to-be-encrypted)

using LinearAlgebra

function only_special(c)
    if c == "J"
        return 'I'
    else
        return only(c)
    end
end



function preprocess(word)
    word = replace(uppercase(word), " " => "", "J" => "I")
    word_a = split(word, "")
    new_word_a = []
    for i in 1:(length(word_a)-1)
        push!(new_word_a, word_a[i])
        if word_a[i] == word_a[i+1]
            push!(new_word_a, "X")
        end
    end
    new_word = join(new_word_a,"")*word_a[end]
    return new_word
end



function pairup(word)
    if length(word) % 2 == 1
        word *= "X"
    end
    word_h = []
    word_t = []
    flip = true
    for c in word
        if flip
            push!(word_h, c)
        else
            push!(word_t, c)
        end
        flip = !flip
    end
    return zip(word_h, word_t)
end



function playfair_board(key)
    letters = unique(Base.vcat(
        filter( c -> c != ' ' , 
                only_special.(split(uppercase(key), ""))
        ),
        Char.(vcat(codepoint('A'):codepoint('I'), 
                   codepoint('K'):codepoint('Z'))
        )
    ))

    board_vv = [ letters[ 1:5], 
                 letters[ 6:10],
                 letters[11:15],
                 letters[16:20],
                 letters[21:25] ]
    return Char.(transpose(codepoint.(reduce(hcat,board_vv))))
                    # transpose(reduce(hcat,board_vv))  does not work!
end



function codify(key, word)
    board = playfair_board(key)
    zipped_words = pairup(preprocess(word))
    encrypted_v = []
    for p in collect(zipped_words)
        (x1, y1) = Tuple(findfirst(c->c==first(p), board))
        (x2, y2) = Tuple(findfirst(c->c== last(p), board))
        if x1 == x2
            push!(encrypted_v, board[x1, 1+y1%5] * board[x2, 1+y2%5])
            continue
        end
        if y1 == y2
            push!(encrypted_v, board[1+x1%5, y1] * board[1+x2%5, y2])
            continue
        end
        push!(encrypted_v, board[x1,y2] * board[x2,y1])
    end
    
    return join(encrypted_v, "")
end



# codify("playfair example", "hide the gold in the tree stump")
