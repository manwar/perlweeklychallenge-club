fact = 1
left_fact = 1
for n in 1..10
    printf "%d ", left_fact
    fact *= n
    left_fact += fact
end
printf "\n"
