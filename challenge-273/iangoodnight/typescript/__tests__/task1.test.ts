import percentageOfCharacter from '../task1';

test('Task 1: Percentage of Character', () => {
  expect(percentageOfCharacter('perl', 'e')).toBe(25);
  expect(percentageOfCharacter('java', 'a')).toBe(50);
  expect(percentageOfCharacter('python', 'm')).toBe(0);
  expect(percentageOfCharacter('ada', 'a')).toBe(67);
  expect(percentageOfCharacter('ballerina', 'l')).toBe(22);
  expect(percentageOfCharacter('analitik', 'k')).toBe(13);
});
