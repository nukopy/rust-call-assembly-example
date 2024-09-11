CC = clang
AR = ar
RUSTC = rustc
ASM_DIR = ./asm
LIB_DIR = ./lib
SRC_DIR = ./src
ARCH = aarch64
TARGET = aarch64-apple-darwin

# ターゲット定義
.PHONY: all clean run

all: main

# アーキテクチャ固有のディレクトリを作成
$(LIB_DIR)/$(ARCH):
	mkdir -p $@

# build object files
$(LIB_DIR)/$(ARCH)/add.o: $(ASM_DIR)/$(ARCH)/add.s | $(LIB_DIR)/$(ARCH)
	$(CC) -c $< -o $@

$(LIB_DIR)/$(ARCH)/print.o: $(ASM_DIR)/$(ARCH)/print.s | $(LIB_DIR)/$(ARCH)
	$(CC) -c $< -o $@

# build static library
$(LIB_DIR)/$(ARCH)/libexample.a: $(LIB_DIR)/$(ARCH)/add.o $(LIB_DIR)/$(ARCH)/print.o
	$(AR) crus $@ $^

# build main
main: $(LIB_DIR)/$(ARCH)/libexample.a $(SRC_DIR)/main.rs
	$(RUSTC) $(SRC_DIR)/main.rs --target $(TARGET) -L $(LIB_DIR)/$(ARCH) -l static=example -o $@

# cleanup
clean:
	rm -rf $(LIB_DIR)/$(ARCH) main

run: main
	./main
