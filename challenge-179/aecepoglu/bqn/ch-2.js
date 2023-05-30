const steps="▁▂▃▄▅▆▇█"

sol = list => {
  max = Math.max(...list)
  return list.map(x => steps[Math.round(7*(x/max))]).join("")
}

sol([1,2,5,3,2,4,6].map(x => x * 3))
