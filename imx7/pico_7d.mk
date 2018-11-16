# This is a FSL Android Reference Design platform based on i.MX6Q ARD board
# It will inherit from FSL core product which in turn inherit from Google generic

-include device/fsl/common/imx_path/ImxPathConfig.mk
$(call inherit-product, device/fsl/imx7/imx7.mk)
$(call inherit-product-if-exists,vendor/google/products/gms.mk)

ifneq ($(wildcard device/fsl/pico_7d/fstab_nand.freescale),)
$(shell touch device/fsl/pico_7d/fstab_nand.freescale)
endif

ifneq ($(wildcard device/fsl/pico_7d/fstab.freescale),)
$(shell touch device/fsl/pico_7d/fstab.freescale)
endif

# Device does not have firmware by default
BOARD_HAS_QCA9377_WLAN_FIRMWARE := true
BOARD_HAS_BLUETOOTH_FIRMWARE := false

# setup dm-verity configs.
 PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/platform/soc0/soc/30800000.aips-bus/30b60000.usdhc/by-name/system
 $(call inherit-product, build/target/product/verity.mk)

# Overrides
PRODUCT_NAME := pico_7d
PRODUCT_DEVICE := pico_7d

PRODUCT_COPY_FILES += \
	device/fsl/pico_7d/init.rc:root/init.freescale.rc \
	device/fsl/common/input/imx-keypad.idc:system/usr/idc/imx-keypad.idc \
	device/fsl/common/input/imx-keypad.kl:system/usr/keylayout/imx-keypad.kl \

PRODUCT_COPY_FILES += device/fsl/pico_7d/init.freescale.sd.rc:root/init.freescale.sd.rc

# ethernet files
PRODUCT_COPY_FILES += \
	device/fsl/pico_7d/ethernet/eth_updown:system/bin/eth_updown

# Audio
USE_XML_AUDIO_POLICY_CONF := 1
PRODUCT_COPY_FILES += \
	device/fsl/pico_7d/audio_effects.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.conf \
	device/fsl/pico_7d/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
	frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \

DEVICE_PACKAGE_OVERLAYS := device/fsl/pico_7d/overlay

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_AAPT_CONFIG += xlarge large tvdpi hdpi xhdpi

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.audio.output.xml:system/etc/permissions/android.hardware.audio.output.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
	frameworks/native/data/etc/android.hardware.screen.portrait.xml:system/etc/permissions/android.hardware.screen.portrait.xml \
	frameworks/native/data/etc/android.hardware.screen.landscape.xml:system/etc/permissions/android.hardware.screen.landscape.xml \
	frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml \
	frameworks/native/data/etc/android.software.voice_recognizers.xml:system/etc/permissions/android.software.voice_recognizers.xml \
	frameworks/native/data/etc/android.software.backup.xml:system/etc/permissions/android.software.backup.xml \
	frameworks/native/data/etc/android.software.print.xml:system/etc/permissions/android.software.print.xml \
	frameworks/native/data/etc/android.software.device_admin.xml:system/etc/permissions/android.software.device_admin.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
	frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:system/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
	frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	device/fsl/pico_7d/required_hardware.xml:system/etc/permissions/required_hardware.xml

ifeq ($(BOARD_HAS_BLUETOOTH_FIRMWARE),true)
PRODUCT_COPY_FILES += \
	device/fsl/pico_7d/bluetooth/Type_ZP.hcd:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/bcm/Type_ZP.hcd 	\
	device/fsl/pico_7d/bluetooth/bcm43438a0.hcd:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/bcm/bcm43438a0.hcd 	\
	device/fsl/pico_7d/bluetooth/bcm4330.hcd:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/bcm/bcm4330.hcd
endif

ifeq ($(BOARD_HAS_QCA9377_WLAN_FIRMWARE),true)
# QCA9377 WiFi Firmware
# device/fsl/edm1cf_pmic_6dq/wifi-firmware/QCA9377/wlan_mac.bin:vendor/lib/firmware/wlan/wlan_mac.bin
PRODUCT_COPY_FILES += \
	device/fsl/pico_7d/wifi-firmware/QCA9377/wlan/cfg.dat:vendor/lib/firmware/wlan/cfg.dat \
	device/fsl/pico_7d/wifi-firmware/QCA9377/wlan/qcom_cfg.ini:vendor/lib/firmware/wlan/qcom_cfg.ini \
	device/fsl/pico_7d/wifi-firmware/QCA9377/bdwlan30.bin:vendor/lib/firmware/bdwlan30.bin \
	device/fsl/pico_7d/wifi-firmware/QCA9377/otp30.bin:vendor/lib/firmware/otp30.bin \
	device/fsl/pico_7d/wifi-firmware/QCA9377/qwlan30.bin:vendor/lib/firmware/qwlan30.bin \
	device/fsl/pico_7d/wifi-firmware/QCA9377/utf30.bin:vendor/lib/firmware/utf30.bin
endif

# PRODUCT_COPY_FILES += \
#	device/fsl/pico_7d/wifi-firmware/QCA9377/hw1.0/board.bin:vendor/lib/firmware/ath10k/QCA9377/hw1.0/board.bin \
#	device/fsl/pico_7d/wifi-firmware/QCA9377/hw1.0/board-2.bin:vendor/lib/firmware/ath10k/QCA9377/hw1.0/board-2.bin \
#	device/fsl/pico_7d/wifi-firmware/QCA9377/hw1.0/board-sdio.bin:vendor/lib/firmware/ath10k/QCA9377/hw1.0/board-sdio.bin \
#	device/fsl/pico_7d/wifi-firmware/QCA9377/hw1.0/firmware-sdio-5.bin:vendor/lib/firmware/ath10k/QCA9377/hw1.0/firmware-sdio-5.bin

# HWC2 HAL
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.1-impl

# Gralloc HAL
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service

# RenderScript HAL
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

PRODUCT_PACKAGES += \
        libg2d

PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-impl \
    android.hardware.audio@2.0-service \
    android.hardware.audio.effect@2.0-impl \
    android.hardware.sensors@1.0-impl \
    android.hardware.sensors@1.0-service \
    android.hardware.power@1.0-impl \
    android.hardware.power@1.0-service \
    android.hardware.light@2.0-impl \
    android.hardware.light@2.0-service

# imx7 sensor HAL libs.
PRODUCT_PACKAGES += \
        sensors.imx7

# Usb HAL
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service

# Bluetooth HAL
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service

# WiFi HAL
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    wifilogd \
    wificond

# Keymaster HAL
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl

PRODUCT_PROPERTY_OVERRIDES += \
    ro.internel.storage_size=/sys/block/mmcblk0/size

PRODUCT_PROPERTY_OVERRIDES += ro.frp.pst=/dev/block/by-name/presistdata

PRODUCT_PACKAGES += \
    EDM_GPIO \
    EDM_UART \
    EDM_CANBUS \
    Reboot \
    AmazeFileManager 
