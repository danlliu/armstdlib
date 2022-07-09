
ASM_FILE_EXT = s

LIB_DIR = lib
LIBRARIES = $(wildcard $(LIB_DIR)/*.$(ASM_FILE_EXT))

TST_DIR = tst
TEST_FILES = $(wildcard $(TST_DIR)/*.s)

.SUFFIXES:

%.o: %.$(ASM_FILE_EXT)
	as -arch arm64 -I ./ -I ./lib -o $@ $<

%: %.o $(LIBRARIES:%.s=%.o)
	ld -o $@ $^ -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64

.PHONY: lib
lib:	$(LIBRARIES:%.s=%.o)

.PHONY: newtest
newtest:
	./make_test.sh

.PHONY: tests
tests:	$(TEST_FILES:%.s=%)
	for file in $(TEST_FILES:tst/%.s=%); do ./run_test.sh $$file; done

.PHONY: clean
clean:
	rm -rf *.o
	find . -type f -perm +100 -delete
	find . -name *.o -delete

