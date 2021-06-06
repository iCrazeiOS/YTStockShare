export PREFIX=$(THEOS)/toolchain/Xcode11.xctoolchain/usr/bin/
export SDKVERSION = 14.4
export ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = YouTube

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = YTStockShare

YTStockShare_FILES = Tweak.xm
YTStockShare_FRAMEWORKS = UIKit
YTStockShare_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
