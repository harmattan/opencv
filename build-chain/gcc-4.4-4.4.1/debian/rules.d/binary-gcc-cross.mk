arch_binaries  := $(arch_binaries) gcc

# gcc must be moved after g77 and g++
# not all files $(PF)/include/*.h are part of gcc,
# but it becomes difficult to name all these files ...

dirs_gcc = \
	$(docdir)/$(p_base)/gomp \
	$(PF)/bin \
	$(gcc_lexec_dir) \
	$(gcc_lib_dir)/{include,include-fixed} \
	$(PF)/share/man/man1 $(libdir)

files_gcc = \
	$(PF)/bin/$(DEB_TARGET_GNU_TYPE)-gcc$(pkg_ver) \
	$(PF)/bin/$(DEB_TARGET_GNU_TYPE)-gcov$(pkg_ver) \
	$(PF)/share/man/man1/$(DEB_TARGET_GNU_TYPE)-gcc$(pkg_ver).1 \
	$(PF)/share/man/man1/$(DEB_TARGET_GNU_TYPE)-gcov$(pkg_ver).1 \
	$(gcc_lexec_dir)/collect2 \
	$(gcc_lib_dir)/{libgcc*,libgcov.a,*.o} \
	$(gcc_lib_dir)/include/std*.h \
	$(shell for h in \
		    README features.h arm_neon.h \
		    {cpuid,decfloat,float,iso646,limits,mm3dnow,mm_malloc}.h \
		    {ppu_intrinsics,paired,spu2vmx,vec_types,si2vmx}.h \
		    {,a,b,e,i,n,p,s,t,w,x}mmintrin.h mmintrin-common.h \
		    {x86,avx}intrin.h \
		    {cross-stdarg,syslimits,unwind,varargs}.h; \
		do \
		  test -e $(d)/$(gcc_lib_dir)/include/$$h \
		    && echo $(gcc_lib_dir)/include/$$h; \
		  test -e $(d)/$(gcc_lib_dir)/include-fixed/$$h \
		    && echo $(gcc_lib_dir)/include-fixed/$$h; \
		done) \
	$(shell for d in \
		  asm bits gnu linux $(TARGET_ALIAS) \
		  $(subst $(DEB_TARGET_GNU_CPU),$(biarch_cpu),$(TARGET_ALIAS)); \
		do \
		  test -e $(d)/$(gcc_lib_dir)/include/$$d \
		    && echo $(gcc_lib_dir)/include/$$d; \
		  test -e $(d)/$(gcc_lib_dir)/include-fixed/$$d \
		    && echo $(gcc_lib_dir)/include-fixed/$$d; \
		done) \
	$(shell test -e $(d)/$(gcc_lib_dir)/SYSCALLS.c.X \
		&& echo $(gcc_lib_dir)/SYSCALLS.c.X)

ifeq ($(with_ssp),yes)
    files_gcc += $(gcc_lib_dir)/libssp_nonshared.a
endif
ifeq ($(with_libssp),yes)
    files_gcc += $(gcc_lib_dir)/include/ssp
endif
ifeq ($(with_gomp),yes)
    files_gcc += $(gcc_lib_dir)/include/omp.h
endif
ifeq ($(biarch64),yes)
    files_gcc += $(gcc_lib_dir)/$(biarch64subdir)/{libgcc*,*.o}
endif
ifeq ($(biarch32),yes)
    files_gcc += $(gcc_lib_dir)/$(biarch32subdir)/{libgcc*,*.o}
endif
ifeq ($(biarchn32),yes)
    files_gcc += $(gcc_lib_dir)/$(biarchn32subdir)/{libgcc*,*.o}
endif

ifeq ($(DEB_TARGET_ARCH),ia64)
    files_gcc += $(gcc_lib_dir)/include/ia64intrin.h
endif

ifeq ($(DEB_TARGET_ARCH),m68k)
    files_gcc += $(gcc_lib_dir)/include/math-68881.h
endif

ifeq ($(DEB_TARGET_ARCH),$(findstring $(DEB_TARGET_ARCH),powerpc ppc64))
    files_gcc += $(gcc_lib_dir)/include/{altivec.h,ppc-asm.h}
endif

usr_doc_files = debian/README.Bugs \
	$(shell test -f $(srcdir)/FAQ && echo $(srcdir)/FAQ)
ifeq ($(with_check),yes)
  usr_doc_files += test-summary
endif

# ----------------------------------------------------------------------
$(binary_stamp)-gcc: $(install_dependencies)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_gcc)
	dh_installdirs -p$(p_gcc) $(dirs_gcc)

	: # libgcc_s.so may be a linker script on some architectures
	set -e; \
	if [ -h $(d)/$(PF)/$(libdir)/libgcc_s.so ]; then \
	  rm -f $(d)/$(PF)/$(libdir)/libgcc_s.so; \
	  ln -sf /$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)/libgcc_s.so.$(GCC_SONAME) \
	    $(d)/$(gcc_lib_dir)/libgcc_s.so; \
	else \
	  mv $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib/libgcc_s.so \
	    $(d)/$(gcc_lib_dir)/libgcc_s.so; \
	  ln -sf /$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)/libgcc_s.so.$(GCC_SONAME) \
	    $(d)/$(gcc_lib_dir)/libgcc_s.so.$(GCC_SONAME); \
	fi


ifeq ($(with_ssp),yes)
	mv $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)/libssp_nonshared.a \
		$(d)/$(gcc_lib_dir)/
endif
ifeq ($(with_libssp),yes)
	mv $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)lib/libssp*.a $(d_gcc)/$(gcc_lib_dir)/
	rm -f $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)lib/libssp*.{la,so}
	dh_link -p$(p_gcc) \
	  /$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)lib/libssp.so.$(SSP_SONAME) /$(gcc_lib_dir)/libssp.so
	cp -p $(srcdir)/libssp/ChangeLog \
		$(d_gcc)/$(docdir)/$(p_base)/libssp/changelog
endif
ifeq ($(with_gomp),yes)
	mv $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)/libgomp*.{a,spec} \
		$(d_gcc)/$(gcc_lib_dir)/
	rm -f $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)/libgomp*.{la,so}
	dh_link -p$(p_gcc) \
	  /$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)lib/libgomp.so.$(GOMP_SONAME) /$(gcc_lib_dir)/libgomp.so
	cp -p $(srcdir)/libgomp/ChangeLog \
		$(d_gcc)/$(docdir)/$(p_base)/gomp/changelog
endif

ifeq ($(biarch64),yes)
	rm -f $(d)/$(PF)/$(lib64)/libgcc_s.so
	dh_link -p$(p_gcc) \
	  /$(PF)/$(DEB_TARGET_GNU_TYPE)/$(lib64)/libgcc_s.so.$(GCC_SONAME) /$(gcc_lib_dir)/libgcc_s_64.so \
	  /$(PF)/$(DEB_TARGET_GNU_TYPE)/$(lib64)/libgcc_s.so.$(GCC_SONAME) /$(gcc_lib_dir)/$(biarch64subdir)/libgcc_s.so
endif
ifeq ($(biarch32),yes)
	mkdir -p $(d_gcc)/$(gcc_lib_dir)
	mv $(d)/$(gcc_lib_dir)/$(biarch32subdir) $(d_gcc)/$(gcc_lib_dir)/
	dh_link -p$(p_gcc) \
	  /$(PF)/$(DEB_TARGET_GNU_TYPE)/lib32/libgcc_s.so.$(GCC_SONAME)  /$(gcc_lib_dir)/libgcc_s_32.so \
	  /$(PF)/$(DEB_TARGET_GNU_TYPE)/lib32/libgcc_s.so.$(GCC_SONAME)  /$(gcc_lib_dir)/$(biarch32subdir)/libgcc_s_32.so \
	  /$(PF)/$(DEB_TARGET_GNU_TYPE)/lib32/libgcc_s.so.$(GCC_SONAME)  /$(gcc_lib_dir)/$(biarch32subdir)/libgcc_s.so
endif
ifeq ($(biarchn32),yes)
	rm -f $(d)/$(PF)/$(libn32)/libgcc_s.so
	dh_link -p$(p_gcc) \
	  /$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libn32)/libgcc_s.so.$(GCC_SONAME) /$(gcc_lib_dir)/libgcc_s_n32.so \
	  /$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libn32)/libgcc_s.so.$(GCC_SONAME) /$(gcc_lib_dir)/$(biarchn32subdir)/libgcc_s.so
endif

	DH_COMPAT=2 dh_movefiles -p$(p_gcc) $(files_gcc)

ifeq ($(with_unversioned),yes)
	ln -sf $(DEB_TARGET_GNU_TYPE)-gcc$(pkg_ver) \
	  $(d_gcc)/$(PF)/bin/$(DEB_TARGET_GNU_TYPE)-gcc
	ln -sf $(DEB_TARGET_GNU_TYPE)-gcc$(pkg_ver).1 \
	  $(d_gcc)/$(PF)/share/man/man1/$(DEB_TARGET_GNU_TYPE)-gcc.1
	ln -sf $(DEB_TARGET_GNU_TYPE)-gcov$(pkg_ver) \
	  $(d_gcc)/$(PF)/bin/$(DEB_TARGET_GNU_TYPE)-gcov
	ln -sf $(DEB_TARGET_GNU_TYPE)-gcov$(pkg_ver).1 \
	  $(d_gcc)/$(PF)/share/man/man1/$(DEB_TARGET_GNU_TYPE)-gcov.1
endif

#	dh_installdebconf
	debian/dh_doclink -p$(p_gcc) $(p_base)
	debian/dh_rmemptydirs -p$(p_gcc)
	PATH=/usr/share/dpkg-cross:$$PATH dh_strip -p$(p_gcc)
	dh_compress -p$(p_gcc)
	dh_fixperms -p$(p_gcc)
	dh_shlibdeps -p$(p_gcc)
	dh_gencontrol -p$(p_gcc) -- -v$(DEB_VERSION) $(common_substvars)
	sed 's/cross-/$(DEB_TARGET_GNU_TYPE)-/g;s/-ver/$(pkg_ver)/g' < debian/gcc-cross.postinst > debian/$(p_gcc)/DEBIAN/postinst
	sed 's/cross-/$(DEB_TARGET_GNU_TYPE)-/g;s/-ver/$(pkg_ver)/g' < debian/gcc-cross.prerm > debian/$(p_gcc)/DEBIAN/prerm
	chmod 755 debian/$(p_gcc)/DEBIAN/{postinst,prerm}
	dh_installdeb -p$(p_gcc)
	dh_md5sums -p$(p_gcc)
	dh_builddeb -p$(p_gcc)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

	: # remove empty directories, when all components are in place
	for d in `find $(d) -depth -type d -empty 2> /dev/null`; do \
	    while rmdir $$d 2> /dev/null; do d=`dirname $$d`; done; \
	done

	@echo "Listing installed files not included in any package:"
	-find $(d) ! -type d

