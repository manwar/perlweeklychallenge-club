struct Pwc048_1 {
    array: Vec<i32>,
    index: usize,
}

impl Iterator for Pwc048_1 {
    type Item = i32;
    fn next(&mut self) -> Option<i32> {
        let val = self.array[self.index];
        self.index = (self.index + 1) % self.array.len();
        self.array.remove(self.index);
        if !self.array.is_empty() {
            self.index = self.index % self.array.len();
            Some(val)
        } else {
            None
        }
    }
}

fn main() {
    let arr = Pwc048_1 {
        array: (1..=50).collect(),
        index: 0,
    };
    print!("Survivors, in order: {:?} ", arr.collect::<Vec<i32>>());
}
