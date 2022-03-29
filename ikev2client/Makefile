
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ikev2client
PKG_VERSION:=alpha
PKG_RELEASE:=2

#PKG_SOURCE:=PlexMediaServer-$(PKG_VERSION)-aarch64.apk
#PKG_SOURCE_URL:=https://downloads.plex.tv/plex-media-server-new/$(PKG_VERSION)/asustor/
#PKG_HASH:=61956d77988160cb082848d3c223b1407c4030d65f4d23e8c1c792dfea2ffe8f

#PKG_BUILD_DIR:=$(BUILD_DIR)/plexmediaserver-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

#define prepare_source_directory
#	mkdir -p $(PKG_BUILD_DIR)/tmp
#	(cd $(DL_DIR) && cp $(PKG_SOURCE) $(PKG_BUILD_DIR) && cd $(PKG_BUILD_DIR) && unzip $(PKG_SOURCE) && tar -xf data.tar.gz -C $(PKG_BUILD_DIR)/tmp)
#endef
#Hooks/Prepare/Pre += prepare_source_directory

define Package/ikev2client
  SECTION:=net	
  CATEGORY:=VPN	
  TITLE:=ikev2client
  URL:=https://www.strongswan.org
endef

define Package/ikev2client/description
  ikev2client is a ikev2 client using strongswan
endef

define Build/Prepare
	$(CP) ./files/Makefile $(PKG_BUILD_DIR)/Makefile
endef

define Package/ikev2client/conffiles
/opt/etc/ikev2/
endef

define Package/ikev2client/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S90ikev2 $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/ikev2
	$(INSTALL_BIN) ./files/strongswan.conf $(1)/opt/etc/ikev2
	$(INSTALL_BIN) ./files/ipsec.conf $(1)/opt/etc/ikev2
	$(INSTALL_BIN) ./files/ipsec.secrets $(1)/opt/etc/ikev2
	$(INSTALL_BIN) ./files/ikev2-updown.sh $(1)/opt/etc/ikev2 
	#$(INSTALL_DIR) $(1)/opt/lib/modules
	#$(INSTALL_BIN) ./files/ip_vti.ko $(1)/opt/lib/modules
endef

$(eval $(call BuildPackage,ikev2client))