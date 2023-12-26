pub export fn chineseRemainder(arg_numEquations: c_int, arg_remainders: [*c]c_int, arg_moduli: [*c]c_int) c_int {
    var numEquations = arg_numEquations;
    var remainders = arg_remainders;
    var moduli = arg_moduli;
    var product: c_int = 1;
    {
        var i: c_int = 0;
        while (i < numEquations) : (i += 1) {
            product *= (blk: {
                const tmp = i;
                if (tmp >= 0) break :blk moduli + @as(usize, @intCast(tmp)) else break :blk moduli - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
            }).*;
        }
    }
    var result: c_int = 0;
    {
        var i: c_int = 0;
        while (i < numEquations) : (i += 1) {
            var Mi: c_int = @divTrunc(product, (blk: {
                const tmp = i;
                if (tmp >= 0) break :blk moduli + @as(usize, @intCast(tmp)) else break :blk moduli - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
            }).*);
            var Mi_inverse: c_int = modInverse(Mi, (blk: {
                const tmp = i;
                if (tmp >= 0) break :blk moduli + @as(usize, @intCast(tmp)) else break :blk moduli - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
            }).*);
            result += @import("std").zig.c_translation.signedRemainder(((blk: {
                const tmp = i;
                if (tmp >= 0) break :blk remainders + @as(usize, @intCast(tmp)) else break :blk remainders - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
            }).* * Mi) * Mi_inverse, product);
            result = @import("std").zig.c_translation.signedRemainder(result, product);
        }
    }
    return result;
}

pub export fn modInverse(arg_a: c_int, arg_m: c_int) c_int {
    var a = arg_a;
    var m = arg_m;
    var m0: c_int = m;
    var t: c_int = undefined;
    var q: c_int = undefined;
    var x0: c_int = 0;
    var x1: c_int = 1;
    if (m == @as(c_int, 1)) return 0;
    while (a > @as(c_int, 1)) {
        q = @divTrunc(a, m);
        t = m;
        _ = blk: {
            m = @import("std").zig.c_translation.signedRemainder(a, m);
            break :blk blk_1: {
                const tmp = t;
                a = tmp;
                break :blk_1 tmp;
            };
        };
        t = x0;
        x0 = x1 - (q * x0);
        x1 = t;
    }
    if (x1 < @as(c_int, 0)) {
        x1 += m0;
    }
    return x1;
}
