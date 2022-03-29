#

include $(TOPDIR)/rules.mk

PKG_NAME:=nfqsed
PKG_VERSION:=1.0
PKG_RELEASE:=afe5074

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/rgerganov/nfqsed.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=afe50744f2a5b8cf24fe2ab382c8830ef23e7e4e
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

include $(INCLUDE_DIR)/package.mk

define Package/nfqsed
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libnetfilter-queue
	TITLE:=Packet manipulation tool
	URL:=$(PKG_SOURCE_URL)
endef

define Package/nfqsed/description
 NFQUEUE based solution for packet manipulation.
endef

define Build/Compile
	$(MAKE_VARS) \
	    $(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS)
endef

define Package/nfqsed/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/nfqsed $(1)/opt/bin
#	$(INSTALL_DIR) $(1)/usr/etc/init.d
#	$(INSTALL_BIN) ./files/S10zapret $(1)/usr/etc/init.d
endef

$(eval $(call BuildPackage,nfqsed))
