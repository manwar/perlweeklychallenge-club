
function check_square( key )
    column, row = collect( key )
    (Int(column) + Int(row)) % 2 == 1
end

for input = ["a1", "f1", "d8"]
    println( input, " => ", check_square(input) )
end
