fn main()  {
    let ints = vec![1, 2, 2, 4, 1, 5];
    proc(ints);
    let ints2 = vec![1, 2, 3, 4, 5];
    proc(ints2);
}

fn proc(ints : Vec<i32>) {
    println!("Input: {:?}", ints);
    let mut nums : Vec<i32> = Vec::new();
    let mut freq : Vec<i32> = Vec::new();
    for _i in 0 .. 20 {
	freq.push(1);
    }
    for item in ints {
	let mut have = 0;
	for j in &nums {
	    if *j == item {
		have += 1;
	    }
	}
	if have == 0 {
	    nums.push(item);
	} else {
	    freq[item as usize] = have + 1;
	}
    }
    let mut mostfreq :Vec<i32> = Vec::new();
    let mut f = 0;
    for num in &nums {
	if freq[*num as usize] > f {
	    f = freq[*num as usize];
	}
    }
    for num in &nums {
	if freq[*num as usize] == f {
	    mostfreq.push(*num);
	}
    }
    println!("Output: The most frequent is {:?} with {f} occurrences.", mostfreq);
}
