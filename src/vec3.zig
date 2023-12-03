const std = @import("std");
const testing = std.testing;

pub fn Vec3(comptime T: type) type {
    return struct {
        x: T,
        y: T,
        z: T,

        const Self = @This();

        /// Creates a new Vector with given x, y, z values
        pub fn init(x: T, y: T, z: T) Self {
            return .{ .x = x, .y = y, .z = z };
        }
        /// Adds your vec with another vec
        pub fn add(self: *Self, other: Self) void {
            self.x += other.x;
            self.y += other.y;
            self.z += other.z;
        }
        /// Subtracts your vec with another vec
        pub fn sub(self: *Self, other: Self) void {
            self.x -= other.x;
            self.y -= other.y;
            self.z -= other.z;
        }
        /// Multiplies your Vec with a scalar number
        pub fn scalar_mul(self: *Self, scalar: T) void {
            self.x *= scalar;
            self.y *= scalar;
            self.z *= scalar;
        }
        /// The dot product between two Vecs
        pub fn dot(a: Self, b: Self) T {
            return a.x * b.x + a.y * b.y + a.z * b.z;
        }
        /// The cross product between two Vecs
        pub fn cross(a: Self, b: Self) Self {
            const x = a.y * b.z - a.z * b.y;
            const y = a.z * b.x - a.x * b.z;
            const z = a.x * b.y - a.y * b.x;
            return Self.init(x, y, z);
        }
        /// Divides your Vec with a scalar number
        pub fn scalar_div(self: *Self, scalar: T) void {
            self.x /= scalar;
            self.y /= scalar;
            self.z /= scalar;
        }
        /// Normalizes your Vec
        pub fn normalize(self: *Self) void {
            const length = @sqrt(@exp2(self.x) + @exp2(self.y) + @exp2(self.z));
            self.scalar_div(length);
        }
        /// Component-wise Multiplication between two Vecs
        pub fn component_mul(a: Self, b: Self) Self {
            return Self.init(a.x * b.x, a.y * b.y, a.z * b.z);
        }
        /// Component-wise Division between two Vecs
        pub fn component_div(a: Self, b: Self) Self {
            return Self.init(a.x / b.x, a.y / b.y, a.z / b.z);
        }
        pub fn clone(self: Self) Self {
            return Self.init(self.x, self.y, self.z);
        }
        pub fn as_slice(self: Self) []const T {
            return &[_]T{ self.x, self.y, self.z };
        }
    };
}
