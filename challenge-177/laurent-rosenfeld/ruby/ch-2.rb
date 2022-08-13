require 'prime'

def is_cyclops (num)
    s = num.to_s
    len = s.length;
    if len % 2 == 0 then
        return false
    end
    mid = (len - 1) / 2
    if s[mid] != '0' then
        return false
    end
    if s[0..mid-1][/0/] || s[mid+1..len-1][/0/]
        return false
    end
    return true
end

count = 0;
range = [ 100..999, 10000..99999, 1000000..9999999 ].map { |r| Array(r) }.inject( :+ )
for i in range
    if i.to_s != i.to_s.reverse || ! is_cyclops(i)
        next
    end
    if i.prime?
        printf("%d ", i)
        count += 1;
        if count == 20
            break
        end
    end
end
puts ""
