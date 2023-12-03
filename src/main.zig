const std = @import("std");
const testing = std.testing;

pub const Vec3 = @import("vec3.zig").Vec3;
pub const LinearRegression = @import("lin_reg.zig").LinearRegression;

test Vec3 {
    var a = Vec3(f64).init(3.0, 4.0, 5.0);
    var b = Vec3(f64).init(1.0, 1.0, 1.0);
    const slice = b.as_slice();
    try testing.expectEqualSlices(f64, &.{ 1.0, 1.0, 1.0 }, slice);
    try testing.expect(12.0 == Vec3(f64).dot(a, b));
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
