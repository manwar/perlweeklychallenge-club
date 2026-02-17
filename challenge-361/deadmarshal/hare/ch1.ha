use fmt;

fn fibs(n:int) ([]int | nomem) = {
  let fibs:[]int = [];
  append(fibs,1)?;
  append(fibs,2)?;
  for(fibs[len(fibs)-1] + fibs[len(fibs)-2] <= n) {
    append(fibs,fibs[len(fibs)-1] + fibs[len(fibs)-2])?;
  };
  return fibs;
};

fn zeckendorf_representation(n:int) ([]int | nomem) = {
  let fibs:[]int = fibs(n)?;
  let i:size = len(fibs)-1;
  let rem:int = n;
  let parts:[]int = [];
  for(rem != 0) {
    if(fibs[i] <= rem) {
      append(parts,fibs[i])?;
      rem -= fibs[i];
      i -= 2;
    } else {
      i -= 1;
    };
  };
  return parts;
};

fn check_and_print(n:int) void = {
  const res = match(zeckendorf_representation(n)) {
    case nomem => fmt::fatal("Ran out of memory!");
    case let s:[]int => yield s;
  };
  for(let i = 0z; i < len(res); i += 1) {
    fmt::print(res[i]," ")!;
  };
  fmt::println()!;
};

export fn main() void = {
  check_and_print(4);
  check_and_print(12);
  check_and_print(20);
  check_and_print(96);
  check_and_print(100);
};