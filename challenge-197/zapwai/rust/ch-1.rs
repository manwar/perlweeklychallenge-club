fn main() {
    // let mut v = vec![0,1,0,2,0];    
    let mut v = vec![1,0,3,0,0,5];
    println!("Input: {:?}",v);
    let origlen = v.len();
    v.retain( |&x| x != 0 );
    let len = origlen - v.len();
    let z = vec![0;len];
    v = [v,z].concat();
    println!("Output: {:?}",v);
}
