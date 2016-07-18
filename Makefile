CXX=g++-5
LD=g++-5

FLAGS=-O3 -Wall

MAINS=build/GenNon-h.o

TARGETS=$(patsubst build/%.o, %, $(MAINS))
OBJ=$(patsubst src/%.cpp, build/%.o,$(wildcard src/*.cpp)) #

DEPS=$(wildcard *.h)
SRC=$(wildcard *.cpp)

INC=include
DATA=$(wildcard *.fa) $(wildcard *.tree)
OTHER=Makefile README

FILES=$(SRC) $(DEPS) $(INC) $(DATA) $(OTHER)

CFLAGS=-I $(INC) $(FLAGS) --std=c++11

.PHONY: clean src-pkg

all: $(TARGETS)

# Rule for object files
build/%.o: src/%.cpp $(DEPS)
	$(CXX) -c -o $@ $< $(CFLAGS)

# Rule for targets
$(TARGETS): $(OBJ)
	$(LD) -o $@ $^ $(LDFLAGS)


clean:
	rm -f src/*.o *~ $(TARGETS)

src-pkg: $(TARGETS) $(DEPS)
	tar czf GenNon-h.tar.gz $(FILES)
