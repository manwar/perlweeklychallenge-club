#!/usr/bin/env julia

function capital_detection( s::String ) ::Bool
    myregex=r"^[A-Z]?[a-z]+$|^[A-Z]+$|^[a-z]+$"
    return occursin( myregex, s)
end

println("Perl: ", capital_detection("Perl"))
println("TPF: ", capital_detection("TPF"))
println("PyThon: ", capital_detection("PyThon"));
println("raku:", capital_detection("raku"));

