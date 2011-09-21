indep_binaries := $(indep_binaries) gcc-source

p_source = gcc$(pkg_ver)-source
d_source= debian/$(p_source)

$(binary_stamp)-gcc-source:
	dh_testdir
	dh_testroot

	dh_installdocs -p$(p_source)
	dh_installchangelogs -p$(p_source)

	dh_install -p$(p_source) $(gcc_tarball) usr/src/gcc$(pkg_ver)
#	dh_install -p$(p_source) $(gcj_tarball) usr/src/gcc$(pkg_ver)
	dh_install -p$(p_source) debian/patches usr/src/gcc$(pkg_ver)
	rm -rf debian/$(p_source)/usr/src/gcc$(pkg_ver)/patches/.svn
	dh_install -p$(p_source) \
	    debian/rules.source \
		usr/src/gcc$(pkg_ver)
	dh_install -p$(p_source) \
	    debian/rules.defs debian/rules.patch debian/rules.unpack \
	    debian/dummy.texi debian/gcc-dummy.texi debian/porting.* \
		usr/src/gcc$(pkg_ver)/debian

	mkdir -p $(d_source)/usr/share/lintian/overrides
	cp -p debian/$(p_source).overrides \
		$(d_source)/usr/share/lintian/overrides/$(p_snap)

	dh_fixperms -p$(p_source)
	dh_compress -p$(p_source)
	dh_gencontrol -p$(p_source) -- -v$(DEB_VERSION) $(common_substvars)
	dh_installdeb -p$(p_source)
	dh_md5sums -p$(p_source)
	dh_builddeb -p$(p_source)

	touch $@
