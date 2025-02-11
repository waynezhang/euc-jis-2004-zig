const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("euc-jis-2004", .{
        .root_source_file = b.path("src/euc-jis-2004.zig"),
        .target = target,
        .optimize = optimize,
    });

    const tests = b.addTest(.{
        .root_source_file = b.path("src/euc-jis-2004.zig"),
        .target = target,
        .optimize = optimize,
    });
    const protest_mod = b.dependency("protest", .{
        .target = target,
        .optimize = optimize,
    }).module("protest");
    tests.root_module.addImport("protest", protest_mod);

    const run_tests = b.addRunArtifact(tests);
    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_tests.step);
}
