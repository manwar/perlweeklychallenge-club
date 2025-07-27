-- http://lua-users.org/wiki/StringTrim
function Trim(s)
   return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end

function Last_length (X)
    local words = {}

    for word in Trim(X):gmatch("%w+") do
        table.insert(words, word)
    end

    local last_word = words[#words]
    print(#last_word)

end

Last_length("The Weekly Challenge")
Last_length("   Hello   World    ")
Last_length("Let's begin the fun")
