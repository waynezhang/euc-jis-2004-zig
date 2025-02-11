# euc-jis-2004-zig

A library to convert EUC-JIS-2004 to UTF-8

## Install

### Add dependency

```zig
zig fetch --save "git+https://github.com/waynezhang/euc-jis-2004-zig"
```

### Add module

```zig
exe.root_module.addImport("euc-jis-2004", b.dependency("euc-jis-2004-zig", .{}).module("euc-jis-2004"));
```

## Usage

```zig
const euc_jp = @import("euc-jis-2004");

var output = [_]u8{0} ** 4096;

if (euc_jp.convertEucJpToUtf8(line, output)) |utf8_line| {
    // do something
} else |err| {
    // handle err
}

if (euc_jp.convertEucJpToUtf8Alloc(allocator, line)) |utf8_line| {
    defer allocator.free(utf8_line);
    // do something
} else |err| {
    // handle err
}
```
