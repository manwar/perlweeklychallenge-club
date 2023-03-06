use itertools::Itertools;

pub fn task_one(time_points: &[&str]) -> i32 {
    let mut minutes: Vec<i32> = time_points
        .iter()
        .map(|time| {
            let parts: Vec<&str> = time.split(':').collect();
            let hours: i32 = parts[0].parse().unwrap();
            let mins: i32 = parts[1].parse().unwrap();
            hours * 60 + mins
        })
        .collect();
    minutes.sort();
    let mut delta = 24 * 60;
    let first = minutes[0];
    let last = minutes[minutes.len() - 1];
    let circular_diff = first + (delta - last);
    delta = delta.min(circular_diff);
    for i in 1..minutes.len() {
        let diff = minutes[i] - minutes[i - 1];
        if diff < delta {
            delta = diff;
        }
    }
    println!("Output: {}", delta);
    return delta;
}

pub fn task_two(nums: &[i32]) -> i32 {
    let sum = nums.iter()
        .sorted()
        .step_by(2)
        .map(|x| *x)
        .sum();
    println!("Output: {}", sum);
    return  sum;
}

fn main() {
    println!("Task 1");
    test_task_one();
    println!();
    println!("Task 2");
    test_task_two();
}

fn test_task_one() {
    let a = ["00:00", "23:55", "20:00"];
    assert_eq!(task_one(&a), 5);

    let b = ["01:01", "00:50", "00:57"];
    assert_eq!(task_one(&b), 4);

    let c = ["10:10", "09:30", "09:00", "09:55"];
    assert_eq!(task_one(&c), 15);
}

fn test_task_two() {
    let a = [1, 2, 3, 4];
    assert_eq!(task_two(&a), 4);

    let b = [0, 2, 1, 3];
    assert_eq!(task_two(&b), 2);
}

