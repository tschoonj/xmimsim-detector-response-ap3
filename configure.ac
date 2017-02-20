#Copyright (C) 2017 Tom Schoonjans

#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.

AC_INIT([xmimsim-detector-response-ap3],[0.1],[Tom.Schoonjans@me.com])
AC_PREREQ([2.67])
AC_CONFIG_SRCDIR([xmimsim-detector-response-ap3.F90])
AC_CONFIG_AUX_DIR([build-aux])

AM_INIT_AUTOMAKE([-Wall -Werror foreign])

AC_CANONICAL_HOST
AC_GNU_SOURCE

#are we dealing with windows?
OS_WINDOWS=0
LDFLAGS_EXTRA=""
case "$host" in
	*mingw*)
		OS_WINDOWS=1
		;;
esac

AC_SUBST(OS_WINDOWS)
AM_CONDITIONAL([OS_WINDOWS],[test x$OS_WINDOWS = x1])

AC_CONFIG_MACRO_DIR([m4])

AC_USE_SYSTEM_EXTENSIONS
m4_ifdef([AM_PROG_AR],[AM_PROG_AR])

#libtool
LT_PREREQ([2.0.0])
LT_INIT()
AC_PROG_LIBTOOL

#initialize pkg-config
PKG_PROG_PKG_CONFIG

PKG_CHECK_MODULES([libxmimsim], libxmimsim >= 5.3)
PKG_CHECK_VAR([RNG], [libxmimsim], [rng])

if test x$RNG = xeasyRNG ; then
	AC_DEFINE([HAVE_EASYRNG], [], [building with easyRNG support])
elif test x$RNG != xfgsl ; then
	AC_MSG_ERROR([Could not determine which RNG library to use])
fi


#search for a fortran compiler (do not check explicitly for the 2003 features yet)
AC_PROG_FC
if test -z $FC ; then
	AC_MSG_ERROR([Fortran 2003 compiler was not found])
fi
AC_FC_SRCEXT(f90)


#search for openmp
AC_LANG_PUSH(Fortran)
AC_OPENMP
AC_LANG_POP(Fortran)
AC_LANG_PUSH(C)
AC_OPENMP
AC_LANG_POP(C)

AC_CONFIG_FILES([Makefile])

AC_CONFIG_HEADERS([config.h])
AC_OUTPUT
