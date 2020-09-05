use std::fs;
use std::path::Path;

use clap::{App, Arg, ArgMatches};
use itertools::Itertools;
use regex::RegexSetBuilder;

fn main() {
    let args = cli_args();

    let grid = SearchGrid::new(args.value_of("SEARCHGRID-FILE").unwrap());
    let words = read_words(args.value_of("WORDLIST-FILE").unwrap());

    let found = grid.find_words(&words);

    found.into_iter().for_each(|word| println!("{}", word));
}

struct SearchGrid {
    grid: Vec<Vec<char>>,
    width: isize,
    height: isize,
}

impl SearchGrid {
    fn new<P: AsRef<Path>>(file: P) -> SearchGrid {
        let data = fs::read_to_string(file).expect("Failed to read search grid");
        let grid = data.lines()
            .map(|line| line.chars()
                .filter(|ch| !ch.is_whitespace())
                .collect::<Vec<_>>())
            .collect::<Vec<_>>();
        if 1 != grid.iter().map(|chars| chars.len()).dedup().count() {
            panic!("Grid: Not all lines were of equal length");
        }
        let height = grid.len() as isize;
        if height == 0 {
            panic!("Grid: There were no lines");
        }
        let width = grid.first().unwrap().len() as isize;
        if width == 0 {
            panic!("Grid: All lines were empty");
        }
        SearchGrid {
            grid,
            width,
            height,
        }
    }

    fn find_words<'a>(&self, words: &'a[String]) -> Vec<&'a str> {
        // a regex set that matches all words
        let match_all_words = RegexSetBuilder::new(words.iter()
            // for each word, construct a regexp that matches the word in both directions
            .map(|word| format!("{}|{}",
                                regex::escape(word),
                                regex::escape(word.chars().rev().collect::<String>().as_str()))))
            .case_insensitive(true)
            .build()
            .unwrap();

        let left_coords = (0..self.height).map(|y| (0isize, y)).collect::<Vec<_>>();
        let top_coords = (0..self.width).map(|x| (x, 0isize)).collect::<Vec<_>>();
        let bottom_coords = (0..self.width).map(|x| (x, self.height - 1)).collect::<Vec<_>>();

        let mut strings = left_coords.iter().skip(1).map(|coord| self.string_from(coord, (1, -1))).collect::<Vec<String>>();
        strings.extend(left_coords.iter().map(|coord| self.string_from(coord, (1, 0))));
        strings.extend(left_coords.iter().rev().skip(1).map(|coord| self.string_from(coord, (1, 1))));
        strings.extend(top_coords.iter().map(|coord| self.string_from(coord, (0, 1))));
        strings.extend(top_coords.iter().skip(1).map(|coord| self.string_from(coord, (1, 1))));
        strings.extend(bottom_coords.iter().skip(1).map(|coord| self.string_from(coord, (1, -1))));

        strings.iter()
            .flat_map(|str| match_all_words.matches(str))
            .unique()
            .map(|idx| words[idx].as_ref())
            .collect()
    }

    fn string_from(&self, (xstart, ystart): &(isize, isize), (xinc, yinc): (isize, isize)) -> String {
        let max_extent = self.width.max(self.height);
        let x_coords = (0..max_extent).map(|pos| xstart + (xinc * pos));
        let y_coords = (0..max_extent).map(|pos| ystart + (yinc * pos));
        x_coords.zip(y_coords)
            .filter(|(x,y)| *x >= 0 && *y >= 0 && *x < self.width && *y < self.height)
            .map(|(x,y)| self.grid[y as usize][x as usize])
            .collect()
    }
}

fn read_words<P: AsRef<Path>>(file: P) -> Vec<String> {
    let data = fs::read_to_string(file).expect("Failed to read word list");
    data.lines().map(|str| str.to_string()).collect()
}

fn cli_args<'a>() -> ArgMatches<'a> {
    App::new("pwc076 task 2")
        .version("1.0")
        .author("Jonas Berlin <xkr47@outerspace.dyndns.org>")
        .about("https://perlweeklychallenge.org/blog/perl-weekly-challenge-076/#TASK2")
        .arg(Arg::with_name("SEARCHGRID-FILE")
            .help("Filename for search grid")
            .required(true)
            .index(1))
        .arg(Arg::with_name("WORDLIST-FILE")
            .help("Filename for word list")
            .required(true)
            .index(2))
        .get_matches()
}
