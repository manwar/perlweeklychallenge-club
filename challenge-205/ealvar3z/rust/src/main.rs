#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    pub fn test_task_one() {
        let a = [5,3,4];
        let b = [5,6];
        let c = [5,4,4,3];

        assert_eq!(task_one(&a), 3);
        assert_eq!(task_one(&b), 6);
        assert_eq!(task_one(&c), 3);
    }

    #[test]
    pub fn test_task_two() {
        let a = [1,2,3,4,5,6,7];
        let b = [2,4,1,3];
        let c = [10,5,7,12,8];

        assert_eq!(task_two(&a), 7);
        assert_eq!(task_two(&b), 7);
        assert_eq!(task_two(&c), 15);
    }
}

pub fn task_one(arr: &[i32]) -> i32 {
    let highest = arr.iter().max().cloned().unwrap_or_default();
    let x = arr.iter().filter(|&i| *i != highest);
    let snd_highest = x.clone().max().cloned().unwrap_or_default();
    let third_highest = x.filter(|&i| *i != snd_highest);
    return *third_highest.max().unwrap_or(&highest);
}

pub fn task_two(arr: &[i32]) -> i32 {
    arr.iter()
        .enumerate()
        .fold(0, |max_xor, (i, &x)| {
            arr[i+1..]
                .iter()
                .fold(max_xor, |max_xor, &y| {
                    let xor = x ^ y;
                    return xor.max(max_xor)
                })
        })
}

fn main() {
    #[cfg(test)]
    mod test_runner {
        use super::tests;

        pub fn run() {
            tests::test_task_one();
            tests::test_task_two();
        }
    }

    #[cfg(test)]
    test_runner::run();
}

