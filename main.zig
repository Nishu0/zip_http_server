const std = @import("std");

pub fn main() !void {
    std.debug.print("Hello, world!\n", .{});
    //Zig supports various forms of integers, floating point numbers, and pointers
    const x: i8 = -100; // Signed 8-bit integer
    const y: u8 = 120; // Unsigned 8-bit integer
    const z: f32 = 100.324; // 32-bit floating point

    std.debug.print("x={}\n", .{x}); // x=-100
    std.debug.print("y={}\n", .{y}); // y=120
    std.debug.print("z={d:3.2}\n", .{z}); // z=100.32

    //enum
    const Color = enum {
        red,
        green,
        blue,
    };
    const c: Color = Color.red;
    std.debug.print("c={}\n", .{c}); // c=red
    //Zig lets you override the ordinal values of enums as follows:
    const LogType = enum(u32) { info = 200, err = 500, warn = 600 };
    const log_type: LogType = LogType.info;
    std.debug.print("log_type={}\n", .{log_type});

    //Arrays
    const vowels = [5]u8{ 'a', 'e', 'i', 'o', 'u' };
    std.debug.print("{s}\n", .{vowels}); // aeiou
    std.debug.print("{d}\n", .{vowels.len}); // 5

    // Extended syntax for arrays
    // we can omit the size since it’s known at compile time and that's why we can use the _ symbol
    const numbers = [_]i32{ 1, 2, 3, 4, 5 };
    std.debug.print("{any}\n", .{numbers}); // [1, 2, 3, 4, 5]

    //Slices
    const testingNumber = [5]i32{ 1, 2, 3, 4, 5 };
    const slice = testingNumber[0..2];
    std.debug.print("{any}\n", .{slice}); // [1, 2]

    // strings
    const name = "Nisarg Thakkar!";
    std.debug.print("{s}\n", .{name}); // Nisarg Thakkar!
    std.debug.print("{}\n", .{@TypeOf(name)}); // *const [15:0]u8
    std.debug.print("{d}\n", .{name.len}); // 15

    // Zig strings are immutable, so you can’t change them after creation.
    // To modify a string, you need to convert it to a mutable array.
    const allocator = std.heap.page_allocator;
    //std.heap.page_allocator is a general-purpose allocator in Zig that manages memory using OS pages. It provides dynamic memory allocation, meaning memory is requested at runtime instead of being statically defined.
    var mutable_name = try allocator.dupe(u8, name);
    // allocator.dupe(u8, name) duplicates (copies) the string name into newly allocated memory. dupe takes a type and original slice, and returns a new slice with the same contents.
    // The result (mutable_name) is now a mutable array of u8 with the same contents as name.
    defer allocator.free(mutable_name);
    // defer is used to ensure that the memory allocated by allocator.dupe is freed when the mutable_name variable goes out of scope.
    mutable_name[0] = 'B';
    // mutable_name is now a mutable array of u8 with the same contents as name, but with the first character changed to 'B'.
    std.debug.print("{s}\n", .{mutable_name}); // Bisarg Thakkar!

    // structs and unions
    const person = struct {
        name: []const u8,
        age: u8,
    };
    const p: person = person{ .name = "Nisarg", .age = 20 };
    std.debug.print("{s}\n", .{p.name}); // Nisarg

    //Zig unions are like structs, but they can have only one active field at a time.
    const union_person = union(enum) {
        name: []const u8,
        age: u8,
    };
    const up: union_person = union_person{ .name = "Nisarg" };
    std.debug.print("{s}\n", .{up.name}); // Nisarg

    // Zig supports anonymous structs, which are structs without a name.
    const anonymous_person = struct {
        name: []const u8,
        age: u8,
    };
    const ap: anonymous_person = anonymous_person{ .name = "Nisarg", .age = 20 };
    std.debug.print("{s}\n", .{ap.name}); // Nisarg

    // control flow structures
    // Zig supports if, else if, else, and switch statements.
    const score: u8 = 100;

    if (score >= 90) {
        std.debug.print("Congrats!\n", .{});
        std.debug.print("{s}\n", .{"*" ** 10});
    } else if (score >= 50) {
        std.debug.print("Congrats!\n", .{});
    } else {
        std.debug.print("Try again...\n", .{});
    }

    // switch statements
    const marks: u8 = 88;

    switch (marks) {
        90...100 => {
            std.debug.print("Congrats!\n", .{});
            std.debug.print("{s}\n", .{"*" ** 10});
        },
        50...89 => {
            std.debug.print("Congrats!\n", .{});
        },
        else => {
            std.debug.print("Try again...\n", .{});
        },
    }

    //while statements
    var i: u8 = 0;
    while (i < 10) : (i += 1) {
        std.debug.print("{d}\n", .{i});
    }

    // for statements
    for (0..10) |_| {
        std.debug.print("{d}\n", .{i});
    }

    // for statements with break and continue
    for (0..10) |_| {
        if (i == 5) {
            break;
        }
        std.debug.print("{d}\n", .{i});
    }

    // for statements with continue
    for (0..10) |_| {
        if (i == 5) {
            continue;
        }
        std.debug.print("{d}\n", .{i});
    }

    // Zig supports the following compound assignment operators: +=, -=, *=, /=, %=, &=, |=, ^=, <<=, >>=
    var a: u8 = 10;
    a += 5;
    std.debug.print("{d}\n", .{a}); // 15

}
