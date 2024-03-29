#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tc-adv
PKG_VERSION:=4.16.0-git
PKG_RELEASE:=20191110

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/dtaht/tc-adv
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.gz
PKG_SOURCE_VERSION:=2f0d76d8f3cd67354887f13b8722c9fc5ddd1bae
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE)
PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE)


PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/tc-adv/Default
  TITLE:=Advanced bufferbloat qdisc tc control utility ($(2))
  SECTION:=net
  CATEGORY:=Network
  URL:=http://www.linuxfoundation.org/collaborate/workgroups/networking/iproute2
  SUBMENU:=Routing and Redirection
  MAINTAINER:=Russell Senior <russell@personaltelco.net>
  DEPENDS:= +libnl-tiny +libcap +libelf +libmnl 
  VARIANT:=$(1)
endef

define Package/tc-adv
$(call Package/tc-adv/Default)
  TITLE:=Traffic control utility with support for cake and fq_pi
endef

ifeq ($(BUILD_VARIANT),tiny)
 IP_CONFIG_TINY:=y
endif

define Build/Configure
	$(SED) "s,-I/usr/include/db3,," $(PKG_BUILD_DIR)/Makefile
	$(SED) "s,^KERNEL_INCLUDE.*,KERNEL_INCLUDE=$(LINUX_DIR)/include," \
		$(PKG_BUILD_DIR)/Makefile
	$(SED) "s,^LIBC_INCLUDE.*,LIBC_INCLUDE=$(STAGING_DIR)/opt/include," \
		$(PKG_BUILD_DIR)/Makefile
	echo "static const char SNAPSHOT[] = \"$(PKG_VERSION)-$(PKG_RELEASE)-entware\";" \
		> $(PKG_BUILD_DIR)/include/SNAPSHOT.h
endef

TARGET_CFLAGS += -DHAVE_SETNS
TARGET_CFLAGS += -ffunction-sections -fdata-sections

MAKE_FLAGS += \
	EXTRA_CCOPTS="$(TARGET_CFLAGS) -I../include -I$(STAGING_DIR)/opt/include/libnl-tiny" \
	KERNEL_INCLUDE="$(LINUX_DIR)/include" \
	SHARED_LIBS="" \
	LDFLAGS="$(TARGET_LDFLAGS) -Wl,--gc-sections" \
	IP_CONFIG_TINY=$(IP_CONFIG_TINY) \
	CONFDIR="/opt/etc/iproute2" \
	FPIC="$(FPIC)"

define Build/Compile
	+$(MAKE_VARS) $(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_BUILD_DIR)/include/libnetlink.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/lib/libnetlink.a $(1)/opt/lib/
endef

define Package/tc-adv/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tc/tc $(1)/opt/sbin/
	#$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	#$(INSTALL_BIN) ./files/15-teql $(1)/etc/hotplug.d/iface/
endef

$(eval $(call BuildPackage,tc-adv))