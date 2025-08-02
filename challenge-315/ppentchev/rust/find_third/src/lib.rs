//! Weekly challenge 315 task 2 - find words following the specified two.

use std::iter::FusedIterator;

struct FindThird<'data, I: Iterator<Item = &'data str>> {
    it: I,
    done: bool,

    wfirst: &'data str,
    wsecond: &'data str,

    cfirst: Option<&'data str>,
    csecond: Option<&'data str>,
}

impl<'data, I: Iterator<Item = &'data str>> Iterator for FindThird<'data, I> {
    type Item = &'data str;

    fn next(&mut self) -> Option<Self::Item> {
        if self.done {
            return None;
        }

        loop {
            match self.it.next() {
                Some(wnext) => {
                    let owfirst = self.cfirst;
                    self.cfirst = self.csecond;
                    self.csecond = Some(wnext);

                    match (owfirst, self.cfirst) {
                        (Some(cwfirst), Some(cwsecond))
                            if cwfirst == self.wfirst && cwsecond == self.wsecond =>
                        {
                            return Some(wnext);
                        }
                        _ => (),
                    }
                }

                None => {
                    self.done = true;
                    return None;
                }
            }
        }
    }
}

impl<'data, I: Iterator<Item = &'data str>> FusedIterator for FindThird<'data, I> {}

/// Get all words that follow the specified two in the sentence.
pub fn find_third<ST: AsRef<str>, F: AsRef<str>, S: AsRef<str>>(
    sentence: ST,
    wfirst: F,
    wsecond: S,
) -> Vec<String> {
    let find_it = FindThird {
        it: sentence
            .as_ref()
            .split(|chr: char| !chr.is_ascii_uppercase() && !chr.is_ascii_lowercase())
            .filter(|part| !part.is_empty()),
        done: false,
        wfirst: wfirst.as_ref(),
        wsecond: wsecond.as_ref(),
        cfirst: None,
        csecond: None,
    };

    find_it.map(ToOwned::to_owned).collect()
}
