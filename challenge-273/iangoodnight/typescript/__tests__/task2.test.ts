import bAfterA from '../task2';

describe('Task 2: B After A', () => {
  test('Example 1', () => {
    expect(bAfterA('aabb')).toBe(true);
  });

  test('Example 2', () => {
    expect(bAfterA('abab')).toBe(false);
  });

  test('Example 3', () => {
    expect(bAfterA('aaa')).toBe(false);
  });

  test('Example 4', () => {
    expect(bAfterA('bbb')).toBe(true);
  });
});
