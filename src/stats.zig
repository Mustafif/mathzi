const std = @import("std");

pub const Stats = struct {
    count: f64 = 0.0,
    mean: f64 = 0.0,
    variance: f64 = 0.0,
    skewness: f64 = 0.0,
    kurtosis: f64 = 0.0,
    min: f64 = std.math.inf(f64),
    q1: f64 = 0.0,
    median: f64 = 0.0,
    q3: f64 = 0.0,
    max: f64 = -std.math.inf(f64),
    data: std.ArrayList(f64),
    const Self = @This();

    pub fn init(allocator: std.mem.Allocator) Self {
        return .{ .data = std.ArrayList(f64).init(allocator) };
    }
    pub fn deinit(self: *Self) void {
        self.data.deinit();
    }
    fn countf(self: Self) f64 {
        return @floatFromInt(self.count);
    }
    fn countf_p1(self: Self) f64 {
        return @floatFromInt(self.count + 1);
    }
    fn update_mean(self: *Self, x: f64) void {
        self.mean = (self.mean * self.countf() + x) / self.countf_p1();
    }
    fn update_min_max(self: *Self, x: f64) void {
        self.min = @min(self.min, x);
        self.max = @max(self.max, x);
    }
    fn calculate_quantile(self: *Self, quantile: f64) f64{
        const index: usize = @intFromFloat(quantile * self.countf());
        _ = index;
        
    }
};

fn cmpByValue(context: void, a: f64, b: f64) bool {
    _ = context;
    return (a > b);
}
