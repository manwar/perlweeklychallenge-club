const N :usize = 4;

fn id_mat(){
    let mut a = [[0;N];N];
    for i in 0..N {
	a[i][i] = 1;
    }
    for i in 0..N {
	println!("{:?}", a[i]);
}
}

fn main() {
    id_mat();
}
