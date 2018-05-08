#//#
#//# Copyright (C) 2012 The Android Open Source Project
#//#
#//# Licensed under the Apache License, Version 2.0 (the "License");
#//# you may not use this file except in compliance with the License.
#//# You may obtain a copy of the License at
#//#
#//#      http://www.apache.org/licenses/LICENSE-2.0
#//#
#//# Unless required by applicable law or agreed to in writing, software
#//# distributed under the License is distributed on an "AS IS" BASIS,
#//# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#//# See the License for the specific language governing permissions and
#//# limitations under the License.
#//#
#
#//############################################################
#//   Note:
#//
#//   This file is used to build HarfBuzz within the Android
#//   platform itself.  If you need to compile HarfBuzz to
#//   ship with your Android NDK app, you can use the autotools
#//   build system to do so.  To do that you need to install a
#//   "standalone" toolchain with the NDK, eg:
#//
#//       ndk/build/tools/make-standalone-toolchain.sh
#//           --platform=android-18
#//           --install-dir=/prefix
#//
#//   Set PLATFORM_PREFIX eng var to that prefix and make sure
#//   the cross-compile tools from PLATFORM_PREFIX are in path.
#//   Configure and install HarfBuzz:
#//
#//       ./configure --host=arm-linux-androideabi
#//           --prefix=$PLATFORM_PREFIX
#//           --enable-static
#//           --with-freetype
#//           PKG_CONFIG_LIBDIR=$PLATFORM_PREFIX/lib/pkgconfig
#//       make install
#//
#//   You can first build FreeType the same way:
#//
#//       ./configure --host=arm-linux-androideabi
#//           --prefix=$PLATFORM_PREFIX
#//           --enable-stati
#//           --without-png
#//           PKG_CONFIG_LIBDIR=$PLATFORM_PREFIX/lib/pkgconfig
#//       make install
#//
#
#//############################################################
#//   build the harfbuzz shared library
#//



SRCS += src/hb-blob.cc
SRCS += src/hb-buffer-serialize.cc
SRCS += src/hb-buffer.cc
SRCS += src/hb-common.cc
SRCS += src/hb-face.cc
SRCS += src/hb-font.cc
SRCS += src/hb-ot-tag.cc
SRCS += src/hb-set.cc
SRCS += src/hb-shape.cc
SRCS += src/hb-shape-plan.cc
SRCS += src/hb-shaper.cc
SRCS += src/hb-unicode.cc
SRCS += src/hb-warning.cc
SRCS += src/hb-ot-font.cc
SRCS += src/hb-ot-layout.cc
SRCS += src/hb-ot-map.cc
SRCS += src/hb-ot-math.cc
SRCS += src/hb-ot-shape.cc
SRCS += src/hb-ot-shape-complex-arabic.cc
SRCS += src/hb-ot-shape-complex-default.cc
SRCS += src/hb-ot-shape-complex-hangul.cc
SRCS += src/hb-ot-shape-complex-hebrew.cc
SRCS += src/hb-ot-shape-complex-indic.cc
SRCS += src/hb-ot-shape-complex-indic-table.cc
SRCS += src/hb-ot-shape-complex-myanmar.cc
SRCS += src/hb-ot-shape-complex-thai.cc
SRCS += src/hb-ot-shape-complex-tibetan.cc
SRCS += src/hb-ot-shape-complex-use.cc
SRCS += src/hb-ot-shape-complex-use-table.cc
SRCS += src/hb-ot-shape-normalize.cc
SRCS += src/hb-ot-shape-fallback.cc
SRCS += src/hb-ot-var.cc
SRCS += src/hb-icu.cc

OBJS := ${SRCS:.cc=.o} 


LIBS += libcutils
LIBS += libicuuc
LIBS += libicui18n
LIBS += libutils
LIBS += liblog

CFLAGS1 += --cpu CORTEX-R4F
CFLAGS1 += --arm --li --apcs=interwork --split_sections
CFLAGS1 += -W
CFLAGS1 += --gnu
# CFLAGS1 += --c99

CFLAGS2 += -mcpu=cortex-r4f

CFLAGS += $(CFLAGS1)

CFLAGS += -Isrc

CFLAGS += -DHB_NO_MT
CFLAGS += -DHAVE_OT
CFLAGS += -DHAVE_ICU
CFLAGS += -DHAVE_ICU_BUILTIN
# CFLAGS += -Werror
# CFLAGS += -Wno-unused-parameter
# CFLAGS += -Wno-missing-field-initializers

%.o: %.cc
	armcc $(CFLAGS) -c $< -o $@

libharfbuzz.a: $(OBJS)
	echo $(OBJS)

