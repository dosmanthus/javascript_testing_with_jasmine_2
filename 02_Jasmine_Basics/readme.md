# Jasmine Basics

## Defining Test Suites With the Describe Method

- 在spec資料夾中建立 numbers.js 檔案

```
/*globals define, describe*/

define(['numbers'], function(numbers){
  'use strict';

  describe('The numbers module', function(){
    describe('The add method', function(){
      ...
    });
  });
});
```

- 修改SpecRunner.html檔案

```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Jasmine Spec Runner v2.6.1</title>

  <link rel="shortcut icon" type="image/png" href="lib/jasmine-2.6.1/jasmine_favicon.png">
  <link rel="stylesheet" href="lib/jasmine-2.6.1/jasmine.css">
  <script src="../dev/lib/require.js"></script>
  <script src="lib/jasmine-2.6.1/jasmine.js"></script>
  <script src="lib/jasmine-2.6.1/jasmine-html.js"></script>
  <script src="lib/jasmine-2.6.1/boot.js"></script>

</head>

<body>
</body>
</html>
```

- config require.js

在SpecRunner.html的 <body> 中插入：

```
<script>
  require({
    baseUrl: '../dev/scripts', // 相對於SpecRunner的位置
    paths: {
      spec: '../../test/spec' // 相對於baseUrl的位置
    }
  }, ['spec/numbers'], function(numbers){
    jasmine.getEnv().execute();
  });
</script>
```

- 防止SpecRunner自動執行，需等待require執行完畢後才執行。

修改lib/jasmine folder下的 boot.js 檔案, 將 “env.execute();”註解掉：

```
//env.execute();
```

- 執行 SpecRunner.html

## Creating Test Cases With the 'it' Method

```
/*globals define, describe*/

define(['numbers'], function(numbers){
  'use strict';

  describe('The numbers module', function(){
    describe('The add method', function(){
      it('accepts one or more numberical arguments and return the sum of them', function(){
        ...
      });
    });
  });
});
```

### pending a spec

- 將 it 後面的 callback function 移除。
- 可以使用 `pending();` 語法來 pending 測試。
- 或是在 it 或 describe 前加上x。

## The 'Expect' Method

```
it('accepts one or more numberical arguments and return the sum of them', function(){
  // arrange
  var output,
    input1 = 1,
    input2 = 2;
  // act
  output = numbers.add(input1, input2);
  // assert
  expect(output).toEqual(2);
  expect(output).not.toEqual(4);
});
```

完成expect之後會得到 Failures 訊息：

```
TypeError: numbers.add is not a function
```

撰寫實際的code：

```
/*globals define*/
define(function(){
  'use strict';
  var self = {};

  self.add = function add() {
    // 將函數的實際參數轉換成數組
    var operands = Array.prototype.slice.call(arguments),
        total = 0;
    operands.forEach(function(element) {
      total += element;
    });

    return total;
  }

  return self;
});
```

## Set-Up and Tear-Down

首先，增加另一個測試：

```
it('should try to parse an integer when a string is passed to the method', () => {
  var output,
      input1 = 1,
      input2 = '2';

  output = numbers.add(input1, input2);

  expect(output).toEqual(3);
});
```

修正 scripts/numbers.js，在 forEach loop 裡加入：

```
if (typeof element === 'string') {
  element = parseInt(element, 10)
}
// total += element; 前
```

利用 beforeEach() 整理重複使用到的 code

```
describe('The add method', function(){
  var output;

  beforeEach(function(){
    this.numberInput1 = 1;
    this.numberInput2 = 2;
    this.stringInput1 = '1';
    this.stringInput2 = 'oops'
  });

  it('accepts one or more numberical arguments and return the sum of them', function(){
    // act
    output = numbers.add(this.numberInput1, this.numberInput2);
    // assert
    expect(output).toEqual(3);
    expect(output).not.toEqual(4);
  });


  it('should try to parse an integer when a string is passed to the method', function() {
    output = numbers.add(this.numberInput1, this.stringInput1);
    expect(output).toEqual(2);
  });


  it('should ignore the argument if it is not a preseable string', function() {
    output = numbers.add(this.numberInput1, this.stringInput2);
    expect(output).toEqual(1);
  });
});
```

## Getting Coverage Results

待更新...