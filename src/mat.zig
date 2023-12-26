pub fn Matrix(comptime T: type, comptime row_size: usize, comptime col_size: usize) type {
    return struct {
        inner: [row_size][col_size]T,
        len: usize = LEN,
        const Self = @This();
        const LEN: usize = row_size * col_size;

        const MatrixError = error{IncompatibleDimensions};

        /// Initializes a zero Matrix
        pub fn init() Self {
            var inner: [row_size][col_size]T = undefined;
            for (&inner) |*row| {
                for (row) |*element| {
                    element.* = @as(T, 0);
                }
            }
            return .{ .inner = inner };
        }

        pub fn add_elements(self: *Self, elements: [LEN]T) void {
            var i: usize = 0;
            for (&self.inner) |*row| {
                for (row) |*element| {
                    element.* = elements[i];
                    i += 1;
                }
            }
        }
        pub fn add_row(self: *Self, row: [col_size]T, row_idx: usize) void {
            if (row_idx >= col_size) return;
            self.inner[row_idx] = row;
        }
        pub fn add_col(self: *Self, col: [row_size]T, col_idx: usize) void {
            if (col_idx >= row_size) return;
            for (&self.inner, col) |*row, c| {
                row[col_idx] = c;
            }
        }

        pub fn mult_scalar(self: *Self, scalar: T) void {
            for (&self.inner) |*row| {
                for (row) |*element| {
                    element.* *= scalar;
                }
            }
        }
        pub fn mult(self: Self, comptime r: usize, comptime c: usize, other: [r][c]T) ![row_size][c]T {
            if (col_size != r) return .IncompatibleDimensions;
            var result: [row_size][c]T = undefined;

            for (0..row_size) |i| {
                for (0..c) |j| {
                    result[i][j] = @as(T, 0);
                    for (0..col_size) |k| {
                        result[i][j] += self.inner[i][k] * other[k][j];
                    }
                }
            }

            return result;
        }
        pub fn add(self: *Self, b: [row_size][col_size]T) void {
            for (&self.inner, b) |*row, b_row| {
                for (row, b_row) |*element, val| {
                    element.* += val;
                }
            }
        }
        pub fn sub(self: *Self, b: [row_size][col_size]T) void {
            for (&self.inner, b) |*row, b_row| {
                for (row, b_row) |*element, val| {
                    element.* -= val;
                }
            }
        }
        pub fn transpose(self: Self) [col_size][row_size]T {
            var t: [col_size][row_size]T = undefined;

            for (0..row_size) |i| {
                for (0..col_size) |j| {
                    t[i][j] = self.inner[j][i];
                }
            }

            return t;
        }
        pub fn det2(self: Self) !T {
            if (row_size != 2 and col_size != 2) return .IncompatibleDimensions;
            return self.inner[0][0] * self.inner[1][1] - self.inner[0][1] * self.inner[1][0];
        }
        pub fn det3(self: Self) !T {
            if (row_size != 3 and col_size != 3) return .IncompatibleDimensions;
            const inner = self.inner;
            const first = inner[0][0] * (inner[1][1] * inner[2][2] - inner[1][2] * inner[2][1]);
            const second = inner[0][1] * (inner[1][0] * inner[2][2] - inner[1][2] * inner[2][0]);
            const third = inner[0][2] * (inner[1][0] * inner[2][1] - inner[1][1] * inner[2][0]);
            return first - second + third;
        }

        pub fn rref(self: *Self) void {
            var lead: usize = 0;
            for (0..row_size) |r| {
                if (col_size <= lead) break;

                var i = r;
                while (self.inner[i][lead] == @as(T, 0)) {
                    i += 1;
                    if (row_size == i) {
                        i = r;
                        lead += 1;
                        if (col_size == lead) break;
                    }
                }
                if (col_size > lead) {
                    for (0..col_size) |j| {
                        const temp = self.inner[r][j];
                        self.inner[r][j] = self.inner[i][j];
                        self.inner[i][j] = temp;
                    }
                    const div = self.inner[r][lead];
                    for (0..col_size) |j| {
                        self.inner[r][j] = @divTrunc(self.inner[r][j], div);
                    }
                    for (0..row_size) |k| {
                        if (k != r) {
                            const s = self.inner[k][lead];
                            for (0..col_size) |j| {
                                self.inner[k][j] -= s * self.inner[r][j];
                            }
                        }
                    }
                }
                lead += 1;
            }
        }
        pub fn back_subsitution(augmented: [row_size][col_size + 1]T) [row_size]T {
            var i: usize = row_size - 1;
            var solution: [row_size]T = undefined;
            while (i >= 0) {
                var sum = augmented[i][col_size];
                for (i + 1..col_size) |j| {
                    sum -= augmented[i][j] * augmented[j][col_size];
                }
                solution[i] = sum / augmented[i][i];
                i -= 1;
            }
            return solution;
        }
        pub fn solve(self: *Self, b: [row_size]T) [row_size]T {
            _ = b;
            _ = self;
            // TODO
        }
    };
}
