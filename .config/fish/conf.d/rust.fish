set -x -g PATH $HOME/.cargo/bin $PATH

set -x -g RUSTUP_DIST_SERVER https://mirrors.ustc.edu.cn/rust-static
set -x -g RUSTUP_UPDATE_ROOT https://mirrors.ustc.edu.cn/rust-static/rustup

set -x -g RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src
