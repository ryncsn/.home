fish_add_path $HOME/.cargo/bin

if command -v rustc > /dev/null
    set -gx RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src
end
