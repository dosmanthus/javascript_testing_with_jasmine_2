# Mocking

## Mocking Dependencies With Spies

- add events.js file to scripts folder
- spec/numbers.js

```
// add dependence 'events'
define(['numbers', 'events'], function(numbers, events){
  ...
      it('should publish an added event showing the operands passed to the method and the result', functoin() {
        // use spyOn(object, method) to spy a module
        spyOn(events, 'publish');
        output = numbers.add(this.numberInput1, this.numberInput2);
        expect(events.publish).toHaveBeenCalled();
        expect(events.publish).toHaveBeenCalledWith('added', { operands: [this.numberInput1, this.numberInput2], result: 3 });
      });
  ...
});
```

- scripts/numbers.js

```
// add dependence
define(['events'], function(events){
  ...

  self.add = function add() {
    ...

    events.publish('added', {
      operands: operands,
      result: total
    });

    return total;
  };
  ...
});
```

## Spy Methods

```
spyOn(events, 'publish');
spyOn(events, 'publish').and.callThrough(); // 實際執行
spyOn(events, 'publish').and.returnValue(false);
spyOn(events, 'publish').and.callFake(function(name, args) {
  window.alert(name);
}); // callback
spyOn(events, 'publish').and.throwError('oops');
// spyOn(events, 'publish').and.stub();
set a spy back to a stub method
expect(function(){
  numbers.add(1,1);
}).toThrowError('oops');
```

## The 'Calls' Tracking Property

- any
- count
- argsFor

```
spyOn(events, 'publish');
expect(events.publish.calls.any()).toBe(false);

numbers.add(this.numberInput1, this.numberInput2);
// expect(events.publish.calls.any()).toBe(true);
expect(events.publish.calls.count()).toEqual(1);

numbers.add(this.numberInput1, this.stringInput1);

expect(events.publish.calls.count()).toEqual(2);
// expect(events.publish.calls.argsFor(1)).toEqual(['added', { operands: [this.numberInput1, this.stringInput1], result: 2 }]);
// index 從 0 開始
expect(events.publish.calls.argsFor(1)).toEqual([jasmine.any(String), jasmine.any(Object)]);
```

## Additional Methods of the 'Calls' Property

- all
- reset

### all

```
var x, length, calls;
spyOn(events, 'publish');

numbers.add(this.numberInput1, this.numberInput2);
expect(events.publish.calls.count()).toEqual(1);

numbers.add(this.numberInput1, this.stringInput1);

expect(events.publish.calls.count()).toEqual(2);
expect(events.publish.calls.argsFor(1)).toEqual([jasmine.any(String), jasmine.any(Object)]);

calls = events.publish.calls.all();
for (x = 0, length = calls.length; x < length; x++) {
  expect(calls[x].object.id).toEqual('events');
}
```

增加 id 屬性到 events.js

```
self.id = 'events'
```

### reset

```
spyOn(events, 'publish');

numbers.add(this.numberInput1, this.numberInput2);
expect(events.publish.calls.count()).toEqual(1);

numbers.add(this.numberInput1, this.stringInput1);
events.publish.calls.reset();
expect(events.publish.calls.count()).toEqual(2); // throw error

```

## Creating Custom Matchers

- create test/lib/matchers.js

使用位元運算子 AND 來判斷是否爲奇數。

```
/*global define */
/* jslint bitwise: true */

define(function(){
  'use strict';

  var self = {};

  self.toBeOdd = function toBeOdd(){
    return {
      compare: function compare(actual) {
        var result = {};

        result.pass = !!(actual & 1);

        return result;
      }
    }
  };

  return self;
});
```

- 修改SpecRunner.html檔案

```
<script>
  require({
    baseUrl: '../dev/scripts',
    paths: {
      spec: '../../test/spec',
      lib: '../../test/lib'
    }
  }, ['spec/numbers'], function(numbers){
    jasmine.getEnv().execute();
  });
</script>
```

- 在spec檔案中載入 matcher

```
define(['numbers', 'events', 'lib/matchers'], function(numbers, events, matchers){
  ...
end
```

- 在beforeEach中載入custom matchers

```
beforeEach(function() {
  ...
  jasmine.addMatchers(matchers);
});

it('should return numbers that are either odd or even', function() {
  output = numbers.add(this.numberInput1, this.numberInput2);
  expect(output).toBeOdd();

  output = numbers.add(this.numberInput1, this.stringInput1);
  expect(output).not.toBeOdd();
});
```

- add custom failure messages

```
beforeEach(function() {
  ...
  jasmine.addMatchers(matchers);
});

it('should return numbers that are either odd or even', function() {
  output = numbers.add(this.numberInput1, this.numberInput2);
  expect(output).toBeOdd();

  output = numbers.add(this.numberInput1, this.stringInput1);
  expect(output).not.toBeOdd();

  expect(2).toBeOdd();
});
```

- matchers.js

```
...
  result.pass = !!(actual & 1);

  if (!result.pass) {
    result.message = 'Dude, ' + actual + ' is totally not odd';
  }
...
```

