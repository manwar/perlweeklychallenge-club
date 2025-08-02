#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
let lines = [
  "#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off",
  "let lines = [",
  "]",
  "echo lines[0]",
  "echo lines[1]",
  "for d in lines:",
  "  echo ' ', ' ', chr 34, d, chr 34, ','",
  "for d in lines[2..^1]:",
  "  echo d",
]
echo lines[0]
echo lines[1]
for d in lines:
  echo ' ', ' ', chr 34, d, chr 34, ','
for d in lines[2..^1]:
  echo d
