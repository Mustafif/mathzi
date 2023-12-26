const std = @import("std");

pub const GaussTable = struct {
    num_points: usize = 0,
    weights: []f64 = &.{},
    abscissas: []f64 = &.{},

    const Self = @This();

    pub fn one_point() Self {
        const num_points = 1;
        var weights = [_]f64{2.0};
        var abscissas = [_]f64{0.0};

        return .{ .num_points = num_points, .weights = &weights, .abscissas = &abscissas };
    }
    pub fn two_point() Self {
        const num_points = 2;
        var weights = [_]f64{ 1.0, 1.0 };
        var abscissas = [_]f64{ -1.0 * 1 / @sqrt(3.0), 1.0 * 1 / @sqrt(3.0) };

        return .{ .num_points = num_points, .weights = &weights, .abscissas = &abscissas };
    }
    pub fn three_points() Self {
        // TODO
    }
    pub fn four_points() Self {
        // TODO
    }
    pub fn five_points() Self {
        // TODO
    }
    pub fn seven_points() Self {
        // TODO
    }
    pub fn nine_points() Self {
        // TODO
    }
};
