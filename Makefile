COMPILE_FLAGS = -Wall \
		--target=wasm32 -I /usr/include/wasm32-wasi \
		-Os
OBJ = strlen.o

CLANG = clang
LD = wasm-ld

%.o: %.c  Makefile
	$(CLANG) \
		-c \
		$(COMPILE_FLAGS) \
		-o $@ \
		$<

strlen.wasm: $(OBJ)
	$(LD) -o strlen.wasm --no-entry --export=string_length \
		--strip-all \
		--export-dynamic \
		--allow-undefined \
		--initial-memory=131072 \
		-error-limit=0 \
		--lto-O3 \
		-O3 \
		--gc-sections \
		-L /usr/lib/wasm32-wasi -lc \
		$(OBJ)

test: strlen.wasm Makefile
	npm test

clean:
	rm -f strlen.wasm strlen.o
