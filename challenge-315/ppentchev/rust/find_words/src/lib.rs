//! Weekly challenge 315 task 1 - find words containing a character.

/// Get the indices of the words containing the specified character.
pub fn find_words<S: AsRef<str>, I: IntoIterator<Item = S>>(wlist: I, wchar: char) -> Vec<u32> {
    wlist
        .into_iter()
        .enumerate()
        .filter_map(|(idx, word)| word.as_ref().contains(wchar).then_some(idx as u32))
        .collect()
}
