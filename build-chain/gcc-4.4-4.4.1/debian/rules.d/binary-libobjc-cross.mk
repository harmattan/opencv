ifeq ($(with_objcdev),yes)
  indep_binaries := $(indep_binaries) libobjc
endif
ifeq ($(with_lib64objc),yes)
  indep_binaries  := $(indep_binaries) lib64objc
endif
ifeq ($(with_lib32objc),yes)
  indep_binaries	:= $(indep_binaries) lib32objc
endif

p_lobjc		= libobjc$(OBJC_SONAME)$(cross_lib_arch)
p_l32objc	= lib32objc$(OBJC_SONAME)$(cross_lib_arch)
p_l64objc	= lib64objc$(OBJC_SONAME)$(cross_lib_arch)

d_lobjc		= debian/$(p_lobjc)
d_l32objc	= debian/$(p_l32objc)
d_l64objc	= debian/$(p_l64objc)

dirs_lobjc = \
	$(docdir) \
	$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)
files_lobjc = \
	$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)/libobjc.so.*
ifeq ($(with_objc_gc),yes)
  files_lobjc += \
	$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)/libobjc_gc.so.*
endif


$(binary_stamp)-libobjc: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_lobjc)
	dh_installdirs -p$(p_lobjc) $(dirs_lobjc)
#	mv $(d)/$(gcc_lib_dir)/libobjc.so.* $(d)/$(PF)/$(libdir)/.
#ifeq ($(with_objc_gc),yes)
#	mv $(d)/$(gcc_lib_dir)/libobjc_gc.so.* $(d)/$(PF)/$(libdir)/.
#endif
	DH_COMPAT=2 dh_movefiles -p$(p_lobjc) $(files_lobjc)

	dh_installdocs -p$(p_lobjc)
	echo "See /$(docdir)/$(p_base) for more information" \
		> $(d_lobjc)/$(docdir)/$(p_lobjc)/README.Debian
	dh_installchangelogs -p$(p_lobjc)

	debian/dh_rmemptydirs -p$(p_lobjc)

	PATH=/usr/share/dpkg-cross:$$PATH dh_strip -p$(p_lobjc)
	dh_compress -p$(p_lobjc)

	dh_fixperms -p$(p_lobjc)
	dh_makeshlibs -p$(p_lobjc) -V '$(p_lobjc) (>= $(DEB_SOEVERSION))' -n
	sed s/$(cross_lib_arch)//g < debian/$(p_lobjc)/DEBIAN/shlibs > debian/$(p_lobjc)/DEBIAN/shlibs.fixed
	mv debian/$(p_lobjc)/DEBIAN/shlibs.fixed debian/$(p_lobjc)/DEBIAN/shlibs
	$(SET_CROSS_LIB_PATH) ARCH=$(DEB_TARGET_ARCH) MAKEFLAGS="CC=something" dh_shlibdeps -p$(p_lobjc)
	sed 's/\(lib[^ ]*\) /\1$(cross_lib_arch) /g' < debian/$(p_lobjc).substvars > debian/$(p_lobjc).substvars.new
	mv debian/$(p_lobjc).substvars.new debian/$(p_lobjc).substvars
	dh_gencontrol -p$(p_lobjc) -- -v$(DEB_EVERSION) $(common_substvars)
	dh_installdeb -p$(p_lobjc)
	dh_md5sums -p$(p_lobjc)
	dh_builddeb -p$(p_lobjc)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-lib64objc: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_l64objc)
	dh_installdirs -p$(p_l64objc) \
		$(PF)/lib64
	DH_COMPAT=2 dh_movefiles -p$(p_l64objc) \
		$(PF)/lib64/libobjc.so.*

	debian/dh_doclink -p$(p_l64objc) $(p_base)

	dh_strip -p$(p_l64objc)
	dh_compress -p$(p_l64objc)
	dh_fixperms -p$(p_l64objc)
	dh_makeshlibs -p$(p_l64objc) -V '$(p_l64objc) (>= $(DEB_SOVERSION))'
#	dh_shlibdeps -p$(p_l64objc)
	dh_gencontrol -p$(p_l64objc) -- -v$(DEB_VERSION) $(common_substvars)
	dh_installdeb -p$(p_l64objc)
	dh_md5sums -p$(p_l64objc)
	dh_builddeb -p$(p_l64objc)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-lib32objc: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_l32objc)
	dh_installdirs -p$(p_l32objc) \
		$(lib32)
	DH_COMPAT=2 dh_movefiles -p$(p_l32objc) \
		$(lib32)/libobjc.so.*

	debian/dh_doclink -p$(p_l32objc) $(p_base)

	dh_strip -p$(p_l32objc)
	dh_compress -p$(p_l32objc)
	dh_fixperms -p$(p_l32objc)
	dh_makeshlibs -p$(p_l32objc) -V '$(p_l32objc) (>= $(DEB_SOVERSION))'
#	dh_shlibdeps -p$(p_l32objc)
	dh_gencontrol -p$(p_l32objc) -- -v$(DEB_VERSION) $(common_substvars)
	dh_installdeb -p$(p_l32objc)
	dh_md5sums -p$(p_l32objc)
	dh_builddeb -p$(p_l32objc)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)
