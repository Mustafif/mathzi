const std = @import("std");
const pow = std.math.pow;
/// The Binomial Distribution
pub const Binomial = struct {
    pub const DistributionOption = enum {
        /// Density Distribution
        Density,
        /// Left Tail Probability Distribution
        Probability_L,
        /// Right Tail Probability Distribution
        Probability_R,
        /// Random Distribution,
        Random,
    };
    k: i64 = 0,
    n: i64 = 0,
    p: f64 = 0.0,
    coeff: u64 = 0,
    const Self = @This();

    pub fn init() Self {
        return .{};
    }

    pub fn set(self: *Self, k: i64, n: i64, p: f64, opt: DistributionOption) f64 {
        self.k = k;
        self.n = n;
        self.coeff = @intCast(coefficient(k, n));
        return self.prob(p, opt);
    }

    pub fn prob(self: Self, p: f64, option: DistributionOption) f64 {
        var cdf: f64 = 0.0;
        switch (option) {
            .Density => {
                return dbinom(self.k, self.n, p, self.coeff);
            },
            .Probability_L => {
                for (0..@intCast(self.k)) |i| {
                    cdf += dbinom(@intCast(i), self.n, p, self.coeff);
                }
                return cdf;
            },
            .Probability_R => {
                for (@intCast(self.k)..@intCast(self.n)) |i| {
                    cdf += dbinom(@intCast(i), self.n, p, self.coeff);
                }
                return cdf;
            },
            else => return 0.0,
        }
    }
};

fn dbinom(k: i64, n: i64, p: f64, c: u64) f64 {
    const coeff: f64 = @floatFromInt(c);
    const k_f: f64 = @floatFromInt(k);
    const nk_f: f64 = @floatFromInt(n - k);
    return coeff * pow(f64, p, k_f) * pow(f64, 1.0 - p, nk_f);
}

fn coefficient(k: i64, n: i64) i64 {
    return @divTrunc(factorial(n), factorial(k) * factorial(n - k));
}

pub fn factorial(n: i64) i64 {
    if (n == 0) {
        return 1;
    } else {
        return (n * factorial(n - 1));
    }
}
