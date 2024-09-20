const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const libp2p_dep = b.dependency("libp2p", .{ .target = target, .optimize = optimize });

    const lib = b.addStaticLibrary(.{
        .name = "p2p",
        .target = target,
        .optimize = optimize,
    });

    lib.addIncludePath(libp2p_dep.path("."));
    lib.addCSourceFiles(.{
        .files = &.{
            "p2p_api.cpp",
            "v210.cpp",
            "simd/cpuinfo_x86.cpp",
            "simd/p2p_simd.cpp",
            "simd/p2p_sse41.cpp",
        },
        .flags = &.{
            "-std=c++14",
        },
    });

    lib.linkLibCpp();

    _ = b.addModule("p2p", .{
        .root_source_file = b.path("src/main.zig"),
    });

    b.installArtifact(lib);
}
