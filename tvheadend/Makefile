#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tvheadend
PKG_VERSION:=4.2.8
PKG_RELEASE:=1

PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.xz
PKG_MIRROR_HASH:=9729a63d17c2051edbafd63035a76fc328b194a162f1d3416317d81d3305f6f2
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/tvheadend/tvheadend.git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE.md

PKG_FIXUP:=autoreconf

PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/tvheadend
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=Tvheadend is a TV streaming server for Linux
  DEPENDS:=+libopenssl +librt +zlib +TVHEADEND_AVAHI_SUPPORT:libavahi-client $(ICONV_DEPENDS)
  URL:=https://tvheadend.org
  MAINTAINER:=Jan Čermák <jan.cermak@nic.cz>
endef

define Package/tvheadend/description
  Tvheadend is a TV streaming server and recorder for Linux, FreeBSD and Android
  supporting DVB-S, DVB-S2, DVB-C, DVB-T, ATSC, IPTV, SAT>IP and HDHomeRun as input sources.

  Tvheadend offers the HTTP (VLC, MPlayer), HTSP (Kodi, Movian) and SAT>IP streaming.
endef

define Package/tvheadend/config
  menu "Configuration"
  depends on PACKAGE_tvheadend
  source "$(SOURCE)/Config.in"
  endmenu
endef

ifeq ($(CONFIG_TVHEADEND_CWC_SUPPORT),)
  CONFIGURE_ARGS += --disable-cwc
endif

ifeq ($(CONFIG_TVHEADEND_LINUXDVB_SUPPORT),)
  CONFIGURE_ARGS += --disable-linuxdvb
endif

ifeq ($(CONFIG_TVHEADEND_DVBSCAN_SUPPORT),)
  CONFIGURE_ARGS += --disable-dvbscan
endif

ifeq ($(CONFIG_TVHEADEND_AVAHI_SUPPORT),)
  CONFIGURE_ARGS += --disable-avahi
else
  CONFIGURE_ARGS += --enable-avahi
endif

CONFIGURE_ARGS += \
	--arch=$(ARCH) \
	--disable-dbus_1 \
	--disable-dvbscan \
	--disable-satip_server \
	--disable-satip_client\
	--eanble-hdhomerun_static \
	--enable-hdhomerun_client \
	--disable-ffmpeg_static \
	--disable-libx264 \
	--disable-libx264_static \
	--disable-libx265 \
	--disable-libx265_static \
	--disable-libvpx \
	--disable-libvpx_static \
	--disable-vaapi \
	--disable-libtheora\
	--disable-libtheora_static \
	--disable-libvorbis \
	--disable-libvorbis_static \
	--disable-libfdkaac \
	--disable-libfdkaac_static \
	--disable-libopus \
	--disable-libopus_static \
	--disable-libmfx_static \
	--disable-libav \
	--disable-bintray_cache \
	--disable-ddci \
	--enable-tsdebug \
	--enable-bundle

ifeq ($(CONFIG_GCC_USE_VERSION_6_3_0)$(CONFIG_GCC_USE_VERSION_7_3_0),y)
TARGET_CFLAGS += -Wno-error=pointer-compare
endif

ifeq ($(CONFIG_GCC_USE_VERSION_7_3_0),y)
TARGET_CFLAGS += -Wno-error=format-truncation
endif

define Build/Prepare
	$(call Build/Prepare/Default)
	echo 'Tvheadend $(shell echo $(PKG_SOURCE_VERSION) | sed "s/^v//")~openwrt$(PKG_RELEASE)' \
		> $(PKG_BUILD_DIR)/debian/changelog
	$(SED) "s|0.0.0~unknown|$(PKG_VERSION)|g" $(PKG_BUILD_DIR)/support/version
endef

define Package/tvheadend/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S71tvheadend $(1)/opt/etc/init.d/

	$(INSTALL_DIR) $(1)/opt/etc/tvheadend
#	$(INSTALL_CONF) ./files/tv_grab_wl500g_info.{cfg,offset} $(1)/opt/etc/

	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/build.linux/tvheadend $(1)/opt/bin/
#	$(INSTALL_BIN) ./files/tv_grab_wl500g_info{,_toffset} $(1)/opt/bin/
endef

$(eval $(call BuildPackage,tvheadend))
