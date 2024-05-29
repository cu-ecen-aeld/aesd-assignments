CC=gcc
CFLAGS=-g -Wall
all: writer writer.o writer.c
writer: writer.o
	$(CROSS_COMPILE)$(CC) $< -o $@
writer.o: writer.c
	$(CROSS_COMPILE)$(CC) $(CFLAGS) -c $< -o $@ 
clean:
	rm -f writer.o writer
