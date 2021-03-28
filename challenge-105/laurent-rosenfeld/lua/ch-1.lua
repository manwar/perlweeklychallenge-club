input = 248832
for i = 1, 10 do
    print (string.format("%2d  %10.3f", i, input ^ (1/i)))
end
