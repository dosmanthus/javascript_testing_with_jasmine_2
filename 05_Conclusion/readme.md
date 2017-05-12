# Conclusion

## Jasmine basics

- Create test suites with the describe method
- Create test cases with the it method
- Designed to support Behavior Driven Development
- Make assertions with the expect method and a matcher
- beforeEach and afterEach to keep tests DRY
- Use JSCover to generate coverage

## Jasmine Spies

- Use the Spyon method to create stubs and spy on them
- Methods and properties to control the spy's behaviour
- callFake() to delegate to a custom implementation
- callThrough() to delegate to the actual implementation
- calls tracking property:
  - Number of times it was called
  - Arguments passed to it

## Advanced Jasmine

- How to create custom matchers
- Testing code with timers using the Clock
- How to test asychronous code