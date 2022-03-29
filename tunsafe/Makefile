#
# Copyright (C) 2009-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tunsafe
PKG_VERSION:=1.5-rc2
PKG_RELEASE:=0

#PKG_SOURCE:=v$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=https://github.com/TunSafe/TunSafe/archive/	
#PKG_HASH:=2befc27b1cc62af0450702343d17e347936f0d4e3d4b04ba9246c4f9b409b742

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/TunSafe/TunSafe.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=85a871c1d226956df7c1308a1e5527556fe35fe1
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

#PKG_BUILD_DIR:=$(BUILD_DIR)/TunSafe-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/tunsafe
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  DEPENDS:=+libstdcpp
  TITLE:=TunSafe
  URL:=https://tunsafe.com
endef

define Package/package/tunsafe
  TunSafe++ is
endef
 
TARGET_CXXFLAGS += -I$(PKG_BUILD_DIR) -DNDEBUG -DWITH_NETWORK_BSD=1 -DCHACHA20_WITH_ASM=0 -DBLAKE2S_WITH_ASM=0 -fno-omit-frame-pointer -std=c++11 -pthread

define Package/tunsafe/conffiles
/opt/etc/tunsafe/client.conf
endef

define Package/tunsafe/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tunsafe $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S51tunsafe $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/tunsafe
	$(INSTALL_DATA) ./files/client.conf $(1)/opt/etc/tunsafe
endef

$(eval $(call BuildPackage,tunsafe))
