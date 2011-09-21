#!/bin/sh -e

# called by uscan with '--upstream-version' <version> <file>
DIR=lapack-$2
TAR=../lapack_$2.orig.tar.gz

# clean up the upstream tarball
tar -z -x -f $3
rm $3
(cd $DIR
echo ""
echo "Downloading manpages from netlib website"
wget http://www.netlib.org/lapack/manpages.tgz >/dev/null 2>&1
echo "Unpack manpages.tgz"
tar zxf manpages.tgz --strip-components 1
rm manpages.tgz
mv TESTING testing; ln -s testing TESTING
mv SRC src; ln -s src SRC
mv INSTALL install; ln -s install INSTALL
mv BLAS blas; ln -s blas BLAS
mv manpages/man .
rm -rf manpages
)
RULES=$(pwd)/debian/rules
(cd $DIR ; $RULES lug/index.html)
echo tar -c -z -f $TAR $DIR
tar -c -z -f $TAR $DIR
rm -rf $DIR

# move to directory 'tarballs'
if [ -r .svn/deb-layout ]; then
    . .svn/deb-layout
    mv $TAR $origDir
    echo "moved $TAR to $origDir"
fi

exit 0
