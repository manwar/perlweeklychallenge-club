# The Weekly Challenge 162
# Task 1 ISBN-13
# Julia Solution

using IterTools

function p_int(s)
    return parse(Int64, s)
end



function lookup(partialisbn)
    return only(filter( d -> valid(partialisbn * string(d)), 0:9) )
end


function valid(isbn)
    weight = push!(repeat( [1,3], 6), 1)
    arr = p_int.(collect(
                   takestrict(
                     (filter(d-> (tryparse(Int64,d) isa Number),
                       split(isbn, ""))),
                     13)))
     return sum(Base.splat(*),zip(weight,arr)) % 10 == 0
end


#= testing
valid("978-0-306-40615-7") # "task example"
valid("978-1-492-04503-8") # "Think Julia"
valid("978-1-59327-666-9") # "How Software Works"
valid("978-1-260-08450-4") # "Database System Concepts"
!valid("1234567891234") # random sequence of digits

lookup("978-0-306-40615-?") # "task example"
lookup("978-1-492-04503-?") # "Think Julia"
lookup("978-1-59327-666-") # "How Software Works"
lookup("978-1-260-08450-") # "Database System Concepts"
=#
