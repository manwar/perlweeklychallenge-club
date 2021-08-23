function check(n)
    count = 0;
    for i in 2:n
        if ! contains("$i", "1")
            count += 1
        end
    end
    println("There are $count integers without a 1 in the 1..$n range.")
end
check(24);
