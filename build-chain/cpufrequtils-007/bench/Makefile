LIBS = -L../.libs/ -lm -lcpufreq

OBJS = main.o parse.o system.o benchmark.o
CFLAGS += -D_GNU_SOURCE -I../lib -DDEFAULT_CONFIG_FILE=\"$(confdir)/cpufreq-bench.conf\"

ifeq ($(strip $(V)),false)
	CC=@../build/ccdv gcc
else
	CC=gcc
endif

cpufreq-bench: $(OBJS)
	$(CC) -o $@ $(CFLAGS) $(OBJS) $(LIBS)

all: cpufreq-bench

install:
	mkdir -p $(DESTDIR)/$(sbindir)
	mkdir -p $(DESTDIR)/$(bindir)
	mkdir -p $(DESTDIR)/$(docdir)
	mkdir -p $(DESTDIR)/$(confdir)
	install -m 755 cpufreq-bench $(DESTDIR)/$(sbindir)/cpufreq-bench
	install -m 755 cpufreq-bench_plot.sh $(DESTDIR)/$(bindir)/cpufreq-bench_plot.sh
	install -m 644 README-BENCH $(DESTDIR)/$(docdir)/README-BENCH
	install -m 755 cpufreq-bench_script.sh $(DESTDIR)/$(docdir)/cpufreq-bench_script.sh
	install -m 644 example.cfg $(DESTDIR)/$(confdir)/cpufreq-bench.conf

clean:
	rm -f *.o
	rm -f cpufreq-bench
