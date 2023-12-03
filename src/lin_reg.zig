const std = @import("std");

pub const LinearRegression = struct {
    x: []f64 = &.{},
    y: []f64 = &.{},
    x_mean: f64 = 0.0,
    y_mean: f64 = 0.0,
    sum_xy: f64 = 0.0,
    sum_x_squared: f64 = 0.0,
    slope: f64 = 0.0,
    intercept: f64 = 0.0,
    len: f64 = 0.0, // we expect x.len == y.len

    const Self = @This();
    /// Initialize with default values
    pub fn init() Self {
        return .{};
    }
    /// Resets the values
    pub fn reset(self: *Self) void {
        self = Self.init();
    }
    /// Set the x and y values
    pub fn set(self: *Self, x: []f64, y: []f64) void {
        self.x = x;
        self.y = y;
        self.len = @floatFromInt(self.x.len);
    }
    /// Calculates the means of x and y
    fn calc_means(self: *Self) void {
        var sum_y: f64 = 0.0;
        var sum_x: f64 = 0.0;
        for (self.x, self.y) |x, y| {
            sum_x += x;
            sum_y += y;
        }
        self.x_mean = sum_x / self.len;
        self.y_mean = sum_y / self.len;
    }
    /// Calculates sum_xy and sum_x_squared
    fn calc_sums(self: *Self) void {
        for (self.x, self.y) |x, y| {
            self.sum_xy += (x - self.x_mean) * (y - self.y_mean);
            self.sum_x_squared += @exp2(x - self.x_mean);
        }
    }

    fn calc_slope(self: *Self) void {
        self.slope = self.sum_xy / self.sum_x_squared;
    }
    fn calc_intercepts(self: *Self) void {
        self.intercept = self.y_mean - self.slope * self.x_mean;
    }

    pub fn calculate(self: *Self) void {
        self.calc_means();
        self.calc_sums();
        self.calc_slope();
        self.calc_intercepts();
    }

    pub fn summary(self: Self) void {
        std.debug.print(" SUMMARY  \n", .{});
        std.debug.print("Means:\n\tx = {d}\n\ty = {d:2}\n", .{ self.x_mean, self.y_mean });
        std.debug.print("∑​(x-x_mean)(y-y_mean) = {d:2}\n", .{self.sum_xy});
        std.debug.print("∑(x-x_mean)^2 = {d}\n", .{self.sum_x_squared});
        std.debug.print("Regression Line: Y = {d:2}x + {d:2}\n", .{ self.slope, self.intercept });
    }
};
