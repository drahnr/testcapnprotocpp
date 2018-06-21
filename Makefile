OS = Linux

VERSION = 0.0.1
CXX      = /usr/bin/g++
CXXFLAGS  = -Wall -std=c++11 $(pkg-config --cflags capnp) -I/usr/include/
LDFLAGS = -lm $(pkg-config --libs capnp)

BUILDDIR = build
SOURCEDIR = src
HEADERDIR = src

SOURCES = $(shell find $(SOURCEDIR) -name '*.cpp')
OBJECTS = $(addprefix $(BUILDDIR)/,$(SOURCES:%.cpp=%.o))

NAME = fyub
BINARY = fyub.bin

RM = rm -rf
MKDIR = mkdir
INSTALL = install

.PHONY: all clean setup

all: $(BINARY)

$(BINARY): $(OBJECTS)
	$(CXX) $(CXXFLAGS) -I$(HEADERDIR) -I$(SOURCEDIR) $(OBJECTS) -o $(BINARY)

$(BUILDDIR)/%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -I$(HEADERDIR) -I$(SOURCEDIR) -c $< -o $@

setup:
	$(MKDIR) -p $(BUILDDIR)/src

clean:
	$(RM) $(BINARY) $(OBJECTS)

distclean: clean