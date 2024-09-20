const std = @import("std");

pub const packing = enum(c_int) {
    rgb24_be,
    rgb24_le,
    rgb24,

    argb32_be,
    argb32_le,
    argb32,

    ayuv_be,
    ayuv_le,
    ayuv,

    rgb48_be,
    rgb48_le,
    rgb48,

    argb64_be,
    argb64_le,
    argb64,

    rgb30_be,
    rgb30_le,
    rgb30,

    y410_be,
    y410_le,
    y410,

    y412_be,
    y412_le,
    y412,

    y416_be,
    y416_le,
    y416,

    yuy2,

    uyvy,

    y210_be,
    y210_le,
    y210,

    y212_be,
    y212_le,
    y212,

    y216_be,
    y216_le,
    y216,

    v210_be,
    v210_le,
    v210,

    v216_be,
    v216_le,
    v216,

    nv12_be,
    nv12_le,
    nv12,

    nv16_be,
    nv16_le,
    nv16,

    p010_be,
    p010_le,
    p010,

    p012_be,
    p012_le,
    p012,

    p016_be,
    p016_le,
    p016,

    p210_be,
    p210_le,
    p210,

    p212_be,
    p212_le,
    p212,

    p216_be,
    p216_le,
    p216,

    rgba32_be,
    rgba32_le,
    rgba32,

    rgba64_be,
    rgba64_le,
    rgba64,

    abgr64_be,
    abgr64_le,
    abgr64,

    bgr48_be,
    bgr48_le,
    bgr48,

    bgra64_be,
    bgra64_le,
    bgra64,

    packing_max,
};

pub const buffer_param = extern struct {
    src: [4]?*const anyopaque,
    dst: [4]?*anyopaque,
    src_stride: [4]c_longlong,
    dst_stride: [4]c_longlong,
    width: c_uint,
    height: c_uint,
    packing: packing,
};

pub const Flags = enum(c_ulong) {
    SKIP_UNPACKED_PLANES = @as(c_ulong, 1) << 0,
    ALPHA_SET_ONE = @as(c_ulong, 1) << 1,
};

pub const unpack_func = ?*const fn (?*const anyopaque, [*c]const ?*anyopaque, c_uint, c_uint) callconv(.C) void;
pub const pack_func = ?*const fn ([*c]const ?*const anyopaque, ?*anyopaque, c_uint, c_uint) callconv(.C) void;

pub extern fn select_unpack_func(packing: packing) unpack_func;
pub extern fn select_pack_func(packing: packing) pack_func;
pub extern fn select_pack_func_ex(packing: packing, alpha_one_fill: c_int) pack_func;

pub extern fn unpack_frame(param: [*c]const buffer_param, flags: Flags) void;
pub extern fn pack_frame(param: [*c]const buffer_param, flags: Flags) void;
