#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-09-12
# Challenge 182 Max Index ch-1.pl ( Julia )

n_arr = [5, 2, 9, 1, 7, 6]

n_ndx = Dict()

count = 1

for x in n_arr

  n_ndx[x] = count

  global count += 1

end

n_srt = reverse(sort(n_arr))

println("Input: @n = ",n_arr)

println("Output: ", n_ndx[n_srt[1]]-1)
