# Advanced Testing With Jasmine

## Using Jasmine's Clock

test javascipt timer relative code

- add new describe block

```
describe('The addAfterDelay method', function(){
  var noop = function() {};

  beforeEach(function(){
    spyOn(numbers, 'add');

    jasmine.clock().install();
    // 載入clock
  });

  afterEach(function(){
    jasmine.clock().uninstall();
    // 卸載 clock
  });


  it('should invoke the add method after a specified delay', function() {
    numbers.addAfterDelay(1000, noop, 1, 2);
    expect(numbers.add).not.toHaveBeenCalled();

    jasmine.clock().tick(1001); // 快轉1秒
    expect(numbers.add).toHaveBeenCalled();
  });

});
```

- scripts/numbers.js

```
self.addAfterDelay = function addAfterDelay(delay, callback) {
  var timeoutDelay = Array.prototype.shift.call(arguments),
      callback = Array.prototype.shift.call(arguments),
      operands = arguments;

  window.setTimeout(function(){
    callback(self.add.apply(this, operands))
  }, delay);
}
```

## Asynchronous Specs

應用於程式不會馬上得到回應的情況，例如ajax

Related files:
- [Numbers API](http://numbersapi.com/)
- [jQuery 2.1.1](http://code.jquery.com/jquery-2.1.1.min.js)

download jquery to dev/scripts folder and rename it to jquery.js
it makes ajax request easier

- scripts/numbers.js

```
// 載入jquery
define(['events', 'jquery'], function(events, $){
  ...
  self.add = function add() {
    ...

    $.get('http://numbersapi.com/' + total + '/trivia', function(fact){
      events.publish('added', {
        operands: operands,
        result: total,
        trivia: fact
      });
    });

    return total;
  };
end
```

- 修改 spec/numbers.js

```
it('should publish an added event showing the operands passed to the method, the result and the fact', function(done) {
  ...

  var that = this;

  events.subscribe('added', function(data) {
    console.log(data.triviaFact);
    expect(data.operands).toEqual([that.numberInput1, that.numberInput2]);
    expect(data.result).toEqual(3);
    expect(data.triviaFact).toEqual(jasmine.any(String));

    done();
  });
});
```

