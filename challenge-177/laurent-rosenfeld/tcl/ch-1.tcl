proc is_valid {n} {
    set damm(0) "0317598642"
    set damm(1) "7092154863"
    set damm(2) "4206871359"
    set damm(3) "1750983426"
    set damm(4) "6123045978"
    set damm(5) "3674209581"
    set damm(6) "5869720134"
    set damm(7) "8945362017"
    set damm(8) "9438617205"
    set damm(9) "2581436790"

    set temp 0
    foreach ch [split $n {}] {
        set row $damm($temp)
        set temp [ string index $row $ch ]
    }
    return [ expr $temp == 0 ? 1 : 0]
}

puts "Valid numbers between 5700 and 5800 are: "
for {set i 5700} {$i <= 5800} {incr i} {
    if [ is_valid $i ] {
        puts -nonewline  "${i} "
    }
}
puts ""
