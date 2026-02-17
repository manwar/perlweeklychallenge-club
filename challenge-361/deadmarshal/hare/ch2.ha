use fmt;

fn find_celebrity(party:[][]int) int = {
  const n = len(party):int;
  if(n == 0) return -1;

  let cand:int = 0;

  for(let i = 0i; i < n; i += 1) {
    if(party[cand][i] == 1) cand = i;
  };

  for(let i = 0i; i < n; i += 1) {
    if(i == cand) continue;
    if(party[cand][i] == 1 || party[i][cand] != 1) return -1;
  };

  return cand;
};

export fn main() void = {
  fmt::println(find_celebrity([[0,0,0,0,1,0],
			      [0,0,0,0,1,0],
			      [0,0,0,0,1,0],
			      [0,0,0,0,1,0],
			      [0,0,0,0,0,0],
			      [0,0,0,0,1,0]]))!;
  fmt::println(find_celebrity([[0,1,0,0],
			      [0,0,1,0],
			      [0,0,0,1],
			      [1,0,0,0]]))!;
  fmt::println(find_celebrity([[0,0,0,0,0],
			      [1,0,0,0,0],
			      [1,0,0,0,0],
			      [1,0,0,0,0],
			      [1,0,0,0,0]]))!;
  fmt::println(find_celebrity([[0,1,0,1,0,1],
			      [1,0,1,1,0,0],
			      [0,0,0,1,1,0],
			      [0,0,0,0,0,0],
			      [0,1,0,1,0,0],
			      [1,0,1,1,0,0]]))!;
  fmt::println(find_celebrity([[0,1,1,0],
			      [1,0,1,0],
			      [0,0,0,0],
			      [0,0,0,0]]))!;
  fmt::println(find_celebrity([[0,0,1,1],
			      [1,0,0,0],
			      [1,1,0,1],
			      [1,1,0,0]]))!;
};
