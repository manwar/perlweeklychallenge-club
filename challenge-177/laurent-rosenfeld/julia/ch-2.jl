using Primes

function is_cyclops(n)
    s = string(n)
    len = length(s)
    len % 2 == 0 && return false
    mid = Int((len + 1) /2)
    s[mid] == '0' || return false
    if occursin('0', s[1:mid-1]) || occursin('0', s[mid+1:len])
        return false
    end
    return true;
end

count = 0
for i = [101:999; 10000:99999; 1000000:9999999]
    string(i) != reverse(string(i)) && continue
    is_cyclops(i) || continue
    if isprime(i)
        print("$i ")
        global count += 1
        count >= 20 && break
    end
end
println("")
