# cd ../..
java -Dfile.encoding=UTF-8  -jar JSCover-all.jar -ws --document-root=../ --report-dir=out --no-instrument=test --no-instrument=dev/lib --no-instrument=tools
#java -jar target/dist/JSCover-all.jar -ws --report-dir=target/phantom-server-jasmine --no-branch --only-instrument-reg=/src/main/resources/jscoverage-branch.js