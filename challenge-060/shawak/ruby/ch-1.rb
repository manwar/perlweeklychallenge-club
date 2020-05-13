s=gets.chomp
r=?@
if s=~/\d+/ then
s.to_i.times{r=r.succ}
puts r
else
i=1
(i+=1)while((r=r.succ)!=s)
p i
end
