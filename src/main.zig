const std = @import("std");

// const c = @cImport({
//     @cInclude("p2p_api.h");
// });

pub const p2p_packing = enum(c_int) {
    p2p_rgb24_be,
    p2p_rgb24_le,
    p2p_rgb24,

    p2p_argb32_be,
    p2p_argb32_le,
    p2p_argb32,

    p2p_ayuv_be,
    p2p_ayuv_le,
    p2p_ayuv,

    p2p_rgb48_be,
    p2p_rgb48_le,
    p2p_rgb48,

    p2p_argb64_be,
    p2p_argb64_le,
    p2p_argb64,

    p2p_rgb30_be,
    p2p_rgb30_le,
    p2p_rgb30,

    p2p_y410_be,
    p2p_y410_le,
    p2p_y410,

    p2p_y412_be,
    p2p_y412_le,
    p2p_y412,

    p2p_y416_be,
    p2p_y416_le,
    p2p_y416,

    p2p_yuy2,

    p2p_uyvy,

    p2p_y210_be,
    p2p_y210_le,
    p2p_y210,

    p2p_y212_be,
    p2p_y212_le,
    p2p_y212,

    p2p_y216_be,
    p2p_y216_le,
    p2p_y216,

    p2p_v210_be,
    p2p_v210_le,
    p2p_v210,

    p2p_v216_be,
    p2p_v216_le,
    p2p_v216,

    p2p_nv12_be,
    p2p_nv12_le,
    p2p_nv12,

    p2p_nv16_be,
    p2p_nv16_le,
    p2p_nv16,

    p2p_p010_be,
    p2p_p010_le,
    p2p_p010,

    p2p_p012_be,
    p2p_p012_le,
    p2p_p012,

    p2p_p016_be,
    p2p_p016_le,
    p2p_p016,

    p2p_p210_be,
    p2p_p210_le,
    p2p_p210,

    p2p_p212_be,
    p2p_p212_le,
    p2p_p212,

    p2p_p216_be,
    p2p_p216_le,
    p2p_p216,

    p2p_rgba32_be,
    p2p_rgba32_le,
    p2p_rgba32,

    p2p_rgba64_be,
    p2p_rgba64_le,
    p2p_rgba64,

    p2p_abgr64_be,
    p2p_abgr64_le,
    p2p_abgr64,

    p2p_bgr48_be,
    p2p_bgr48_le,
    p2p_bgr48,

    p2p_bgra64_be,
    p2p_bgra64_le,
    p2p_bgra64,

    p2p_packing_max,
};

const ptrdiff_t = c_longlong;
pub const p2p_buffer_param = extern struct {
    src: [4]?*const anyopaque = @import("std").mem.zeroes([4]?*const anyopaque),
    dst: [4]?*anyopaque = @import("std").mem.zeroes([4]?*anyopaque),
    src_stride: [4]ptrdiff_t = @import("std").mem.zeroes([4]ptrdiff_t),
    dst_stride: [4]ptrdiff_t = @import("std").mem.zeroes([4]ptrdiff_t),
    width: c_uint = @import("std").mem.zeroes(c_uint),
    height: c_uint = @import("std").mem.zeroes(c_uint),
    packing: p2p_packing = @import("std").mem.zeroes(p2p_packing),
};

pub const Flags = enum(c_ulong) {
    SKIP_UNPACKED_PLANES = @as(c_ulong, 1) << 0,
    ALPHA_SET_ONE = @as(c_ulong, 1) << 1,
};

pub const p2p_unpack_func = ?*const fn (?*const anyopaque, [*c]const ?*anyopaque, c_uint, c_uint) callconv(.C) void;
pub const p2p_pack_func = ?*const fn ([*c]const ?*const anyopaque, ?*anyopaque, c_uint, c_uint) callconv(.C) void;
pub extern fn p2p_select_unpack_func(packing: p2p_packing) p2p_unpack_func;
pub extern fn p2p_select_pack_func(packing: p2p_packing) p2p_pack_func;
pub extern fn p2p_select_pack_func_ex(packing: p2p_packing, alpha_one_fill: c_int) p2p_pack_func;
pub extern fn p2p_unpack_frame(param: [*c]const p2p_buffer_param, flags: c_ulong) void;
pub extern fn p2p_pack_frame(param: [*c]const p2p_buffer_param, flags: c_ulong) void;
