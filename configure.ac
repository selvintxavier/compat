AC_PREREQ([2.57])
AC_INIT([compat_ofa], 1.0, [http://bugs.openfabrics.org/bugzilla], [compat_ofa])

AC_CONFIG_AUX_DIR([config])
AC_CONFIG_MACRO_DIR([config])

AC_CANONICAL_SYSTEM

AC_PROG_CC

AM_PROG_AS

AC_CHECK_TOOLS(AR, ar)

SET_BUILD_ARCH
LB_PROG_CC
OFA_PROG_LINUX
LB_CONDITIONALS

#
#       cleanup auto-generated defines
#
sed -i '/\<PACKAGE\>/d' $PWD/config.h
sed -i '/\<PACKAGE_BUGREPORT\>/d' $PWD/config.h
sed -i '/\<PACKAGE_NAME\>/d' $PWD/config.h
sed -i '/\<PACKAGE_STRING\>/d' $PWD/config.h
sed -i '/\<PACKAGE_TARNAME\>/d' $PWD/config.h
sed -i '/\<PACKAGE_URL\>/d' $PWD/config.h
sed -i '/\<PACKAGE_VERSION\>/d' $PWD/config.h
sed -i '/\<VERSION\>/d' $PWD/config.h
