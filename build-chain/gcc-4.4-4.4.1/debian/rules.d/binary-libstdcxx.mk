
ifeq ($(with_libcxx),yes)
  arch_binaries  := $(arch_binaries) libstdcxx
endif
ifeq ($(with_lib64cxx),yes)
  arch_binaries  := $(arch_binaries) lib64stdcxx
endif
ifeq ($(with_lib64cxxdbg),yes)
  arch_binaries	:= $(arch_binaries) lib64stdcxxdbg
endif
ifeq ($(with_lib32cxx),yes)
  arch_binaries	:= $(arch_binaries) lib32stdcxx
endif
ifeq ($(with_lib32cxxdbg),yes)
  arch_binaries	:= $(arch_binaries) lib32stdcxxdbg
endif
ifeq ($(with_libn32cxx),yes)
  arch_binaries	:= $(arch_binaries) libn32stdcxx
endif
ifeq ($(with_libn32cxxdbg),yes)
  arch_binaries	:= $(arch_binaries) libn32stdcxxdbg
endif

ifeq ($(with_cxxdev),yes)
  arch_binaries  := $(arch_binaries) libstdcxx-dev
  indep_binaries := $(indep_binaries) libstdcxx-doc
endif

libstdc_ext = -$(BASE_VERSION)

p_lib	= libstdc++$(CXX_SONAME)
p_lib64	= lib64stdc++$(CXX_SONAME)
p_lib32	= lib32stdc++$(CXX_SONAME)
p_libn32= libn32stdc++$(CXX_SONAME)
p_dev	= libstdc++$(CXX_SONAME)$(libstdc_ext)-dev
p_pic	= libstdc++$(CXX_SONAME)$(libstdc_ext)-pic
p_dbg	= libstdc++$(CXX_SONAME)$(libstdc_ext)-dbg
p_dbg64	= $(p_lib64)$(libstdc_ext)-dbg
p_dbg32	= $(p_lib32)$(libstdc_ext)-dbg
p_dbgn32= $(p_libn32)$(libstdc_ext)-dbg
p_libd	= libstdc++$(CXX_SONAME)$(libstdc_ext)-doc

d_lib	= debian/$(p_lib)
d_lib64	= debian/$(p_lib64)
d_lib32	= debian/$(p_lib32)
d_libn32= debian/$(p_libn32)
d_dev	= debian/$(p_dev)
d_pic	= debian/$(p_pic)
d_dbg	= debian/$(p_dbg)
d_dbg64	= debian/$(p_dbg64)
d_dbg32	= debian/$(p_dbg32)
d_dbgn32= debian/$(p_dbgn32)
d_libd	= debian/$(p_libd)

dirs_dev = \
	$(docdir)/$(p_base)/C++ \
	$(PF)/$(libdir) \
	$(gcc_lib_dir)/include \
	$(cxx_inc_dir)

files_dev = \
	$(cxx_inc_dir)/ \
	$(gcc_lib_dir)/libstdc++.{a,so} \
	$(gcc_lib_dir)/libsupc++.a
# Not yet...
#	$(PF)/$(libdir)/lib{supc,stdc}++.la

dirs_dbg = \
	$(docdir) \
	$(PF)/$(libdir)/debug \
	$(gcc_lib_dir)
files_dbg = \
	$(PF)/$(libdir)/debug/libstdc++.{a,so*}

dirs_pic = \
	$(docdir) \
	$(gcc_lib_dir)
files_pic = \
	$(gcc_lib_dir)/libstdc++_pic.a

# ----------------------------------------------------------------------

gxx_baseline_dir = $(shell \
			sed -n '/^baseline_dir *=/s,.*= *\(.*\)$$,\1,p' \
			    $(buildlibdir)/libstdc++-v3/testsuite/Makefile)
gxx_baseline_file = $(gxx_baseline_dir)/baseline_symbols.txt

debian/README.libstdc++-baseline:
	cat debian/README.libstdc++-baseline.in \
		> debian/README.libstdc++-baseline

	baseline_name=`basename $(gxx_baseline_dir)`; \
	baseline_parentdir=`dirname $(gxx_baseline_dir)`; \
	compat_baseline_name=""; \
	if [ -f "$(gxx_baseline_file)" ]; then \
	  ( \
	    echo "A baseline file for $$baseline_name was found."; \
	    echo "Running the check-abi script ..."; \
	    echo ""; \
	    $(MAKE) -C $(buildlibdir)/libstdc++-v3/testsuite \
		check-abi; \
	  ) >> debian/README.libstdc++-baseline; \
	else \
	  ( \
	    echo "No baseline file found for $$baseline_name."; \
	    echo "Generating a new baseline file ..."; \
	    echo ""; \
	  ) >> debian/README.libstdc++-baseline; \
	  mkdir -p $(gxx_baseline_dir); \
	  $(MAKE) -C $(buildlibdir)/libstdc++-v3/testsuite new-abi-baseline; \
	  if [ -f $(gxx_baseline_file) ]; then \
	    cat $(gxx_baseline_file); \
	  else \
	    cat $$(find $(buildlibdir)/libstdc++-v3 $(srcdir)/libstdc++-v3 -name '.new') || true; \
	  fi >> debian/README.libstdc++-baseline; \
	fi

# ----------------------------------------------------------------------
$(binary_stamp)-libstdcxx: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_lib)
	dh_installdirs -p$(p_lib) \
		$(docdir) \
		$(PF)/$(libdir)

	cp -a $(d)/$(PF)/$(libdir)/libstdc++.so.* \
		$(d_lib)/$(PF)/$(libdir)/

	debian/dh_doclink -p$(p_lib) $(p_base)
	debian/dh_rmemptydirs -p$(p_lib)

	dh_strip -v -p$(p_lib) --dbg-package=$(p_dbg)
	dh_compress -p$(p_lib)
	dh_fixperms -p$(p_lib)
	dh_makeshlibs -p$(p_lib) -V '$(p_lib) (>= $(DEB_STDCXX_SOVERSION))'
	cat debian/$(p_lib)/DEBIAN/shlibs >> debian/shlibs.local
	dh_shlibdeps \
		-L$(p_lgcc) -l:$(d)/$(PF)/lib:$(d_lgcc)/lib:\
		-p$(p_lib)
	dh_gencontrol -p$(p_lib) -- -v$(DEB_VERSION) $(common_substvars)

	dh_installdeb -p$(p_lib)
	dh_md5sums -p$(p_lib)
	dh_builddeb -p$(p_lib)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------

libc64_map = i386=amd64 sparc=sparc64 powerpc=ppc64 s390=s390x mips=mips64 mipsel=mips64 
libc64_name = $(patsubst $(DEB_TARGET_ARCH)=%,%, \
			$(filter $(DEB_TARGET_ARCH)=%,$(libc64_map))) 
libc64_dep = $(if $(libc64_name),libc6-$(libc64_name))

$(binary_stamp)-lib64stdcxx: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_lib64)
	dh_installdirs -p$(p_lib64) \
		$(docdir) \
		$(PF)/lib64

	cp -a $(d)/$(PF)/lib64/libstdc++.so.* \
		$(d_lib64)/$(PF)/lib64/.

	dh_strip -p$(p_lib64)

	debian/dh_doclink -p$(p_lib64) $(p_base)
	debian/dh_rmemptydirs -p$(p_lib64)

	dh_compress -p$(p_lib64)
	dh_fixperms -p$(p_lib64)
	dh_makeshlibs -p$(p_lib64) -V '$(p_lib64) (>= $(DEB_STDCXX_SOVERSION))'
# pass explicit dependencies to dh_shlibdeps
#	dh_shlibdeps -p$(p_lib64) -L $(p_l64gcc) -l $(d_l64gcc)/lib
#/usr/bin/ldd: line 1: /lib/ld64.so.1: cannot execute binary file
#dpkg-shlibdeps: failure: ldd on `debian/lib64gcc1/lib64/libgcc_s.so.1' gave error exit status 1
	echo 'shlibs:Depends=$(p_l64gcc) (>= $(DEB_LIBGCC_SOVERSION)), $(libc64_dep)' \
		> debian/$(p_lib64).substvars
	dh_gencontrol -p$(p_lib64) -- -v$(DEB_VERSION) $(common_substvars)

	dh_installdeb -p$(p_lib64)
	dh_md5sums -p$(p_lib64)
	dh_builddeb -p$(p_lib64)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-lib64stdcxxdbg: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_dbg64)
	dh_installdirs -p$(p_dbg64) \
		$(PF)/lib64
ifeq ($(with_lib64cxx),yes)
	cp -a $(d)/$(PF)/lib64/libstdc++.so.* \
		$(d_dbg64)/$(PF)/lib64/.
	dh_strip -p$(p_dbg64) --keep-debug
	rm -f $(d_dbg64)/$(PF)/lib64/libstdc++.so.*
  ifneq ($(with_common_libs),yes)
	: # remove the debug symbols for libstdc++ built by a newer version of GCC
	rm -rf $(d_dbg64)/usr/lib/debug/$(PF)
  endif
endif
	echo 'shlibs:Depends=$(p_l64gcc) (>= $(DEB_LIBGCC_SOVERSION)), $(libc64_dep)' \
		> debian/$(p_dbg64).substvars

ifeq ($(with_debug),yes)
	mv $(d)/$(PF)/lib64/debug $(d_dbg64)/$(PF)/lib64/.
	rm -f $(d_dbg64)/$(PF)/lib64/debug/libstdc++_pic.a
	rm -f $(d_dbg64)/$(PF)/lib64/debug/libstdc++.la
endif

	debian/dh_doclink -p$(p_dbg64) $(p_base)
	debian/dh_rmemptydirs -p$(p_dbg64)

	dh_compress -p$(p_dbg64)
	dh_fixperms -p$(p_dbg64)
	dh_gencontrol -p$(p_dbg64) -- -v$(DEB_VERSION) $(common_substvars)

	dh_installdeb -p$(p_dbg64)
	dh_md5sums -p$(p_dbg64)
	dh_builddeb -p$(p_dbg64)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-lib32stdcxx: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_lib32)

	dh_installdirs -p$(p_lib32) \
		$(docdir) \
		$(lib32)

	cp -a $(d)/$(lib32)/libstdc++.so.* \
		$(d_lib32)/$(lib32)/.

	debian/dh_doclink -p$(p_lib32) $(p_base)
	debian/dh_rmemptydirs -p$(p_lib32)

	dh_strip -p$(p_lib32)
	dh_compress -p$(p_lib32)
	dh_fixperms -p$(p_lib32)
	dh_makeshlibs -p$(p_lib32) -V '$(p_lib32) (>= $(DEB_STDCXX_SOVERSION))'
ifeq ($(DEB_TARGET_ARCH),amd64)
	echo 'shlibs:Depends=libc6-i386 | ia32-libs' \
		> debian/$(p_lib32).substvars
endif
ifeq ($(DEB_TARGET_ARCH),ppc64)
	echo 'shlibs:Depends=libc6-powerpc' \
		> debian/$(p_lib32).substvars
endif

	dh_gencontrol -p$(p_lib32) -- -v$(DEB_VERSION) $(common_substvars)

	dh_installdeb -p$(p_lib32)
	dh_md5sums -p$(p_lib32)
	dh_builddeb -p$(p_lib32)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-lib32stdcxxdbg: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_dbg32)
	dh_installdirs -p$(p_dbg32) \
		$(lib32)

ifeq ($(with_lib32cxx),yes)
	cp -a $(d)/$(lib32)/libstdc++.so.* \
		$(d_dbg32)/$(lib32)/.
	dh_strip -p$(p_dbg32) --keep-debug
  ifneq ($(with_common_libs),yes)
	: # remove the debug symbols for libstdc++ built by a newer version of GCC
	rm -rf $(d_dbg32)/usr/lib/debug/$(PF)
  endif
	rm -f $(d_dbg32)/$(lib32)/libstdc++.so.*
endif

ifeq ($(with_debug),yes)
	mv $(d)/$(lib32)/debug $(d_dbg32)/$(lib32)/.
	rm -f $(d_dbg32)/$(lib32)/debug/libstdc++_pic.a
	rm -f $(d_dbg32)/$(lib32)/debug/libstdc++.la
endif

	debian/dh_doclink -p$(p_dbg32) $(p_base)
	debian/dh_rmemptydirs -p$(p_dbg32)

	dh_compress -p$(p_dbg32)
	dh_fixperms -p$(p_dbg32)
ifeq ($(DEB_TARGET_ARCH),amd64)
	echo 'shlibs:Depends=libc6-i386 | ia32-libs' \
		> debian/$(p_dbg32).substvars
endif
ifeq ($(DEB_TARGET_ARCH),ppc64)
	echo 'shlibs:Depends=libc6-powerpc' \
		> debian/$(p_dbg32).substvars
endif
	dh_gencontrol -p$(p_dbg32) -- -v$(DEB_VERSION) $(common_substvars)

	dh_installdeb -p$(p_dbg32)
	dh_md5sums -p$(p_dbg32)
	dh_builddeb -p$(p_dbg32)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-libn32stdcxx: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_libn32)

	dh_installdirs -p$(p_libn32) \
		$(docdir) \
		$(PF)/$(libn32)

	cp -a $(d)/$(PF)/$(libn32)/libstdc++.so.* \
		$(d_libn32)/$(PF)/$(libn32)/.

	debian/dh_doclink -p$(p_libn32) $(p_base)
	debian/dh_rmemptydirs -p$(p_libn32)

	dh_strip -p$(p_libn32)
	dh_compress -p$(p_libn32)
	dh_fixperms -p$(p_libn32)
	dh_makeshlibs -p$(p_libn32) -V '$(p_libn32) (>= $(DEB_STDCXX_SOVERSION))'
	dh_gencontrol -p$(p_libn32) -- -v$(DEB_VERSION) $(common_substvars)

	dh_installdeb -p$(p_libn32)
	dh_md5sums -p$(p_libn32)
	dh_builddeb -p$(p_libn32)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-libn32stdcxxdbg: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_dbgn32)
	dh_installdirs -p$(p_dbgn32) \
		$(PF)/$(libn32)

ifeq ($(with_libn32cxx),yes)
	cp -a $(d)/$(PF)/$(libn32)/libstdc++.so.* \
		$(d_dbgn32)/$(PF)/$(libn32)/.
	dh_strip -p$(p_dbgn32) --keep-debug
  ifneq ($(with_common_libs),yes)
	: # remove the debug symbols for libstdc++ built by a newer version of GCC
	rm -rf $(d_dbgn32)/usr/lib/debug/$(PF)
  endif
	rm -f $(d_dbgn32)/$(PF)/$(libn32)/libstdc++.so.*
endif

ifeq ($(with_debug),yes)
	mv $(d)/$(PF)/$(libn32)/debug $(d_dbgn32)/$(PF)/$(libn32)/.
	rm -f $(d_dbgn32)/$(libn32)/debug/libstdc++_pic.a
	rm -f $(d_dbgn32)/$(libn32)/debug/libstdc++.la
endif

	debian/dh_doclink -p$(p_dbgn32) $(p_base)
	debian/dh_rmemptydirs -p$(p_dbgn32)

	dh_compress -p$(p_dbgn32)
	dh_fixperms -p$(p_dbgn32)
	dh_gencontrol -p$(p_dbgn32) -- -v$(DEB_VERSION) $(common_substvars)

	dh_installdeb -p$(p_dbgn32)
	dh_md5sums -p$(p_dbgn32)
	dh_builddeb -p$(p_dbgn32)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
libcxxdev_deps = $(install_stamp)
ifeq ($(with_libcxx),yes)
  libcxxdev_deps += $(binary_stamp)-libstdcxx
endif
ifeq ($(with_check),yes)
  libcxxdev_deps += debian/README.libstdc++-baseline
endif
$(binary_stamp)-libstdcxx-dev: $(libcxxdev_deps)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_dev) $(d_pic)
	dh_installdirs -p$(p_dev) $(dirs_dev)
	dh_installdirs -p$(p_pic) $(dirs_pic)
	dh_installdirs -p$(p_dbg) $(dirs_dbg)

	: # - correct libstdc++-v3 file locations
	mv $(d)/$(PF)/$(libdir)/libsupc++.a $(d)/$(gcc_lib_dir)/
	mv $(d)/$(PF)/$(libdir)/libstdc++.{a,so} $(d)/$(gcc_lib_dir)/
	ln -sf ../../../$(DEB_TARGET_GNU_TYPE)/libstdc++.so.$(CXX_SONAME) \
		$(d)/$(gcc_lib_dir)/libstdc++.so
	mv $(d)/$(PF)/$(libdir)/libstdc++_pic.a $(d)/$(gcc_lib_dir)/

	rm -f $(d)/$(PF)/$(libdir)/debug/libstdc++_pic.a
	rm -f $(d)/$(PF)/lib64/debug/libstdc++_pic.a

	: # remove precompiled headers
	-find $(d) -type d -name '*.gch' | xargs rm -rf

	for i in $(d)/$(PF)/include/c++/$(GCC_VERSION)/*-linux; do \
	  if [ -d $$i ]; then mv $$i $$i-gnu; fi; \
	done

	DH_COMPAT=2 dh_movefiles -p$(p_dev) $(files_dev)
	DH_COMPAT=2 dh_movefiles -p$(p_pic) $(files_pic)
ifeq ($(with_debug),yes)
	DH_COMPAT=2 dh_movefiles -p$(p_dbg) $(files_dbg)
endif

	dh_link -p$(p_dev) \
		/$(PF)/$(libdir)/libstdc++.so.$(CXX_SONAME) \
		/$(gcc_lib_dir)/libstdc++.so \
		/$(cxx_inc_dir) /$(PF)/include/c++/$(GCC_VERSION)

	debian/dh_doclink -p$(p_dev) $(p_base)
	debian/dh_doclink -p$(p_pic) $(p_base)
	debian/dh_doclink -p$(p_dbg) $(p_base)
	cp -p $(srcdir)/libstdc++-v3/ChangeLog \
		$(d_dev)/$(docdir)/$(p_base)/C++/changelog.libstdc++
ifeq ($(with_check),yes)
	cp -p debian/README.libstdc++-baseline \
		$(d_dev)/$(docdir)/$(p_base)/C++/README.libstdc++-baseline
	if [ -f $(buildlibdir)/libstdc++-v3/testsuite/current_symbols.txt ]; \
	then \
	  cp -p $(buildlibdir)/libstdc++-v3/testsuite/current_symbols.txt \
	    $(d_dev)/$(docdir)/$(p_base)/C++/libstdc++_symbols.txt; \
	fi
endif
	cp -p $(buildlibdir)/libstdc++-v3/src/libstdc++-symbols.ver \
		$(d_pic)/$(gcc_lib_dir)/libstdc++_pic.map

ifeq ($(with_libcxx),yes)
	cp -a $(d)/$(PF)/$(libdir)/libstdc++.so.* \
		$(d_dbg)/$(PF)/$(libdir)/
	dh_strip -p$(p_dbg) --keep-debug
	rm -f $(d_dbg)/$(PF)/$(libdir)/libstdc++.so.*
endif

	dh_strip -p$(p_dev) --dbg-package=$(p_dbg)
ifneq ($(with_common_libs),yes)
	: # remove the debug symbols for libstdc++ built by a newer version of GCC
	rm -rf $(d_dbg)/usr/lib/debug/$(PF)
endif
	dh_strip -p$(p_pic)

ifeq ($(with_cxxdev),yes)
	debian/dh_rmemptydirs -p$(p_dev)
	debian/dh_rmemptydirs -p$(p_pic)
	debian/dh_rmemptydirs -p$(p_dbg)
endif

	dh_compress -p$(p_dev) -p$(p_pic) -p$(p_dbg) -X.txt
	dh_fixperms -p$(p_dev) -p$(p_pic) -p$(p_dbg)
# XXX: what about biarchn32?
ifeq ($(biarch64),yes)
	dh_shlibdeps -p$(p_dev) -p$(p_pic) -p$(p_dbg) -Xlib64
else
	dh_shlibdeps -p$(p_dev) -p$(p_pic) -p$(p_dbg) -Xlib32/debug
endif
	dh_gencontrol -p$(p_dev) -p$(p_pic) -p$(p_dbg) \
		-- -v$(DEB_VERSION) $(common_substvars)

	dh_installdeb -p$(p_dev) -p$(p_pic) -p$(p_dbg)
	dh_md5sums -p$(p_dev) -p$(p_pic) -p$(p_dbg)
	dh_builddeb -p$(p_dev) -p$(p_pic) -p$(p_dbg)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------

doxygen_doc_dir = $(buildlibdir)/libstdc++-v3/doc

doxygen-docs: $(build_doxygen_stamp)
$(build_doxygen_stamp):
ifeq (no,$(NO_DOCS))
	$(MAKE) -C $(buildlibdir)/libstdc++-v3/doc SHELL=/bin/bash doc-html-doxygen
	$(MAKE) -C $(buildlibdir)/libstdc++-v3/doc SHELL=/bin/bash doc-man-doxygen
	-find $(doxygen_doc_dir)/doxygen/html -name 'struct*' -empty | xargs rm -f
else
	@echo Skipping doc generation
endif
	touch $@

$(binary_stamp)-libstdcxx-doc: $(install_stamp) doxygen-docs
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_libd)
	dh_installdirs -p$(p_libd) \
		$(docdir)/$(p_base)/libstdc++ \
		$(PF)/share/man

#	debian/dh_doclink -p$(p_libd) $(p_base)
	dh_link -p$(p_libd) /usr/share/doc/$(p_base) /usr/share/doc/$(p_libd)
ifeq (no,$(NO_DOCS))
	dh_installdocs -p$(p_libd)
else
	@echo Skipping doc generation
endif
	rm -f $(d_libd)/$(docdir)/$(p_base)/copyright

ifeq (no,$(NO_DOCS))
	cp -a $(srcdir)/libstdc++-v3/doc/html \
		$(d_libd)/$(docdir)/$(p_base)/libstdc++/.

	cp -a $(doxygen_doc_dir)/doxygen/html \
		$(d_libd)/$(docdir)/$(p_base)/libstdc++/.
	for i in $(doxygen_doc_dir)/doxygen/man/man3/*.3; do \
	  [ -f $${i} ] || continue; \
	  mv $${i} $${i}cxx; \
	done
	cp -a $(doxygen_doc_dir)/doxygen/man/man3 \
		$(d_libd)/$(PF)/share/man/.
else
	@echo Skipping doc generation
endif
	rm -f $(d_libd)/$(PF)/share/man/man3/todo.3*

ifeq (no,$(NO_DOCS))
	mkdir -p $(d_libd)/usr/share/lintian/overrides
	cp -p debian/$(p_libd).overrides \
		$(d_libd)/usr/share/lintian/overrides/$(p_libd)

	dh_compress -p$(p_libd) -Xhtml/17_intro -X.txt -X.tag -X.map
	dh_fixperms -p$(p_libd)
else
	@echo Skipping doc generation
endif
	dh_gencontrol -p$(p_libd) -- -v$(DEB_VERSION) $(common_substvars)

	dh_installdeb -p$(p_libd)
	dh_md5sums -p$(p_libd)
	dh_builddeb -p$(p_libd)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)
