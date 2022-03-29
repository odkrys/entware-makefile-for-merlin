
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=plexmediaserver
PKG_VERSION:=1.15.4.994-107756f7e
PKG_RELEASE:=1

PKG_SOURCE:=PlexMediaServer-$(PKG_VERSION)-aarch64.apk
PKG_SOURCE_URL:=https://downloads.plex.tv/plex-media-server-new/$(PKG_VERSION)/asustor/
PKG_HASH:=61956d77988160cb082848d3c223b1407c4030d65f4d23e8c1c792dfea2ffe8f

PKG_BUILD_DIR:=$(BUILD_DIR)/plexmediaserver-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define prepare_source_directory
	mkdir -p $(PKG_BUILD_DIR)/tmp
	(cd $(DL_DIR) && cp $(PKG_SOURCE) $(PKG_BUILD_DIR) && cd $(PKG_BUILD_DIR) && unzip $(PKG_SOURCE) && tar -xf data.tar.gz -C $(PKG_BUILD_DIR)/tmp)
endef
Hooks/Prepare/Pre += prepare_source_directory

define Package/plexmediaserver
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=Plex Media Server
  URL:=https://www.plex.tv
endef

define Package/plexmediaserver/description
  plexmediaserver is a Plex Media Server
endef

define Build/Prepare
	$(CP) ./files/Makefile $(PKG_BUILD_DIR)/Makefile
endef

define Package/plexmediaserver/install
	$(INSTALL_DIR) $(1)/opt/sbin/plexmediaserver
	$(CP) $(PKG_BUILD_DIR)/tmp/* $(1)/opt/sbin/plexmediaserver
	ln -s ../sbin/plexmediaserver/"Plex Media Server" $(1)/opt/sbin/PlexMediaServer
	$(INSTALL_DIR) $(1)/opt/var/lib/plexmediaserver
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S91pms $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/*.so.* $(1)/opt/sbin/plexmediaserver/lib
endef

$(eval $(call BuildPackage,plexmediaserver))