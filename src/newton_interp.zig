pub export fn dividedDifference(arg_x: f64, arg_x_values: [*c]f64, arg_y_values: [*c]f64, arg_start: c_int, arg_end: c_int) f64 {
    var x = arg_x;
    var x_values = arg_x_values;
    var y_values = arg_y_values;
    var start = arg_start;
    var end = arg_end;
    if (start == end) {
        return (blk: {
            const tmp = start;
            if (tmp >= 0) break :blk y_values + @as(usize, @intCast(tmp)) else break :blk y_values - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
        }).*;
    } else {
        return (dividedDifference(x, x_values, y_values, start + @as(c_int, 1), end) - dividedDifference(x, x_values, y_values, start, end - @as(c_int, 1))) / ((blk: {
            const tmp = end;
            if (tmp >= 0) break :blk x_values + @as(usize, @intCast(tmp)) else break :blk x_values - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
        }).* - (blk: {
            const tmp = start;
            if (tmp >= 0) break :blk x_values + @as(usize, @intCast(tmp)) else break :blk x_values - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
        }).*);
    }
    return 0;
}
pub export fn newtonInterpolation(arg_x: f64, arg_x_values: [*c]f64, arg_y_values: [*c]f64, arg_n: c_int) f64 {
    var x = arg_x;
    var x_values = arg_x_values;
    var y_values = arg_y_values;
    var n = arg_n;
    var result: f64 = 0.0;
    var term: f64 = 1.0;
    {
        var i: c_int = 0;
        while (i <= n) : (i += 1) {
            result += term * dividedDifference(x, x_values, y_values, @as(c_int, 0), i);
            term *= x - (blk: {
                const tmp = i;
                if (tmp >= 0) break :blk x_values + @as(usize, @intCast(tmp)) else break :blk x_values - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
            }).*;
        }
    }
    return result;
}