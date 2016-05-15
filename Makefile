TARGET=KyTeaPot
JAVAC=javac
JAVA=java
JAR=jar
CXX=c++
ifeq ($(OS),Windows_NT)
    #TBA
else
    OS:=$(shell uname -s)
    ifeq ($(OS),Linux)
        JAVAC_PATH=$(shell readlink -f /usr/bin/javac)
        JAVA_HOME=$(shell dirname -- $(shell dirname $(JAVAC_PATH)))
        JNI_MD_FOLDER=linux
        LIB_TYPE=-shared
        LIB_EXT=so
        LD_PATH_VAR=LD_LIBRARY_PATH
    endif
    ifeq ($(OS),Darwin)
        JAVA_HOME=$(shell /usr/libexec/java_home)
        JNI_MD_FOLDER=darwin
        LIB_TYPE=-dynamiclib
        LIB_EXT=dylib
        LD_PATH_VAR=DYLD_LIBRARY_PATH
    endif
    #TBA
endif
JAVA_INCLUDE=$(JAVA_HOME)/include

PACKAGE=com/phontron/kytea

LIBS=-lkytea
INC=-I/usr/local/include -I$(JAVA_INCLUDE) -I$(JAVA_INCLUDE)/$(JNI_MD_FOLDER)

ifeq ($(OS),Darwin)
    LIBS:=-arch x86_64 $(LIBS)
    INC:=-arch x86_64 $(INC)
endif

all:
	swig -java -package com.phontron.kytea -outdir com/phontron/kytea -c++ -I/usr/local/include $(TARGET).i
	$(CXX) -c -fPIC $(TARGET)_wrap.cxx $(TARGET).cpp $(INC)
	$(CXX) $(LIB_TYPE) $(TARGET)_wrap.o $(TARGET).o -o lib$(TARGET).$(LIB_EXT) $(LIBS)
	$(JAVAC) $(PACKAGE)/*.java
	$(JAVAC) DrinKyTea.java
	$(JAR) cfv $(TARGET).jar $(PACKAGE)/*.class

test:
	env $(LD_PATH_VAR)=. $(JAVA) DrinKyTea

clean:
	rm -fr *.jar *.o *.$(LIB_EXT) *.class $(PACKAGE)/*.class
	
cleanswig:
	rm -fr $(PACKAGE)/*.java *_wrap.cxx
