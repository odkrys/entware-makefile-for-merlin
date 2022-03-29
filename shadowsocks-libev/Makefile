#
# Copyright (C) 2017-2018 Yousong Zhou <yszhou4tech@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

# Checklist when bumping versions
#
# - update cipher list by checking src/crypto.c:crypto_init()
# - check if default mode has changed from being tcp_only
#
PKG_NAME:=shadowsocks-libev
PKG_VERSION:=3.2.5
PKG_RELEASE:=f35c162

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/shadowsocks/shadowsocks-libev.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=f35c1623576e0a084b1b2e07b1a77017ddb4e0ae
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=Yousong Zhou <yszhou4tech@gmail.com>

PKG_LICENSE:=GPL-3.0+
PKG_LICENSE_FILES:=LICENSE

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocks-libev
    SECTION:=net
    CATEGORY:=Network
    SUBMENU:=Web Servers/Proxies
    TITLE:=shadowsocks-libev
    URL:=https://github.com/shadowsocks/shadowsocks-libev
    DEPENDS:=+libcares +libev +libmbedtls +libpcre +libpthread +libsodium +zlib
endef

CONFIGURE_ARGS += \
	--disable-documentation \
	--disable-silent-rules \
	--disable-assert \
	--disable-ssp \

define Package/shadowsocks-libev/conffiles
/opt/etc/shadowsocks/shadowsocks.json
endef

define Package/shadowsocks-libev/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-{server,local,redir,tunnel} $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/shadowsocks
	$(INSTALL_DATA) ./files/shadowsocks.json $(1)/opt/etc/shadowsocks
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S22shadowsocks $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,shadowsocks-libev))
