$fusc = Hash.new
$fusc[0] =  0
$fusc[1] =  1
$size    = 50

for i in 2 .. ($size-1) do
    if i % 2 == 0
        $fusc[i] = $fusc[i/2]
    else
        $fusc[i] = $fusc[(i-1)/2] + $fusc[(i+1)/2]
    end
end
for i in 0..($size-1) do
    print $fusc[i], " "
end
print "\n"
