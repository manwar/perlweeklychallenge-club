function is_valid(n) {
    t = 0
    for (j = 1; j <= length(n); j++) {
        t = substr(damm[t],substr(n, j, 1) + 1 ,1)
    }
    return t == 0
}
function populate_damm() {
    damm[0] = "0317598642"
    damm[1] = "7092154863"
    damm[2] = "4206871359"
    damm[3] = "1750983426"
    damm[4] = "6123045978"
    damm[5] = "3674209581"
    damm[6] = "5869720134"
    damm[7] = "8945362017"
    damm[8] = "9438617205"
    damm[9] = "2581436790"
}
BEGIN {
    populate_damm()
    print("Valid numbers between 5700 and 5800 are: ")
    for (i  = 5700; i<= 5800; i++) {
        if (is_valid(i)) {
            printf("%d ", i)
        }
    }
}
