def dot_product(a1, a2)
    res = 0
    a1.each_with_index do |v, i|
        res += v * a2[i]
    end
    return res
end
print dot_product([1, 2, 3], [4, 5, 6]), "\n"
