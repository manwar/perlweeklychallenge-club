/*
-------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-08
Challenge 20t H-Index ( Rust )
-------------------------------
*/
fn calc_index(a: &[usize]) {
    let ln = a.len()-1;
    let mut offset = ln;
    let mut pos = ln;
    while offset >= 0 {
        if a[offset] >= pos {
            print!("Output: {:?}\n",a[offset]);
            print!("\n");
            return;
        } else {
            offset -= 1;
            pos -= 1;
        }
    }
}

fn main() {
    let citations = [[10,8,5,4,3],[25,8,5,3,3]];
    for i in 0..citations.len() {
        let a1 = citations[i];
        print!("Input: @cititaions = {:?}\n",a1);
        calc_index(&a1);
    }
}

/*
-------------------------------------
SAMPLE OUTPUT
nput: @cititaions = [10, 8, 5, 4, 3]
Output: 4

Input: @cititaions = [25, 8, 5, 3, 3]
Output: 3
-------------------------------------
*/
