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