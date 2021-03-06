ifeq ($(with_libcxx),yes)
  indep_binaries  := $(indep_binaries) libstdcxx
endif
ifeq ($(with_lib64cxx),yes)
  indep_binaries  := $(indep_binaries) lib64stdcxx
endif
ifeq ($(biarch32),yes)
  indep_binaries	:= $(indep_binaries) lib32stdcxx
endif
ifeq ($(biarchn32),yes)
  indep_binaries	:= $(indep_binaries) libn32stdcxx
endif

ifeq ($(with_cxxdev),yes)
  indep_binaries  := $(indep_binaries) libstdcxx-dev
endif

libstdc_ext = -$(BASE_VERSION)

p_lib	= libstdc++$(CXX_SONAME)$(cross_lib_arch)
p_lib64	= lib64stdc++$(CXX_SONAME)$(cross_lib_arch)
p_lib32	= lib32stdc++$(CXX_SONAME)$(cross_lib_arch)
p_libn32= libn32stdc++$(CXX_SONAME)$(cross_lib_arch)
p_dev	= libstdc++$(CXX_SONAME)$(libstdc_ext)-dev$(cross_lib_arch)
p_pic	= libstdc++$(CXX_SONAME)$(libstdc_ext)-pic$(cross_lib_arch)
p_dbg	= libstdc++$(CXX_SONAME)$(libstdc_ext)-dbg$(cross_lib_arch)
p_dbg64	= lib64stdc++$(CXX_SONAME)$(libstdc_ext)-dbg$(cross_lib_arch)
p_dbg32	= lib32stdc++$(CXX_SONAME)$(libstdc_ext)-dbg$(cross_lib_arch)
p_dbgn32= libn32stdc++$(CXX_SONAME)$(libstdc_ext)-dbg$(cross_lib_arch)

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

dirs_lib = \
	$(docdir) \
	$(PF)/$(DEB_TARGET_GNU_TYPE)/lib

dirs_lib64 = \
	$(docdir) \
	$(PF)/$(DEB_TARGET_GNU_TYPE)/lib64

dirs_lib32 = \
	$(docdir) \
	$(PF)/$(DEB_TARGET_GNU_TYPE)/lib32

files_lib = \
	$(PF)/$(DEB_TARGET_GNU_TYPE)/lib/libstdc++.so.*

files_lib64 = \
	$(PF)/$(DEB_TARGET_GNU_TYPE)/lib64/libstdc++.so.*

files_lib32 = \
	$(PF)/$(DEB_TARGET_GNU_TYPE)/lib32/libstdc++.so.*

dirs_dev = \
	$(docdir) \
	$(PF)/$(DEB_TARGET_GNU_TYPE)/lib \
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
	$(PF)/$(DEB_TARGET_GNU_TYPE)/lib/debug \
	$(gcc_lib_dir)
files_dbg = \
	$(PF)/$(DEB_TARGET_GNU_TYPE)/lib/debug/libstdc++.*

dirs_pic = \
	$(docdir) \
	$(gcc_lib_dir)
files_pic = \
	$(gcc_lib_dir)/libstdc++_pic.a

ifeq ($(biarch64),yes)
    dirs_dev += $(gcc_lib_dir)/$(biarch64subdir)
    files_dev += \
	$(gcc_lib_dir)/$(biarch64subdir)/libstdc++.{a,so} \
        $(gcc_lib_dir)/$(biarch64subdir)/libsupc++.a
    dirs_pic += $(gcc_lib_dir)
    files_pic += $(gcc_lib_dir)/$(biarch64subdir)/libstdc++_pic.a
endif
ifeq ($(biarch32),yes)
    dirs_dev += $(gcc_lib_dir)/$(biarch32subdir)/
    files_dev += \
	$(gcc_lib_dir)/$(biarch32subdir)/libstdc++.{a,so} \
        $(gcc_lib_dir)/$(biarch32subdir)/libsupc++.a
    dirs_pic += $(gcc_lib_dir)
    files_pic += $(gcc_lib_dir)/$(biarch32subdir)/libstdc++_pic.a
endif
ifeq ($(biarchn32),yes)
    dirs_dev += $(gcc_lib_dir)/$(biarchn32subdir)/
    files_dev += \
	$(gcc_lib_dir)/$(biarchn32subdir)/libstdc++.{a,so} \
        $(gcc_lib_dir)/$(biarchn32subdir)/libsupc++.a
    dirs_pic += $(gcc_lib_dir)
    files_pic += $(gcc_lib_dir)/$(biarchn32subdir)/libstdc++_pic.a
endif

# ----------------------------------------------------------------------

$(binary_stamp)-libstdcxx: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_lib)
	dh_installdirs -p$(p_lib) $(dirs_lib)
	DH_COMPAT=2 dh_movefiles -p$(p_lib) $(files_lib)

	dh_installdocs -p$(p_lib)
	echo "See /$(docdir)/$(p_base) for more information" \
		> $(d_lib)/$(docdir)/$(p_lib)/README.Debian

	dh_installchangelogs -p$(p_lib)
	debian/dh_rmemptydirs -p$(p_lib)

	mkdir -p $(d_dbg)
	PATH=/usr/share/dpkg-cross:$$PATH dh_strip -p$(p_lib) --keep-debug
	# The above line puts debugging information into some strange location
	# that is hardcoded into dh_strip. Move it from there.
	mkdir -p $(d_lib)/usr/$(DEB_TARGET_GNU_TYPE)/lib/debug
	mv $(d_lib)/usr/lib/debug/usr/$(DEB_TARGET_GNU_TYPE)/lib/* $(d_lib)/usr/$(DEB_TARGET_GNU_TYPE)/lib/debug/
	rm -rf $(d_lib)/usr/lib
	# End workaround
	find $(d_dbg)
	tar -C $(d_lib) -c -f - usr/$(DEB_TARGET_GNU_TYPE)/lib/debug | tar -v -C $(d_dbg) -x -f -
	rm -rf $(d_lib)/usr/$(DEB_TARGET_GNU_TYPE)/lib/debug

	dh_compress -p$(p_lib)
	dh_fixperms -p$(p_lib)
	dh_makeshlibs -p$(p_lib) -V '$(p_lib) (>= $(DEB_STDCXX_SOVERSION))' -n
	sed s/$(cross_lib_arch)//g < debian/$(p_lib)/DEBIAN/shlibs > debian/$(p_lib)/DEBIAN/shlibs.fixed
	mv debian/$(p_lib)/DEBIAN/shlibs.fixed debian/$(p_lib)/DEBIAN/shlibs
	mkdir debian/$(p_lib)-deps
	ln -s "`readlink -e /usr/$(DEB_TARGET_GNU_TYPE)/lib`" debian/$(p_lib)-deps/lib
	$(SET_CROSS_LIB_PATH) ARCH=$(DEB_TARGET_ARCH) MAKEFLAGS="CC=something" dh_shlibdeps -p$(p_lib) -L$(p_lib)-deps
	sed -i 's@[ =]lib[^ ,]*@&$(cross_lib_arch)@g' debian/$(p_lib).substvars
	dh_gencontrol -p$(p_lib) -- -v$(DEB_VERSION) $(common_substvars)

	dh_installdeb -p$(p_lib)
	dh_md5sums -p$(p_lib)
	dh_builddeb -p$(p_lib)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------

$(binary_stamp)-lib64stdcxx: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_lib64)
	dh_installdirs -p$(p_lib64) $(dirs_lib64)
	DH_COMPAT=2 dh_movefiles -p$(p_lib64) $(files_lib64)

	dh_installdirs -p$(p_dbg64) \
		$(PF)/$(DEB_TARGET_GNU_TYPE)/lib64
	mv $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib64/debug $(d_dbg64)/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib64/.

	mkdir -p $(d_dbg64)
	PATH=/usr/share/dpkg-cross:$$PATH dh_strip -p$(p_lib64) --keep-debug
	# The above line puts debugging information into some strange location
	# that is hardcoded into dh_strip. Move it from there.
	mkdir -p $(d_lib64)/usr/$(DEB_TARGET_GNU_TYPE)/lib64/debug
	mv $(d_lib64)/usr/lib/debug/usr/$(DEB_TARGET_GNU_TYPE)/lib64/* $(d_lib64)/usr/$(DEB_TARGET_GNU_TYPE)/lib64/debug/
	rm -rf $(d_lib64)/usr/lib64
	# End workaround
	find $(d_lib64)
	tar -C $(d_lib64) -c -f - usr/$(DEB_TARGET_GNU_TYPE)/lib64/debug | tar -v -C $(d_dbg64) -x -f -
	rm -rf $(d_lib64)/usr/$(DEB_TARGET_GNU_TYPE)/lib64/debug

	dh_installdocs -p$(p_lib64)
	echo "See /$(docdir)/$(p_base) for more information" \
		> $(d_lib64)/$(docdir)/$(p_lib64)/README.Debian
	dh_installchangelogs -p$(p_lib64)
	debian/dh_doclink -p$(p_dbg64) $(p_lib64)

	debian/dh_rmemptydirs -p$(p_lib64)
	dh_compress -p$(p_lib64)
	dh_fixperms -p$(p_lib64)
	dh_makeshlibs -p$(p_lib64) -V '$(p_lib64) (>= $(DEB_STDCXX_SOVERSION))' -n
	sed s/$(cross_lib_arch)//g < debian/$(p_lib64)/DEBIAN/shlibs > debian/$(p_lib64)/DEBIAN/shlibs.fixed
	mv debian/$(p_lib64)/DEBIAN/shlibs.fixed debian/$(p_lib64)/DEBIAN/shlibs
	mkdir debian/$(p_lib64)-deps
	ln -s "`readlink -e /usr/$(DEB_TARGET_GNU_TYPE)/lib64`" debian/$(p_lib64)-deps/lib
	ARCH=$(DEB_TARGET_ARCH) MAKEFLAGS="CC=something" dh_shlibdeps -p$(p_lib64) -L$(p_lib64)-deps
	sed -i 's@[ =]lib[^ ,]*@&$(cross_lib_arch)@g' debian/$(p_lib64).substvars
	dh_gencontrol -p$(p_lib64) -- -v$(DEB_VERSION) $(common_substvars)
	#dh_gencontrol -p$(p_dbg64) -- -v$(DEB_VERSION) $(common_substvars)

	dh_installdeb -p$(p_lib64)
	dh_md5sums -p$(p_lib64)
	dh_builddeb -p$(p_lib64)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------

$(binary_stamp)-lib32stdcxx: $(install_stamp)
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_lib32)
	dh_installdirs -p$(p_lib32) $(dirs_lib32)
	DH_COMPAT=2 dh_movefiles -p$(p_lib32) $(files_lib32)

	dh_installdirs -p$(p_dbg32) \
		$(PF)/$(DEB_TARGET_GNU_TYPE)/lib32
	mv $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib32/debug $(d_dbg32)/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib32/.

	mkdir -p $(d_dbg32)
	PATH=/usr/share/dpkg-cross:$$PATH dh_strip -p$(p_lib32) --keep-debug
	# The above line puts debugging information into some strange location
	# that is hardcoded into dh_strip. Move it from there.
	mkdir -p $(d_lib32)/usr/$(DEB_TARGET_GNU_TYPE)/lib32/debug
	mv $(d_lib32)/usr/lib/debug/usr/$(DEB_TARGET_GNU_TYPE)/lib32/* $(d_lib32)/usr/$(DEB_TARGET_GNU_TYPE)/lib32/debug/
	rm -rf $(d_lib32)/usr/lib32
	# End workaround
	find $(d_lib32)
	tar -C $(d_lib32) -c -f - usr/$(DEB_TARGET_GNU_TYPE)/lib32/debug | tar -v -C $(d_dbg32) -x -f -
	rm -rf $(d_lib32)/usr/$(DEB_TARGET_GNU_TYPE)/lib32/debug

	dh_installdocs -p$(p_lib32)
	echo "See /$(docdir)/$(p_base) for more information" \
		> $(d_lib32)/$(docdir)/$(p_lib32)/README.Debian
	dh_installchangelogs -p$(p_lib32)
	debian/dh_doclink -p$(p_dbg32) $(p_lib32)

	debian/dh_rmemptydirs -p$(p_lib32)
	dh_compress -p$(p_lib32)
	dh_fixperms -p$(p_lib32)
	dh_makeshlibs -p$(p_lib32) -V '$(p_lib32) (>= $(DEB_STDCXX_SOVERSION))' -n
	sed s/$(cross_lib_arch)//g < debian/$(p_lib32)/DEBIAN/shlibs > debian/$(p_lib32)/DEBIAN/shlibs.fixed
	mv debian/$(p_lib32)/DEBIAN/shlibs.fixed debian/$(p_lib32)/DEBIAN/shlibs
	mkdir debian/$(p_lib32)-deps
	ln -s "`readlink -e /usr/$(DEB_TARGET_GNU_TYPE)/lib32`" debian/$(p_lib32)-deps/lib
	ARCH=$(DEB_TARGET_ARCH) MAKEFLAGS="CC=something" dh_shlibdeps -p$(p_lib32) -L$(p_lib32)-deps
	sed -i 's@[ =]lib[^ ,]*@&$(cross_lib_arch)@g' debian/$(p_lib32).substvars
	dh_gencontrol -p$(p_lib32) -- -v$(DEB_VERSION) $(common_substvars)
	#dh_gencontrol -p$(p_dbg32) -- -v$(DEB_VERSION) $(common_substvars)

	dh_installdeb -p$(p_lib32)
	dh_md5sums -p$(p_lib32)
	dh_builddeb -p$(p_lib32)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
libcxxdev_deps = $(install_stamp)
ifeq ($(with_libcxx),yes)
  libcxxdev_deps += $(binary_stamp)-libstdcxx
endif
$(binary_stamp)-libstdcxx-dev: $(libcxxdev_deps) \
    $(binary_stamp)-libstdcxx
	dh_testdir
	dh_testroot
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_dev) $(d_pic)
	dh_installdirs -p$(p_dev) $(dirs_dev)
	dh_installdirs -p$(p_pic) $(dirs_pic)
	dh_installdirs -p$(p_dbg) $(dirs_dbg)

	: # - correct libstdc++-v3 file locations
	mv $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib/libsupc++.a $(d)/$(gcc_lib_dir)/
	mv $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib/libstdc++.{a,so} $(d)/$(gcc_lib_dir)/
	ln -sf ../../../../$(DEB_TARGET_GNU_TYPE)/lib/libstdc++.so.$(CXX_SONAME) $(d)/$(gcc_lib_dir)/libstdc++.so
	mv $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib/libstdc++_pic.a \
		$(d)/$(gcc_lib_dir)/

	rm -f $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib/debug/libstdc++_pic.a
	rm -f $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib64/debug/libstdc++_pic.a

	: # remove precompiled headers
	-find $(d) -type d -name '*.gch' | xargs rm -rf

ifeq ($(biarch64),yes)
	mv $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib64/lib*c++*.a $(d)/$(gcc_lib_dir)/$(biarch64subdir)/.
	ln -sf ../../../../../lib64/libstdc++.so.$(CXX_SONAME) \
		$(d)/$(gcc_lib_dir)/$(biarch64subdir)/libstdc++.so
endif
ifeq ($(biarch32),yes)
	mv $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib32/lib*c++*.a $(d)/$(gcc_lib_dir)/$(biarch32subdir)/.
	ln -sf ../../../../../lib64/libstdc++.so.$(CXX_SONAME) \
		$(d)/$(gcc_lib_dir)/$(biarch32subdir)/libstdc++.so
endif
ifeq ($(biarchn32),yes)
	mv $(d)/$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libn32)/lib*c++*.a $(d)/$(gcc_lib_dir)/$(biarchn32subdir)/.
	ln -sf ../../../../../$(libn32)/libstdc++.so.$(CXX_SONAME) \
		$(d)/$(gcc_lib_dir)/$(biarchn32subdir)/libstdc++.so
endif

	for i in $(d)/$(PF)/include/c++/$(GCC_VERSION)/*-linux; do \
	  if [ -d $$i ]; then mv $$i $$i-gnu; fi; \
	done

	DH_COMPAT=2 dh_movefiles -p$(p_dev) $(files_dev)
	DH_COMPAT=2 dh_movefiles -p$(p_pic) $(files_pic)
	DH_COMPAT=2 dh_movefiles -p$(p_dbg) $(files_dbg)

	dh_link -p$(p_dev) \
		/$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libdir)/libstdc++.so.$(CXX_SONAME) \
		/$(gcc_lib_dir)/libstdc++.so \
		/$(cxx_inc_dir) /$(PF)/$(DEB_TARGET_GNU_TYPE)/include/c++/$(BASE_VERSION)

ifeq ($(biarch64),yes)
	dh_link -p$(p_dev) \
		/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib64/libstdc++.so.$(CXX_SONAME) \
		/$(gcc_lib_dir)/$(biarch64subdir)/libstdc++.so
endif
ifeq ($(biarch32),yes)
	dh_link -p$(p_dev) \
		/$(PF)/$(DEB_TARGET_GNU_TYPE)/lib32/libstdc++.so.$(CXX_SONAME) \
		/$(gcc_lib_dir)/$(biarch32subdir)/libstdc++.so
endif
ifeq ($(biarchn32),yes)
	dh_link -p$(p_dev) \
		/$(PF)/$(DEB_TARGET_GNU_TYPE)/$(libn32)/libstdc++.so.$(CXX_SONAME) \
		/$(gcc_lib_dir)/$(biarchn32subdir)/libstdc++.so
endif

	debian/dh_doclink -p$(p_dev) $(p_lib)
	debian/dh_doclink -p$(p_pic) $(p_lib)
	debian/dh_doclink -p$(p_dbg) $(p_lib)
	cp -p $(srcdir)/libstdc++-v3/config/abi/pre/gnu.ver \
		$(d_pic)/$(gcc_lib_dir)/libstdc++_pic.map

ifeq ($(with_cxxdev),yes)
	debian/dh_rmemptydirs -p$(p_dev)
	debian/dh_rmemptydirs -p$(p_pic)
	debian/dh_rmemptydirs -p$(p_dbg)
endif

	PATH=/usr/share/dpkg-cross:$$PATH dh_strip -p$(p_dev) --dbg-package=$(p_lib)
	PATH=/usr/share/dpkg-cross:$$PATH dh_strip -p$(p_pic)
	dh_compress -p$(p_dev) -p$(p_pic) -p$(p_dbg) -X.txt
	dh_fixperms -p$(p_dev) -p$(p_pic) -p$(p_dbg)
	dh_gencontrol -p$(p_dev) -p$(p_pic) -p$(p_dbg) \
		-- -v$(DEB_VERSION) $(common_substvars)

	dh_installdeb -p$(p_dev) -p$(p_pic) -p$(p_dbg)
	dh_md5sums -p$(p_dev) -p$(p_pic) -p$(p_dbg)
	dh_builddeb -p$(p_dev) -p$(p_pic) -p$(p_dbg)

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)
