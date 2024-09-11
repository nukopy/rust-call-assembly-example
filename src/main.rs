use std::ffi::c_void;

extern "C" {
    fn add(a: i64, b: i64) -> i64;
    fn print(msg: *const c_void, len: usize) -> isize;
}

pub fn run_add() {
    // call add
    let a: i64 = 5;
    let b: i64 = 7;
    unsafe {
        let result = add(a, b);

        println!("{} + {} = {}", a, b, result);
    }
}

pub fn run_print() {
    // call print
    let message = "Hello, World!\n";
    unsafe {
        let result = print(message.as_ptr() as *const c_void, message.len());
        println!("Bytes written: {}", result);
    }
}

fn main() {
    run_add();
    run_print();
}
