#

include $(TOPDIR)/rules.mk

PKG_NAME:=zapret
PKG_VERSION:=1.0
PKG_RELEASE:=ab43016

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/bol-van/zapret.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=ab430165a73dba943fad07ba6387a3f5a652acac
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

include $(INCLUDE_DIR)/package.mk

define Package/zapret
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libnetfilter-queue
	TITLE:=DPI bypass tool
	URL:=$(PKG_SOURCE_URL)
endef

define Package/zapret/description
 NFQUEUE based solution for ISP DPI bypass.
endef

define Build/Compile
	$(MAKE_VARS) \
	    $(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR)/nfq $(MAKE_FLAGS)
	$(MAKE_VARS) \
	    $(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR)/tpws $(MAKE_FLAGS)
endef

define Package/zapret/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/nfq/nfqws $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tpws/tpws $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S10zapret $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S11zapret2 $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,zapret))
