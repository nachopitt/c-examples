SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := bin

ifeq '$(findstring ;,$(PATH))' ';'
UNAME := Windows
else
UNAME := $(shell uname 2>/dev/null || echo Unknown)
UNAME := $(patsubst CYGWIN%,Cygwin,$(UNAME))
UNAME := $(patsubst MSYS%,MSYS,$(UNAME))
UNAME := $(patsubst MINGW%,MSYS,$(UNAME))
endif

ifeq ($(UNAME),Windows)
RM := DEL /Q /F
RMDIR := RMDIR /Q /S
MKDIR := MKDIR
else
RM := rm -rfv
RMDIR := $(RM)
MKDIR := mkdir -p
endif

TARGETS := static

BINS := $(TARGETS:%=$(BIN_DIR)/%)
SRC := $(SRC_DIR)/flash_interface.c

OBJ := $(SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

CC := $(CROSS_COMPILE)gcc

CPPFLAGS := -MMD -MP
CFLAGS := -Wall -g -O0 -I$(SRC_DIR)

CFLAGS +=
LDFLAGS +=

.PHONY: all clean $(TARGETS)

all: $(TARGETS)

$(TARGETS): %: $(BIN_DIR)/%

$(BINS): $(BIN_DIR)/%: $(OBJ_DIR)/%.o $(OBJ) | $(BIN_DIR)
	$(CC) $^ -o $@ $(CFLAGS) $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BIN_DIR) $(OBJ_DIR):
	$(MKDIR) $@

clean:
ifeq ($(UNAME),Windows)
	if exist $(BIN_DIR) $(RMDIR) $(BIN_DIR)
	if exist $(OBJ_DIR) $(RMDIR) $(OBJ_DIR)
else
	$(RMDIR) $(BIN_DIR)
	$(RMDIR) $(OBJ_DIR)
endif

-include $(OBJ:.o=.d)
