l=gets.split.map &:to_i
x,y=$<.map &:to_i
puts ((10**(x-1))..(10**x)-1).select{|x|x<y&&(x.digits-l).size<1}.join', '

# stdin:
# 0 1 2 5
# 2
# 21
