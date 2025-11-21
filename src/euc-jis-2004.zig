const std = @import("std");
const table = @import("table.zig");

pub fn convertEucJpToUtf8(input: []const u8, output: []u8) ![]const u8 {
    var i: usize = 0;
    var offset: usize = 0;
    while (i < input.len) {
        switch (input[i]) {
            0x00...0x7E => {
                offset += try std.unicode.utf8Encode(input[i], output[offset..]);
                i += 1;
            },
            0x8E => {
                if (i + 1 == input.len) {
                    return error.InvalidCharacter;
                }
                const c1 = input[i + 1];
                if (c1 < 0xA1 or c1 > 0xDF) {
                    return error.InvalidCharacter;
                }
                const val = @as(u21, c1) + @as(u21, 0xFF61 - 0xA1);
                offset += try std.unicode.utf8Encode(val, output[offset..]);
                i += 2;
            },
            0x8F => {
                if (i + 2 >= input.len) {
                    return error.InvalidCharacter;
                }
                const c1 = input[i + 1];
                if (c1 < 0xA1 or c1 > 0xFE) {
                    return error.InvalidCharacter;
                }
                const c2 = input[i + 2];
                if (c2 < 0xA1 or (c1 == 0xFE and c2 > 0xF6)) {
                    return error.InvalidCharacter;
                }
                const idx = (@as(u21, c1) << 8) + @as(u21, c2) - 0xA1A1;
                const val = table.eucJis2ndMap[idx];
                offset += try std.unicode.utf8Encode(val, output[offset..]);
                i += 3;
            },
            0xA1...0xFE => {
                if (i + 1 == input.len) {
                    return error.InvalidCharacter;
                }

                const c1 = input[i + 1];
                if (c1 < 0xA1 or c1 > 0xFE) {
                    return error.InvalidCharacter;
                }

                const idx = (@as(u21, input[i]) << 8) + @as(u21, c1);
                switch (idx) {
                    0xA4F7 => {
                        offset += try std.unicode.utf8Encode(0x304B, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xA4F8 => {
                        offset += try std.unicode.utf8Encode(0x304D, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xA4F9 => {
                        offset += try std.unicode.utf8Encode(0x304F, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xA4FA => {
                        offset += try std.unicode.utf8Encode(0x3051, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xA4FB => {
                        offset += try std.unicode.utf8Encode(0x3053, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xA5F7 => {
                        offset += try std.unicode.utf8Encode(0x30AB, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xA5F8 => {
                        offset += try std.unicode.utf8Encode(0x30AD, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xA5F9 => {
                        offset += try std.unicode.utf8Encode(0x30AF, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xA5FA => {
                        offset += try std.unicode.utf8Encode(0x30B1, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xA5FB => {
                        offset += try std.unicode.utf8Encode(0x30B3, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xA5FC => {
                        offset += try std.unicode.utf8Encode(0x30BB, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xA5FD => {
                        offset += try std.unicode.utf8Encode(0x30C4, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xA5FE => {
                        offset += try std.unicode.utf8Encode(0x30C8, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xA6F8 => {
                        offset += try std.unicode.utf8Encode(0x31F7, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x309A, output[offset..]);
                    },
                    0xABC4 => {
                        offset += try std.unicode.utf8Encode(0xE6, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x300, output[offset..]);
                    },
                    0xABC8 => {
                        offset += try std.unicode.utf8Encode(0x254, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x300, output[offset..]);
                    },
                    0xABC9 => {
                        offset += try std.unicode.utf8Encode(0x254, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x301, output[offset..]);
                    },
                    0xABCA => {
                        offset += try std.unicode.utf8Encode(0x28C, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x300, output[offset..]);
                    },
                    0xABCB => {
                        offset += try std.unicode.utf8Encode(0x28C, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x301, output[offset..]);
                    },
                    0xABCC => {
                        offset += try std.unicode.utf8Encode(0x259, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x300, output[offset..]);
                    },
                    0xABCD => {
                        offset += try std.unicode.utf8Encode(0x259, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x301, output[offset..]);
                    },
                    0xABCE => {
                        offset += try std.unicode.utf8Encode(0x25A, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x300, output[offset..]);
                    },
                    0xABCF => {
                        offset += try std.unicode.utf8Encode(0x25A, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x301, output[offset..]);
                    },
                    0xABE5 => {
                        offset += try std.unicode.utf8Encode(0x2E9, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x2E5, output[offset..]);
                    },
                    0xABE6 => {
                        offset += try std.unicode.utf8Encode(0x2E5, output[offset..]);
                        offset += try std.unicode.utf8Encode(0x2E9, output[offset..]);
                    },
                    else => {
                        offset += try std.unicode.utf8Encode(table.eucJis1stMap[idx - 0xA1A1], output[offset..]);
                    },
                }
                i += 2;
            },
            else => {
                return error.InvalidCharacter;
            },
        }
    }
    return output[0..offset];
}

/// Convert EUC-JP-2004 to UTF-8
/// Caller own the memory
pub fn convertEucJpToUtf8Alloc(allocator: std.mem.Allocator, input: []const u8) ![]const u8 {
    var output: std.ArrayListUnmanaged(u8) = .empty;
    defer output.deinit(allocator);

    try output.ensureTotalCapacity(allocator, input.len * 2);
    output.expandToCapacity();

    const result = try convertEucJpToUtf8(input, output.items);
    output.shrinkRetainingCapacity(result.len);

    return output.toOwnedSlice(allocator);
}

fn append(output: *std.ArrayList(u8), n: u21) !void {
    var buf: [4]u8 = undefined;
    const len = std.unicode.utf8Encode(n, &buf) catch |err| {
        return err;
    };
    try output.appendSlice(buf[0..len]);
}

test "decode" {
    const efile = try std.fs.cwd().openFile("testdata/euc-jis-2004-with-char-u8.txt", .{});
    defer efile.close();

    const cfile = try std.fs.cwd().openFile("testdata/euc-jis-2004-with-char.txt", .{});
    defer cfile.close();

    var ebuf_reader_buffer: [8 * 1024]u8 = undefined;
    var ebuf_reader = efile.reader(&ebuf_reader_buffer);

    var cbuf_reader_buffer: [8 * 1024]u8 = undefined;
    var cbuf_reader = cfile.reader(&cbuf_reader_buffer);

    var line_buf = [_]u8{0} ** 4096;

    while (true) {
        const expect_line = try ebuf_reader.interface.takeDelimiter('\n') orelse &[_]u8{};
        const convert_line = try cbuf_reader.interface.takeDelimiter('\n') orelse &[_]u8{};

        if (convert_line.len == 0) {
            try std.testing.expectEqual(expect_line.len, 0);
            break;
        }

        const line = try convertEucJpToUtf8(convert_line, &line_buf);
        try std.testing.expectEqualStrings(expect_line, line);
    }
}

test "decode alloc" {
    const allocator = std.testing.allocator;

    const efile = try std.fs.cwd().openFile("testdata/euc-jis-2004-with-char-u8.txt", .{});
    defer efile.close();

    const cfile = try std.fs.cwd().openFile("testdata/euc-jis-2004-with-char.txt", .{});
    defer cfile.close();

    var ebuf_reader_buffer: [8 * 1024]u8 = undefined;
    var ebuf_reader = efile.reader(&ebuf_reader_buffer);

    var cbuf_reader_buffer: [8 * 1024]u8 = undefined;
    var cbuf_reader = cfile.reader(&cbuf_reader_buffer);

    while (true) {
        const expect_line = try ebuf_reader.interface.takeDelimiter('\n') orelse &[_]u8{};
        const convert_line = try cbuf_reader.interface.takeDelimiter('\n') orelse &[_]u8{};

        if (convert_line.len == 0) {
            try std.testing.expectEqual(expect_line.len, 0);
            break;
        }

        const line = try convertEucJpToUtf8Alloc(allocator, convert_line);
        defer allocator.free(line);

        try std.testing.expectEqualStrings(expect_line, line);
    }
}
