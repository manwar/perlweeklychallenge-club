i = 100
count = 0
while count < 20
    i++
    if i = 999
        i = 10000
    ok
    if i = 99999
        i = 1000000
    ok
    if is_palindrome(i)
        if is_cyclops(i)
            if is_prime(i)
                count++
                see "" + i + " "
            ok
       ok
   ok
end
see "" + nl

func is_prime (n)
    if n = 2
        return true
    ok
    if n < 2 or n % 2 = 0
        return false
    ok
    p = 3
    sqrt_n = sqrt(n)
    while p < sqrt_n
        if n % p = 0
            return false
        ok
        p++
    end
    return true

func is_cyclops(n)
    s = "" + n
    size = len(s)
    if size % 2 = 0
        return false
    ok
    mid = ( size + 1) / 2
    if s[mid] != 0
        return false
    ok

    if substr(left(s, mid-1), "0") > 0
        return false
    ok
    if substr(right(s, mid-1), "0") > 0
        return false
    ok
    return true

func is_palindrome(n)
    s = "" + n
    size = len(s)
    for i = 1 to size/2
        if s[i] != s[size - i + 1]
            return false
        ok
    next
    return true
