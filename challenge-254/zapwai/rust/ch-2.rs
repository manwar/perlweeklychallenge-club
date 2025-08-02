fn main() {
    let words = ["Raku", "Perl", "Julia", "Uaia"];
    for w in words {
	proc(w);
    }
}

fn proc(word : &str) {
    let mut vows = Vec::new();
    let mut inds = Vec::new();
    let mut w = Vec::new();
    for c in word.chars() {
	w.push(c);
    }
    for i in 0 .. word.len() {
	let l = w[i];
	if l == 'a' || l == 'A' || 
	   l == 'e' || l == 'E' || 
	   l == 'i' || l == 'I' || 
	   l == 'o' || l == 'O' || 
	   l == 'u' || l == 'U'
	{
	   vows.push(l);
	   inds.push(i);
	}
    }
    inds.push(0);
    let k = vows.len()-1;
    let mut j = 0;
    for i in 0 .. word.len() {
	if i == inds[j] {
	   print!("{}", vows[k-j]);
	   j += 1;
	} else {
	   print!("{}", w[i]);
	}
    }
    println!("");
}