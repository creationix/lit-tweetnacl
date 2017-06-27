LUAJIT_OS=$(shell luajit -e "print(require('ffi').os)")
LUAJIT_ARCH=$(shell luajit -e "print(require('ffi').arch)")
TARGET_DIR=$(LUAJIT_OS)-$(LUAJIT_ARCH)/

TWEETNACL_LIB=luatweetnacl.so

libs: build
	cmake --build build --config Release
	mkdir -p $(TARGET_DIR)
	cp build/$(TWEETNACL_LIB) $(TARGET_DIR)

luatweetnacl:
	git submodule update --init luatweetnacl

build: luatweetnacl
	cmake -Bbuild -H. -GNinja

test-app/main.lua:
	git submodule update --init test-app

test-app/deps: test-app/main.lua
	cd test-app && lit install
	rm -rf test-app/deps/tweetnacl
	ln -s ../.. test-app/deps/tweetnacl

test: test-app/deps
	luvi test-app

test-build: test-app/deps
	cd test-app && lit make
	./test-app/tweetnacl-sample


clean:
	rm -rf build test-app/deps
