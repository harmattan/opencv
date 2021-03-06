ifeq ($(with_libgfortran),yes)
  indep_binaries  := $(indep_binaries) libgfortran
endif
ifeq ($(with_lib64gfortran),yes)
  indep_binaries  := $(indep_binaries) lib64fortran
endif
ifeq ($(with_lib32gfortran),yes)
  indep_binaries	:= $(indep_binaries) lib32fortran
endif
ifeq ($(with_libn32gfortran),yes)
  indep_binaries	:= $(indep_binaries) libn32fortran
endif

ifeq ($(with_fdev),yes)
  ifneq (,$(filter yes, $(biarch64) $(biarch32) $(biarchn32)))
    arch_binaries  := $(arch_binaries) fdev-multi
  endif
  arch_binaries  := $(arch_binaries) fdev
  #ifneq ($(GFDL_INVARIANT_FREE),yes)
  #  indep_binaries := $(indep_binaries) fortran-doc
  #endif
endif

p_g95	= gfortran$(pkg_ver)$(cross_bin_arch)
p_g95_m	= gfortran$(pkg_ver)-multilib
p_g95d	= gfortran$(pkg_ver)-doc
p_flib	= libgfortran$(FORTRAN_SONAME)$(cross_lib_arch)
p_f32lib= lib32gfortran$(FORTRAN_SONAME)$(cross_lib_arch)
p_f64lib= lib64gfortran$(FORTRAN_SONAME)$(cross_lib_arch)
p_fn32lib= libn32gfortran$(FORTRAN_SONAME)$(cross_lib_arch)
p_flibdbg	= libgfortran$(FORTRAN_SONAME)-dbg
p_f32libdbg	= lib32gfortran$(FORTRAN_SONAME)-dbg
p_f64libdbg	= lib64gfortran$(FORTRAN_SONAME)-dbg
p_fn32libdbg	= libn32gfortran$(FORTRAN_SONAME)-dbg

d_g95	= debian/$(p_g95)
d_g95_m	= debian/$(p_g95_m)
d_g95d	= debian/$(p_g95d)
d_flib	= debian/$(p_flib)
d_f32lib= debian/$(p_f32lib)
d_f64lib= debian/$(p_f64lib)
d_fn32lib= debian/$(p_fn32lib)
d_flibdbg	= debian/$(p_flibdbg)
d_f32libdbg	= debian/$(p_f32libdbg)
d_f64libdbg	= debian/$(p_f64libdbg)
d_fn32libdbg	= debian/$(p_fn32libdbg)

dirs_g95 = \
	$(docdir)/$(p_base)/fortran \
	$(PF)/bin \
	$(gcc_lexec_dir) \
	$(gcc_lib_dir) \
	$(PF)/include \
	$(PF)/share/man/man1
files_g95 = \
	$(PF)/bin/$(DEB_TARGET_GNU_TYPE)-gfortran$(pkg_ver) \
	$(gcc_lib_dir)/finclude \
	$(gcc_lib_dir)/libgfortranbegin.a \
	$(gcc_lexec_dir)/f951 

ifneq ($(GFDL_INVARIANT_FREE),yes)
  files_g95 += \
	$(PF)/share/man/man1/$(DEB_TARGET_GNU_TYPE)-gfortran$(pkg_ver).1
endif

dirs_flib = \
	$(docdir) \
	$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)

files_flib = \
	$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)/libgfortran.so.*

# ----------------------------------------------------------------------
$(binary_stamp)-libgfortran: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_flib)$(d_flibdbg)
	dh_installdirs -p$(p_flib) $(dirs_flib)
	DH_COMPAT=2 dh_movefiles -p$(p_flib) $(files_flib)
	debian/dh_doclink -p$(p_flib) $(p_base)
#	debian/dh_doclink -p$(p_flibdbg) $(p_base)

	dh_strip -p$(p_flib) #--dbg-package=$(p_flibdbg)
	dh_compress -p$(p_flib) #-p$(p_flibdbg)
	dh_fixperms -p$(p_flib) #-p$(p_flibdbg)
	dh_makeshlibs -p$(p_flib) -V '$(p_flib) (>= $(DEB_SOVERSION))'
	sed -i s/$(cross_lib_arch)//g debian/$(p_flib)/DEBIAN/shlibs
	$(SET_CROSS_LIB_PATH) ARCH=$(DEB_TARGET_ARCH) MAKEFLAGS="CC=something" dh_shlibdeps -p$(p_flib)
	sed -i 's/\(lib[^ ]*\) /\1$(cross_lib_arch) /g' debian/$(p_flib).substvars
#	dh_gencontrol -p$(p_flib) -p$(p_flibdbg) \
#		-- -v$(DEB_VERSION) $(common_substvars)
	dh_gencontrol -p$(p_flib) \
		-- -v$(DEB_VERSION) $(common_substvars)
	dh_installdeb -p$(p_flib) #-p$(p_flibdbg)
	dh_md5sums -p$(p_flib) #-p$(p_flibdbg)
	dh_builddeb -p$(p_flib) #-p$(p_flibdbg)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-lib64fortran: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_f64lib) $(d_f64libdbg)
	dh_installdirs -p$(p_f64lib) \
		$(PF)/$(DEB_TARGET_GNU_TYPE)/lib64
	DH_COMPAT=2 dh_movefiles -p$(p_f64lib) \
		$(PF)/$(DEB_TARGET_GNU_TYPE)/lib64/libgfortran.so.*

	debian/dh_doclink -p$(p_f64lib) $(p_base)
#	debian/dh_doclink -p$(p_f64libdbg) $(p_base)

	dh_strip -p$(p_f64lib) #--dbg-package=$(p_f64libdbg)
	dh_compress -p$(p_f64lib) #-p$(p_f64libdbg)
	dh_fixperms -p$(p_f64lib) #-p$(p_f64libdbg)
	dh_makeshlibs -p$(p_f64lib) -V '$(p_f64lib) (>= $(DEB_SOVERSION))'
	sed -i s/$(cross_lib_arch)//g debian/$(p_f64lib)/DEBIAN/shlibs
#	$(SET_CROSS_LIB_PATH) ARCH=$(DEB_TARGET_ARCH) MAKEFLAGS="CC=something" dh_shlibdeps -p$(p_f64lib)
#	sed -i 's/\(lib[^ ]*\) /\1$(cross_lib_arch) /g' debian/$(p_f64lib).substvars
#	dh_gencontrol -p$(p_f64lib) -p$(p_f64libdbg) \
#		-- -v$(DEB_VERSION) $(common_substvars)
	dh_gencontrol -p$(p_f64lib) \
		-- -v$(DEB_VERSION) $(common_substvars)
	dh_installdeb -p$(p_f64lib) #-p$(p_f64libdbg)
	dh_md5sums -p$(p_f64lib) #-p$(p_f64libdbg)
	dh_builddeb -p$(p_f64lib) #-p$(p_f64libdbg)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-lib32fortran: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_f32lib) $(d_f32libdbg)
	dh_installdirs -p$(p_f32lib) \
		$(PF)/$(DEB_TARGET_GNU_TYPE)/lib32
	DH_COMPAT=2 dh_movefiles -p$(p_f32lib) \
		$(PF)/$(DEB_TARGET_GNU_TYPE)/lib32/libgfortran.so.*

	debian/dh_doclink -p$(p_f32lib) $(p_base)
#	debian/dh_doclink -p$(p_f32libdbg) $(p_base)

	dh_strip -p$(p_f32lib) #--dbg-package=$(p_f32libdbg)
	dh_compress -p$(p_f32lib) #-p$(p_f32libdbg)
	dh_fixperms -p$(p_f32lib) #-p$(p_f32libdbg)
	dh_makeshlibs -p$(p_f32lib) -V '$(p_f32lib) (>= $(DEB_SOVERSION))'
	sed -i s/$(cross_lib_arch)//g debian/$(p_f32lib)/DEBIAN/shlibs
#	$(SET_CROSS_LIB_PATH) ARCH=$(DEB_TARGET_ARCH) MAKEFLAGS="CC=something" dh_shlibdeps -p$(p_f32lib)
#	sed -i 's/\(lib[^ ]*\) /\1$(cross_lib_arch) /g' debian/$(p_f32lib).substvars
#	dh_gencontrol -p$(p_f32lib) -p$(p_f32libdbg) \
#		-- -v$(DEB_VERSION) $(common_substvars)
	dh_gencontrol -p$(p_f32lib) \
		-- -v$(DEB_VERSION) $(common_substvars)
	dh_installdeb -p$(p_f32lib) #-p$(p_f32libdbg)
	dh_md5sums -p$(p_f32lib) #-p$(p_f32libdbg)
	dh_builddeb -p$(p_f32lib) #-p$(p_f32libdbg)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-libn32fortran: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_fn32lib) $(d_fn32libdbg)
	dh_installdirs -p$(p_fn32lib) \
		$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libn32)
	DH_COMPAT=2 dh_movefiles -p$(p_fn32lib) \
		$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libn32)/libgfortran.so.*

	debian/dh_doclink -p$(p_fn32lib) $(p_base)
#	debian/dh_doclink -p$(p_fn32libdbg) $(p_base)

	dh_strip -p$(p_fn32lib) #--dbg-package=$(p_fn32libdbg)
	dh_compress -p$(p_fn32lib) #-p$(p_fn32libdbg)
	dh_fixperms -p$(p_fn32lib) #-p$(p_fn32libdbg)
	dh_makeshlibs -p$(p_fn32lib) -V '$(p_fn32lib) (>= $(DEB_SOVERSION))'
	sed -i s/$(cross_lib_arch)//g debian/$(p_fn32lib)/DEBIAN/shlibs
#	$(SET_CROSS_LIB_PATH) ARCH=$(DEB_TARGET_ARCH) MAKEFLAGS="CC=something" dh_shlibdeps -p$(p_fn32lib)
#	sed -i 's/\(lib[^ ]*\) /\1$(cross_lib_arch) /g' debian/$(p_fn32lib).substvars
#	dh_gencontrol -p$(p_fn32lib) -p$(p_fn32libdbg) \
#		-- -v$(DEB_VERSION) $(common_substvars)
	dh_gencontrol -p$(p_fn32lib) \
		-- -v$(DEB_VERSION) $(common_substvars)
	dh_installdeb -p$(p_fn32lib) #-p$(p_fn32libdbg)
	dh_md5sums -p$(p_fn32lib) #-p$(p_fn32libdbg)
	dh_builddeb -p$(p_fn32lib) #-p$(p_fn32libdbg)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-fdev: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_g95)
	dh_installdirs -p$(p_g95) $(dirs_g95)

	rm -f $(d)/$(gcc_lib_dir)/libgfortranbegin.la
	rm -f $(d)/$(gcc_lib_dir)/$(biarchsubdirs)/libgfortranbegin.la

	DH_COMPAT=2 dh_movefiles -p$(p_g95) $(files_g95)

	rm -f $(d)/$(PF)/lib/libgfortran*.{la,so}
	mv $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib/libgfortran*.a $(d_g95)/$(gcc_lib_dir)/
	dh_link -p$(p_g95) \
	  /$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)/libgfortran.so.$(FORTRAN_SONAME) \
	  /$(gcc_lib_dir)/libgfortran.so

# TODO: why are these in the native rules file?
#	ln -sf gfortran$(pkg_ver) \
#	    $(d_g95)/$(PF)/bin/$(DEB_TARGET_GNU_TYPE)-gfortran$(pkg_ver)
#	ln -sf gfortran$(pkg_ver) \
#	    $(d_g95)/$(PF)/bin/$(TARGET_ALIAS)-gfortran$(pkg_ver)
ifneq ($(GFDL_INVARIANT_FREE),yes)
#	ln -sf gfortran$(pkg_ver).1 \
#	    $(d_g95)/$(PF)/share/man/man1/$(DEB_TARGET_GNU_TYPE)-gfortran$(pkg_ver).1
#	ln -sf gfortran$(pkg_ver).1 \
#	    $(d_g95)/$(PF)/share/man/man1/$(TARGET_ALIAS)-gfortran$(pkg_ver).1
endif

ifeq ($(with_unversioned),yes)
	ln -sf $(DEB_TARGET_GNU_TYPE)-gfortran$(pkg_ver) \
	  $(d_g95)/$(PF)/bin/$(DEB_TARGET_GNU_TYPE)-gfortran
	ln -sf $(DEB_TARGET_GNU_TYPE)-gfortran$(pkg_ver).1 \
	  $(d_g95)/$(PF)/share/man/man1/$(DEB_TARGET_GNU_TYPE)-gfortran.1
endif

	debian/dh_doclink -p$(p_g95) $(p_base)

	cp -p $(srcdir)/gcc/fortran/ChangeLog \
		$(d_g95)/$(docdir)/$(p_base)/fortran/changelog
	debian/dh_rmemptydirs -p$(p_g95)

	dh_strip -p$(p_g95)
	dh_compress -p$(p_g95)
	dh_fixperms -p$(p_g95)
	dh_shlibdeps -p$(p_g95)
	dh_gencontrol -p$(p_g95) -- -v$(DEB_VERSION) $(common_substvars)
	dh_installdeb -p$(p_g95)
	dh_md5sums -p$(p_g95)
	dh_builddeb -p$(p_g95)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-fdev-multi: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_g95_m)
	dh_installdirs -p$(p_g95_m) \
		$(docdir) \
		$(gcc_lib_dir)/$(biarchsubdirs)
	DH_COMPAT=2 dh_movefiles -p$(p_g95_m) \
		$(gcc_lib_dir)/$(biarchsubdirs)/libgfortranbegin.a

ifeq ($(biarch64),yes)
	rm -f $(d)/$(PF)/lib64/libgfortran*.{la,so}
	mkdir -p $(d_g95_m)/$(gcc_lib_dir)/$(biarch64subdir)
	mv $(d)/$(PF)/lib64/libgfortran*.a $(d_g95_m)/$(gcc_lib_dir)/$(biarch64subdir)/
	dh_link -p$(p_g95_m) \
	  /$(PF)/lib64/libgfortran.so.$(FORTRAN_SONAME) /$(gcc_lib_dir)/$(biarch64subdir)/libgfortran.so
endif
ifeq ($(biarch32),yes)
	rm -f $(d)/$(lib32)/libgfortran*.{la,so}
	mkdir -p $(d_g95_m)/$(gcc_lib_dir)/$(biarch32subdir)
	mv $(d)/$(lib32)/libgfortran*.a $(d_g95_m)/$(gcc_lib_dir)/$(biarch32subdir)/
	dh_link -p$(p_g95_m) \
	  /$(lib32)/libgfortran.so.$(FORTRAN_SONAME) /$(gcc_lib_dir)/$(biarch32subdir)/libgfortran.so
endif
ifeq ($(biarchn32),yes)
	rm -f $(d)/$(PF)/$(libn32)/libgfortran*.{la,so}
	mkdir -p $(d_g95_m)/$(gcc_lib_dir)/$(biarchn32subdir)
	mv $(d)/$(PF)/$(libn32)/libgfortran*.a $(d_g95_m)/$(gcc_lib_dir)/$(biarchn32subdir)/
	dh_link -p$(p_g95_m) \
	  /$(PF)/$(libn32)/libgfortran.so.$(FORTRAN_SONAME) /$(gcc_lib_dir)/$(biarchn32subdir)/libgfortran.so
endif

	debian/dh_doclink -p$(p_g95_m) $(p_base)
	debian/dh_rmemptydirs -p$(p_g95_m)
	dh_strip -p$(p_g95_m)
	dh_compress -p$(p_g95_m)
	dh_fixperms -p$(p_g95_m)
	dh_shlibdeps -p$(p_g95_m)
	dh_gencontrol -p$(p_g95_m) -- -v$(DEB_VERSION) $(common_substvars)
	dh_installdeb -p$(p_g95_m)
	dh_md5sums -p$(p_g95_m)
	dh_builddeb -p$(p_g95_m)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-fortran-doc: $(build_html_stamp) $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_g95d)
	dh_installdirs -p$(p_g95d) \
		$(docdir)/$(p_base)/fortran \
		$(PF)/share/info
	DH_COMPAT=2 dh_movefiles -p$(p_g95d) \
		$(PF)/share/info/gfortran*

	debian/dh_doclink -p$(p_g95d) $(p_base)
ifneq ($(GFDL_INVARIANT_FREE),yes)
	dh_installdocs -p$(p_g95d)
	rm -f $(d_g95d)/$(docdir)/$(p_base)/copyright
	cp -p html/gfortran.html $(d_g95d)/$(docdir)/$(p_base)/fortran/
endif

	dh_compress -p$(p_g95d)
	dh_fixperms -p$(p_g95d)
	dh_installdeb -p$(p_g95d)
	dh_gencontrol -p$(p_g95d) -- -v$(DEB_VERSION) $(common_substvars)
	dh_md5sums -p$(p_g95d)
	dh_builddeb -p$(p_g95d)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)
