#!/usr/bin/env julia

using Unicode

function makeover(str::String) ::String
    return Unicode.normalize(str, stripmark=true)
end

println(makeover("ÃÊÍÒÙ"))
#AEIOU

println(makeover("âÊíÒÙ"))
#aEiOU

