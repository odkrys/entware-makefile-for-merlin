#
# Copyright (C) 2016-2017 Jason A. Donenfeld <Jason@zx2c4.com>
# Copyright (C) 2016 Baptiste Jonglez <openwrt@bitsofnetworks.org>
# Copyright (C) 2016-2017 Dan Luedtke <mail@danrl.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

# Wireguard's makefile needs this to know where to build the kernel module
export LINUX_DIR:=/krys/asuswrt-merlin.ng/release/src-rt-5.02hnd/kernel/linux-4.1
#export LINUX_DIR:=/krys/asuswrt-merlin.ng/release/src-rt-5.02axhnd/kernel/linux-4.1

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=wireguard-kernel

PKG_VERSION:=1.0.20200908
PKG_RELEASE:=ac

PKG_SOURCE:=wireguard-linux-compat-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://git.zx2c4.com/wireguard-linux-compat/snapshot/
#PKG_HASH:=7c0e576459c6337bcdea692bdbec561719a15da207dc739e0e3e60ff821a5491

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/wireguard-linux-compat-$(PKG_VERSION)
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/wireguard-kernel/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  URL:=https://www.wireguard.com
  MAINTAINER:=Baptiste Jonglez <openwrt@bitsofnetworks.org>, \
              Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>, \
              Dan Luedtke <mail@danrl.com>, \
              Jason A. Donenfeld <Jason@zx2c4.com>
endef

define Package/wireguard-kernel/description
  WireGuard is a novel VPN that runs inside the Linux Kernel and utilizes
  state-of-the-art cryptography. It aims to be faster, simpler, leaner, and
  more useful than IPSec, while avoiding the massive headache. It intends to
  be considerably more performant than OpenVPN.  WireGuard is designed as a
  general purpose VPN for running on embedded interfaces and super computers
  alike, fit for many different circumstances. It uses UDP.
endef

define Package/wireguard-kernel
  $(call Package/wireguard-kernel/Default)
  TITLE:=Wireguard kernel module
endef

include $(INCLUDE_DIR)/kernel-defaults.mk
include $(INCLUDE_DIR)/package-defaults.mk

define Build/Compile
	$(MAKE) $(KERNEL_MAKEOPTS) M="$(PKG_BUILD_DIR)/src" modules \
	EXTRA_CFLAGS="$(TARGET_CFLAGS) -fno-pie"
endef

define Package/wireguard-kernel/install
	$(INSTALL_DIR) $(1)/opt/lib/modules
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/wireguard.ko $(1)/opt/lib/modules
endef

$(eval $(call BuildPackage,wireguard-kernel))
