/// The Secant Iterative Method
pub const Secant = struct {
    x_i: f64,
    x_prev: f64,
    fxi: f64,
    fx_prev: f64,
    f: *const fn (f64) f64,
    tol: f64,
    i: usize = 1,
    ea: f64 = 1.0,

    const Self = @This();

    pub fn init(x_i: f64, x_prev: f64, tol: f64, comptime f: *const fn (f64) f64) Self {
        const fxi = f(x_i);
        const fx_prev = f(x_prev);
        return .{ .x_i = x_i, .x_prev = x_prev, .fxi = fxi, .fx_prev = fx_prev, .tol = tol, .f = f };
    }

    fn rel_perc_err(self: *Self) void {
        self.ea = @fabs((self.x_i - self.x_prev) / self.x_i) * 100.0;
    }
    fn next(self: *Self) void {
        const xi = self.x_i;
        self.x_i = xi - ((xi - self.x_prev) / (1.0 - (self.fx_prev / self.fxi)));
        self.x_prev = xi;
        self.i += 1;
    }
    pub fn iter(self: *Self) f64 {
        // iterate until ea < tol
        while (self.ea > self.tol) {
            // calculates the next x
            self.next();
            // calculate the rel percent error
            self.rel_perc_err();
        }
        return self.x_i;
    }
};
