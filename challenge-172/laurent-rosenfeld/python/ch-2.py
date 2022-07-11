def median(n):
  c = len(n)
  return n[int((c - 1) / 2)] if c % 2 != 0 else (n[int(c/2 -1)] + n[int(c/2)])/2


def summary(input):
  min = input[0]
  max = input[-1]
  med = median(input)
  lower_half = list(filter(lambda p: p < med, input))
  # print(lower_half)
  first_quart = median(lower_half)
  third_quart = median(list(filter(lambda p: p > med, input)))
  return(min, first_quart, med, third_quart, max)

moons = sorted([0, 0, 1, 2, 63, 61, 27, 13])
print(summary(moons));
