# Ruby automatically switches to Bignum when needed
s = 2
print("#{s}\n")
for i in 1..9
    s = s * (s - 1) + 1
    print("#{s}\n")
end
