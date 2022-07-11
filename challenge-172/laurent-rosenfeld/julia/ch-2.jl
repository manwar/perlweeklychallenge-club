using Statistics

moons = sort([0, 0, 1, 2, 63, 61, 27, 13])

min = moons[1]  # Julia indices start at 1
first_quart = quantile(moons, 0.25)
median = quantile(moons, 0.5)
third_quart = quantile(moons, 0.75)
max = last(moons)

println("Min: $min; First quartile = $first_quart; Median: $median; Third quartile: $third_quart; Max: $max")
