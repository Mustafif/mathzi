const pow = @import("std").math.pow;
pub const FunctionPointer = *const fn (f64) f64;
pub export fn factorial(arg_n: c_int) f64 {
    var n = arg_n;
    if ((n == @as(c_int, 0)) or (n == @as(c_int, 1))) {
        return 1.0;
    } else {
        return @as(f64, @floatFromInt(n)) * factorial(n - @as(c_int, 1));
    }
    return 0;
}
pub export fn derivative(arg_f: FunctionPointer, arg_x: f64, arg_order: c_int, arg_h: f64) f64 {
    var f = arg_f;
    var x = arg_x;
    var order = arg_order;
    var h = arg_h;
    if (order == @as(c_int, 0)) {
        return f(x);
    }
    var numerator: f64 = derivative(f, x + h, order - @as(c_int, 1), h) - derivative(f, x, order - @as(c_int, 1), h);
    return numerator / h;
}
pub export fn taylorSeries(arg_f: FunctionPointer, arg_a: f64, arg_x: f64, arg_n: c_int) f64 {
    var f = arg_f;
    var a = arg_a;
    var x = arg_x;
    var n = arg_n;
    var result: f64 = 0.0;
    {
        var i: c_int = 0;
        while (i <= n) : (i += 1) {
            result += (derivative(f, a, i, 0.0001) / factorial(i)) * pow(f64, x - a, @as(f64, @floatFromInt(i)));
        }
    }
    return result;
}