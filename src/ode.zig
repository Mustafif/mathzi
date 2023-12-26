const std = @import("std");

// A function pointer type alias
const Function = *const fn (f64, f64) f64;

pub const Euler = struct {
    t_i: f64,
    y_i: f64,
    h: f64,
    t: f64,
    f: Function,

    pub fn init(comptime f: Function, t_i: f64, y_i: f64, h: f64, t: f64) f64 {
        while (t_i <= t) {
            y_i += h * f(t_i, y_i);
            t_i += h;
        }
        return y_i;
    }
};

pub const RK4 = struct {};
