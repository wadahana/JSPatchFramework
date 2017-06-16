# JSPatchFramework

**转换JSPatch.js转换成C数组，集成到JPEngine**

````
>gcc bin2c.c -o bin2c
>./bin2c JSPatch/JSPatch.js > JSPatch/JSPatch.c

````

**console.log导到[JPEngineDelegate JPEngineLog:]输出**

````
context[@"_OC_log"] = ^() {
    NSArray *args = [JSContext currentArguments];
    for (JSValue *jsVal in args) {
        id obj = formatJSToOC(jsVal);
        if (_delegate && [_delegate respondsToSelector:@selector(JPEngineLog:)]) {
            NSString * content = [NSString stringWithFormat:@"%@", obj == _nilObj ? nil : (obj == _nullObj ? [NSNull null]: obj)];
            [_delegate JPEngineLog:content];
        } else {
            NSLog(@"JSPatch.log: %@", obj == _nilObj ? nil : (obj == _nullObj ? [NSNull null]: obj));
        }    
 
    }    
}; 
````

**build.sh 编译打包JSPatch.framework**

````
$./build.sh 
$ls -l 
total 24
drwxr-xr-x  8 wuxin  staff   272 Jun 16 10:58 JSPatch
drwxr-xr-x  6 wuxin  staff   204 Jun 16 10:58 JSPatch.framework
drwxr-xr-x@ 5 wuxin  staff   170 Jun 16 10:43 JSPatch.xcodeproj
-rw-r--r--@ 1 wuxin  staff   936 Jun 16 11:00 README.md
-rw-r--r--  1 wuxin  staff  1659 Jun 16 10:47 bin2c.c
drwxr-xr-x@ 5 wuxin  staff   170 Jun 16 10:58 build
-rwxr-xr-x  1 wuxin  staff  1756 Jun 16 10:44 build.sh
````
