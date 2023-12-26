const std = @import("std");
const testing = std.testing;

pub const vec3 = @import("vec3.zig");
pub const LinearRegression = @import("lin_reg.zig").LinearRegression;
pub const Secant = @import("secant.zig").Secant;
pub const Matrix = @import("mat.zig").Matrix;
pub const Binomial = @import("binomial.zig").Binomial;
pub const newtonInterpolation = @import("newton_interp.zig").newtonInterpolation;
pub const Stats = @import("stats.zig").Stats;
pub const taylorSeries = @import("taylor.zig").taylorSeries;
pub const crt = @import("crt.zig");
pub const GaussTable = @import("gaussTable.zig").GaussTable;

test "vector" {
    var a = vec3.Vec3_64.init(3.0, 4.0, 5.0);
    var b = vec3.Vec3_64.init(1.0, 1.0, 1.0);
    const slice = b.as_slice();
    try testing.expectEqualSlices(f64, &.{ 1.0, 1.0, 1.0 }, slice);
    try testing.expect(12.0 == vec3.Vec3_64.dot(a, b));
}

test LinearRegression {
    var x = [_]f64{ 1.0, 2.0, 3.0, 4.0, 5.0 };
    var y = [_]f64{ 2.0, 4.0, 6.0, 8.0, 10.0 };
    var LR = LinearRegression.init();
    LR.set(&x, &y);
    LR.calculate();
    // test the means
    try testing.expect(LR.x_mean == 3.0);
    try testing.expect(LR.y_mean == 6.0);
}

test Matrix {
    var matrix = Matrix(i32, 3, 3).init();
    matrix.add_elements(.{ 1, 2, 3, 4, 5, 6, 7, 8, 9 });

    const the_kolasa_min: [3][3]i32 = .{ .{ 1, 2, 3 }, .{ 4, 5, 6 }, .{ 7, 8, 9 } };
    for (matrix.inner, the_kolasa_min) |m_row, tk_row| {
        try testing.expectEqualSlices(i32, &tk_row, &m_row);
    }

    const other: [3][1]i32 = .{ .{5}, .{5}, .{5} };
    const result = try matrix.mult(3, 1, other);
    const expected: [3][1]i32 = .{ .{30}, .{75}, .{120} };
    for (result, expected) |r, e| {
        try testing.expectEqualSlices(i32, &e, &r);
    }

    const transposed: [3][3]i32 = .{ .{ 1, 4, 7 }, .{ 2, 5, 8 }, .{ 3, 6, 9 } };
    for (matrix.transpose(), transposed) |act, exp| {
        try testing.expectEqualSlices(i32, &exp, &act);
    }
    const det = try matrix.det3();
    try testing.expect(det == 0);
    //matrix.rref();
    //std.debug.print("{any}\n", .{matrix});
    matrix.rref();
    std.debug.print("RREF:\n{any}\n", .{matrix});
}

test Binomial {
    var binom = Binomial.init();
    std.debug.print("DBinom: {d}\n", .{binom.set(3, 10, 0.3, .Density)});
    std.debug.print("PBinom(L): {d}\n", .{binom.set(5, 10, 0.3, .Probability_L)});
}

test newtonInterpolation {
    var x_values = [_]f64{ 1.0, 2.0, 3.0, 4.0 };
    var y_values = [_]f64{ 0.0, 1.0, 8.0, 27.0 };
    const x_interp = 2.5;
    std.debug.print("Interp: {d}\n", .{newtonInterpolation(x_interp, &x_values, &y_values, 3)});
}
fn e_x(x: f64) f64 {
    return @exp(x);
}
fn sine(x: f64) f64 {
    return @sin(x);
}
test taylorSeries {
    const a: f64 = 2.0;
    const x: f64 = 3.0;
    const n: usize = 3;
    std.debug.print("Taylor series e^x: {d}\n", .{taylorSeries(e_x, a, x, n)});
    std.debug.print("Taylor series sin(x): {d}\n", .{taylorSeries(sine, a, x, n)});
}

test "Chinese Remainder Theorem" {
    const size: usize = 3;
    var remainders = [3]i32{ 2, 3, 2 };
    var moduli = [3]i32{ 3, 5, 7 };
    const result = crt.chineseRemainder(size, &remainders, &moduli);
    try testing.expect(result == 23);
}

test GaussTable {
    const one_point = GaussTable.one_point();
    try testing.expect(one_point.num_points == 1);
}
