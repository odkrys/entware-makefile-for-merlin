#
# Copyright (C) 2016 LEDE
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
export LINUX_DIR:=/krys/asuswrt-merlin.ng/release/src-rt-5.02hnd/kernel/linux-4.1
#export LINUX_DIR:=/krys/asuswrt-merlin.ng/release/src-rt-5.02axhnd/kernel/linux-4.1

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=sched-cake-oot
PKG_RELEASE:=ac

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/dtaht/sch_cake.git
PKG_SOURCE_DATE:=2020-06-25
PKG_SOURCE_VERSION:=48979385757f3408c3427b3ebbf5963efdada5aa
#PKG_MIRROR_HASH:=5bf06a804824db36ae393fc174aeec7b12633176e05a765c0931b39df5bd34df
PKG_MAINTAINER:=Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>


include $(INCLUDE_DIR)/package.mk

define Package/sched-cake-oot
  SUBMENU:=Network Support
  TITLE:=OOT Cake fq_codel/blue derived shaper
  URL:=https://github.com/dtaht/sch_cake
  FILES:=$(PKG_BUILD_DIR)/sch_cake.ko
  #AUTOLOAD:=$(call AutoLoad,75,sch_cake)
endef

include $(INCLUDE_DIR)/kernel-defaults.mk
include $(INCLUDE_DIR)/package-defaults.mk

define Package/sched-cake/description
  O(ut) O(f) T(ree) Common Applications Kept Enhanced fq_codel/blue derived shaper
endef

define Build/Compile
        $(KERNEL_MAKE) M="$(PKG_BUILD_DIR)" modules
endef

define Package/sched-cake-oot/install
	$(INSTALL_DIR) $(1)/opt/lib/modules
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/sch_cake.ko $(1)/opt/lib/modules
endef

$(eval $(call BuildPackage,sched-cake-oot))
