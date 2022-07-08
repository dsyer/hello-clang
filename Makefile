OBJ = strlen.o

WASI_VERSION = 16
WASI_VERSION_FULL := $(WASI_VERSION).0

WASI_SDK_PATH := tmp/wasi-sdk-$(WASI_VERSION_FULL)
CLANG := $(WASI_SDK_PATH)/bin/clang
LD := $(WASI_SDK_PATH)/bin/wasm-ld

COMPILE_FLAGS := -Os

%.o: %.c  Makefile $(WASI_SDK_PATH)
	$(CLANG) --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot \
		-v -c \
		$(COMPILE_FLAGS) \
		-o $@ \
		$<

strlen.wasm: $(OBJ)
	$(LD) -L ${WASI_SDK_PATH}/share/wasi-sysroot/lib/wasm32-wasi \
		-o strlen.wasm --no-entry --export=string_length \
		--strip-all \
		--export-dynamic \
		--allow-undefined \
		--initial-memory=131072 \
		-error-limit=0 \
		--lto-O3 \
		-O3 \
		--gc-sections \
		-lc \
		$(OBJ)

test: strlen.wasm Makefile
	npm test

$(WASI_SDK_PATH): 
	mkdir -p tmp
	cd tmp && curl -L https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_VERSION}/wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz | tar -xzf -

clean:
	rm -f strlen.wasm strlen.o
