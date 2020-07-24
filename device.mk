#
# Copyright 2013 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit dalvik configuration and the rest of the platform
$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

# Build Packages
$(call inherit-product, build/target/product/full_base.mk)

# Get Arm translator
#$(call inherit-product-if-exists, vendor/intel/Android.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
#$(call inherit-product, device/common/gps/gps_us_supl.mk)

DEVICE_PACKAGE_OVERLAYS += device/samsung/santos10wifi/overlay

file := $(INSTALLED_KERNEL_TARGET)
ALL_PREBUILT += $(file)
$(file): $(TARGET_PREBUILT_KERNEL) | $(ACP)
    $(transform-prebuilt-to-target)

## During Development we will turn off all security etc.
PRODUCT_DEFAULT_PROPERTY_OVERRIDES := \
    ro.adb.secure=0 \
    ro.secure=0 \
    ro.debugabble=1 
   

# Additional default properties to be
# appended to /default.prop
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
        ro.adb.secure=0 \
        ro.secure=0 \
        ro.debugabble=1 \
        ro.sf.lcd_density=160 \
        panel.physicalWidthmm=217 \
        panel.physicalHeightmm=136 \
        ro.opengles.version=131072 \
        gsm.net.interface=rmnet0 \
        persist.system.at-proxy.mode=0 \
        persist.ril-daemon.disable=0 \
        persist.radio.ril_modem_state=1 \
        wifi.interface=wlan0

PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi
PRODUCT_CHARACTERISTICS := tablet

DEVICE_PACKAGE_OVERLAYS := \
    device/samsung/santos10wifi/overlay

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    mobiledata.interfaces=rmnet0,pdp0,wlan0,gprs,ppp0 \
    ro.telephony.call_ring.multiple=false \
    ro.telephony.call_ring.delay=3000

# Disable SELinux
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.selinux=disabled

# HAL
PRODUCT_PACKAGES += \
    gralloc.default

# Clovertrail
PRODUCT_PACKAGES += \
    aplogd \
    modemlog \
    batt_health \
    charge_only_mode

# Mfld/Intel specific modules
PRODUCT_PACKAGES += \
    libproperty \
    libevent-listener \
    libpci \
    libdrm \
    libat-parser \
    libtty-handler \
    libpci_static \
    libenc

#Ril
# Product specific Packages
PRODUCT_PACKAGES += \
    libsecril-client \
    libsecril-client-sap \
    Stk \
    SamsungServiceMode

# Bluetooth
PRODUCT_PACKAGES += \
    bthelp \
    btcmd \
    bd_prov

# Audio2
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.usb.default \
    audio.primary.santos10wifi
#    audio.r_submix.default \
#    libaudio-resampler \
#    libaudioutils \
#    libbluetooth-audio \
#    libaudio

# Tiny Utils
PRODUCT_PACKAGES += \
    libtinyalsa \
    tinymix

# Wifi
PRODUCT_PACKAGES += \
    lib_driver_cmd_bcmdhd \
    dhcpcd.conf \
    hostapd.conf \
    crda \
    regulatory.bin \
    calibrator \
    wlan_prov

# Filesystem management tools
PRODUCT_PACKAGES +=\
    make_ext4fs \
    e2fsck \
    setup_fs \
    libext4_utils

# Video
PRODUCT_PACKAGES += \
    libwrs_omxil_core_pvwrapped \
    libwrs_omxil_common \
    libva \
    libva-tpi \
    libva-android

# Glib tools
PRODUCT_PACKAGES += \
    libglib-2.0 \
    libgmodule-2.0 \
    libgobject-2.0 \
    libgthread-2.0 \
    mainloop-test \
    array-test

# DNS Conf Daemon
PRODUCT_PACKAGES += \
    rdnssd

# Misc Packages
PRODUCT_PACKAGES += \
    libwbxmlparser \
    busybox \
    perf

# Charger
PRODUCT_PACKAGES += \
charger \
charger_res_images

PRODUCT_PACKAGES += \
    librs_jni \
    com.android.future.usb.accessory

LOCAL_PATH := device/samsung/santos10wifi


#KERNEL_BLB
PRODUCT_COPY_FILES += \
 $(LOCAL_PATH)/prebuilt/kernel/bzImage:kernel

#PowerVR BINARY
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/vendor/bin/pvrsrvctl:system/vendor/bin/pvrsrvctl

#IA_Watchdog and Houdini
PRODUCT_COPY_FILES += \
#$(LOCAL_PATH)/ramdisk/ia_watchdogd:system/bin/ia_watchdogd \
$(LOCAL_PATH)/ramdisk/init:root/init
$(LOCAL_PATH)/ramdisk/busybox:root/system/bin/busybox \
#$(LOCAL_PATH)/ramdisk/dmesg:root/system/bin/dmesg \
#$(LOCAL_PATH)/ramdisk/logcat:root/system/bin/logcat \
#$(LOCAL_PATH)/ramdisk/adbd:root/system/bin/adbd \


#binary
IA_BIN := $(wildcard $(LOCAL_PATH)/bin/**)
PRODUCT_COPY_FILES += \
$(foreach i, $(IA_BIN), $(i):system/bin/$(notdir $(i)))

#FIRMWARE
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/vendor/firmware/bcm4334.hcd:system/vendor/firmware/bcm4334.hcd \
$(LOCAL_PATH)/vendor/firmware/bcm4334_murata.hcd:system/vendor/firmware/bcm4334_murata.hcd \
$(LOCAL_PATH)/vendor/firmware/bcm4334_semco.hcd:system/vendor/firmware/bcm4334_semco.hcd \
$(LOCAL_PATH)/etc/firmware/aac_dec_1.bin:system/etc/firmware/aac_dec_1.bin \
$(LOCAL_PATH)/etc/firmware/fm_rx_init_1283.2.bts:system/etc/firmware/fm_rx_init_1283.2.bts \
$(LOCAL_PATH)/etc/firmware/fmc_init_1283.2.bts:system/etc/firmware/fmc_init_1283.2.bts \
$(LOCAL_PATH)/etc/firmware/fw_sst_08e7.bin:system/etc/firmware/fw_sst_08e7.bin \
$(LOCAL_PATH)/etc/firmware/isp_fr.bin:system/etc/firmware/isp_fr.bin \
$(LOCAL_PATH)/etc/firmware/mp3_dec_1.bin:system/etc/firmware/mp3_dec_1.bin \
$(LOCAL_PATH)/etc/firmware/msvdx_fw_mfld_DE2.0.bin:system/etc/firmware/msvdx_fw_mfld_DE2.0.bin \
$(LOCAL_PATH)/etc/firmware/s3202_gff.img:system/etc/firmware/s3202_gff.img \
$(LOCAL_PATH)/etc/firmware/s3202_ogs.img:system/etc/firmware/s3202_ogs.img \
$(LOCAL_PATH)/etc/firmware/shisp_css15.bin:system/etc/firmware/shisp_css15.bin \
$(LOCAL_PATH)/etc/firmware/TIInit_10.6.15.bts:system/etc/firmware/TIInit_10.6.15.bts \
$(LOCAL_PATH)/etc/firmware/topazsc_fw.bin:system/etc/firmware/topazsc_fw.bin \
$(LOCAL_PATH)/etc/firmware/vpimg_es305b.bin:system/etc/firmware/vpimg_es305b.bin \
$(LOCAL_PATH)/etc/firmware/ti-connectivity/wl128x-fw-4-mr.bin:system/etc/firmware/ti-connectivity/wl128x-fw-4-mr.bin \
$(LOCAL_PATH)/etc/firmware/ti-connectivity/wl128x-fw-4-plt.bin:system/etc/firmware/ti-connectivity/wl128x-fw-4-plt.bin \
$(LOCAL_PATH)/etc/firmware/ti-connectivity/wl128x-fw-4-sr.bin:system/etc/firmware/ti-connectivity/wl128x-fw-4-sr.bin 

#Proprietary Libs (vendor)
Ven_LIBS := $(wildcard $(LOCAL_PATH)/vendor/lib/*.*)
PRODUCT_COPY_FILES += \
$(foreach i, $(Ven_LIBS), $(i):system/vendor/lib/$(notdir $(i)))

#LIBS
IA_LIBS := $(wildcard $(LOCAL_PATH)/lib/*.*)
PRODUCT_COPY_FILES += \
$(foreach i, $(IA_LIBS), $(i):system/lib/$(notdir $(i)))

#DRM
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/vendor/lib/drm/libdrmwvmplugin.so:system/vendor/lib/drm/libdrmwvmplugin.so

#IA_PERMS := $(wildcard $(LOCAL_PATH)/permissions/*.*)
#PRODUCT_COPY_FILES += \
#$(foreach i, $(IA_PERMS), $(i):system/etc/permissions/$(notdir $(i)))

PRODUCT_COPY_FILES += \
frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml

#EGL 544
EGL_LIBS := $(wildcard $(LOCAL_PATH)/vendor/lib/egl/*.*)
PRODUCT_COPY_FILES += \
$(foreach i, $(EGL_LIBS), $(i):system/vendor/lib/egl/$(notdir $(i)))

PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/lib/egl/egl.cfg:system/lib/egl/egl.cfg

# APN List, Telephony permissions
PRODUCT_COPY_FILES += \
    device/sample/etc/apns-full-conf.xml:system/etc/apns-conf.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

#HW Clowertrail Blobs
CLVRTRL_BLOBS := $(wildcard $(LOCAL_PATH)/vendor/lib/hw/*.*)
PRODUCT_COPY_FILES += \
$(foreach i, $(CLVRTRL_BLOBS), $(i):system/vendor/lib/hw/$(notdir $(i)))

#HW blobs
IA_BLB := $(wildcard $(LOCAL_PATH)/lib/hw/*.*)
PRODUCT_COPY_FILES += \
$(foreach i, $(IA_BLB), $(i):system/lib/hw/$(notdir $(i)))

#frameworks
IA_FRM := $(wildcard $(LOCAL_PATH)/framework/*.*)
PRODUCT_COPY_FILES += \
$(foreach i, $(IA_FRM), $(i):system/framework/$(notdir $(i)))

#ETC
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/vendor/etc/nxp/LVVEFS_Rx_Configuration.txt:system/vendor/etc/nxp/LVVEFS_Rx_Configuration.txt \
$(LOCAL_PATH)/vendor/etc/nxp/LVVEFS_Tx_Configuration.txt:system/vendor/etc/nxp/LVVEFS_Tx_Configuration.txt \
#$(LOCAL_PATH)/ramdisk/ia_watchdogd:recovery/root/ia_watchdogd \
$(LOCAL_PATH)/vold/Process.o:system/vold/Process.o \
$(LOCAL_PATH)/vold/Process.P:system/vold/Process.P \
$(LOCAL_PATH)/xbin/dexdump:system/xbin/dexdump \
$(LOCAL_PATH)/xbin/strace:system/xbin/strace

ETC_FLS := $(wildcard $(LOCAL_PATH)/etc/*.*)
PRODUCT_COPY_FILES += \
$(foreach i, $(ETC_FLS), $(i):system/etc/$(notdir $(i)))

ETC_PF := $(wildcard $(LOCAL_PATH)/etc/parameter-framework/*.*)
ETC_PF_SETTINGS_AU := $(wildcard $(LOCAL_PATH)/etc/parameter-framework/Settings/Audio/*.*)
ETC_PF_SETTINGS_VB := $(wildcard $(LOCAL_PATH)/etc/parameter-framework/Settings/Vibrator/*.*)
ETC_PF_STRUCT_AU := $(wildcard $(LOCAL_PATH)/etc/parameter-framework/Structure/Audio/*.*)
ETC_PF_STRUCT_VB := $(wildcard $(LOCAL_PATH)/etc/parameter-framework/Structure/Vibrator/*.*)

PRODUCT_COPY_FILES += \
$(foreach i, $(ETC_PF), $(i):system/etc/parameter-framework/$(notdir $(i))) \
$(foreach i, $(ETC_PF_SETTINGS_AU), $(i):system/etc/parameter-framework/Settings/Audio/$(notdir $(i))) \
$(foreach i, $(ETC_PF_SETTINGS_VB), $(i):system/etc/parameter-framework/Settings/Vibrator/$(notdir $(i))) \
$(foreach i, $(ETC_PF_STRUCT_AU), $(i):system/etc/parameter-framework/Structure/Audio/$(notdir $(i))) \
$(foreach i, $(ETC_PF_STRUCT_VB), $(i):system/etc/parameter-framework/Structure/Vibrator/$(notdir $(i))) 

#$(LOCAL_PATH)/vold/vold:system/bin/vold
#$(LOCAL_PATH)/ramdisk/sbin/watchdogd:root/sbin/watchdogd
#$(LOCAL_PATH)/ramdisk/sbin/logcat:recovery/root/sbin/logcat \
#$(LOCAL_PATH)/ramdisk/sbin/logcat:root/sbin/logcat

ETC_SECURITY := $(wildcard $(LOCAL_PATH)/etc/security/EPID_certs/*.*)
PRODUCT_COPY_FILES += \
$(foreach i, $(ETC_SECURITY), $(i):system/etc/security/EPID_certs/$(notdir $(i)))


#IA ISP
IA_ISP := $(wildcard $(LOCAL_PATH)/etc/atomisp/*.*)
PRODUCT_COPY_FILES += \
$(foreach i, $(IA_ISP), $(i):system/etc/atomisp/$(notdir $(i)))


# Prebuilt files required
IA_ARM := $(wildcard $(LOCAL_PATH)/lib/arm/*.*)
PRODUCT_COPY_FILES += \
$(foreach i, $(IA_ARM), $(i):system/lib/arm/$(notdir $(i)))

IA_INT := $(wildcard $(LOCAL_PATH)/inits/*.*)
PRODUCT_COPY_FILES += \
$(foreach i, $(IA_INT), $(i):root/$(notdir $(i))) \

PRODUCT_COPY_FILES += \
#$(LOCAL_PATH)/lib/parameter-framework-plugins/Audio/libalsactl-subsystem.so:system/lib/parameter-framework-plugins/Audio/#libalsactl-subsystem.so \
#$(LOCAL_PATH)/lib/parameter-framework-plugins/Audio/libamixer-subsystem.so:system/lib/parameter-framework-plugins/Audio/#libamixer-subsystem.so \
#$(LOCAL_PATH)/lib/parameter-framework-plugins/Audio/libaudience-subsystem.so:system/lib/parameter-framework-plugins/Audio/#libaudience-subsystem.so \
#$(LOCAL_PATH)/lib/parameter-framework-plugins/Audio/libbluetooth-subsystem.so:system/lib/parameter-framework-plugins/Audio/#libbluetooth-subsystem.so \
#$(LOCAL_PATH)/lib/parameter-framework-plugins/Audio/libimc-subsystem.so:system/lib/parameter-framework-plugins/Audio/libimc-#subsystem.so \
#$(LOCAL_PATH)/lib/parameter-framework-plugins/Audio/liblpe-subsystem.so:system/lib/parameter-framework-plugins/Audio/liblpe-#subsystem.so \
#$(LOCAL_PATH)/lib/parameter-framework-plugins/Fs/libfs-subsystem.so:system/lib/parameter-framework-plugins/Fs/libfs-#subsystem.so \
#$(LOCAL_PATH)/lib/parameter-framework-plugins/System/libproperty-subsystem.so:system/lib/parameter-framework-plugins/System/#libproperty-subsystem.so

#Thermal
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/etc/thermal_sensor_config.xml:system/etc/thermal_sensor_config.xml \
$(LOCAL_PATH)/etc/thermal_throttle_config.xml:system/etc/thermal_throttle_config.xml

#usr_folder keys and idc
IA_ICU := $(wildcard $(LOCAL_PATH)/usr/icu/*.*)
IA_IDC := $(wildcard $(LOCAL_PATH)/usr/idc/*.*)
IA_KEY := $(wildcard $(LOCAL_PATH)/usr/keychars/*.*)
IA_KLU := $(wildcard $(LOCAL_PATH)/usr/keylayout/*.*)
IA_ALSA := $(wildcard $(LOCAL_PATH)/usr/share/alsa/*.*)
IA_BMD := $(wildcard $(LOCAL_PATH)/usr/share/bmd/*.*)
IA_ZONE := $(wildcard $(LOCAL_PATH)/usr/share/zoneinfo/*.*)


PRODUCT_COPY_FILES += \
$(foreach i, $(IA_ICU), $(i):system/usr/icu/$(notdir $(i))) \
$(foreach i, $(IA_IDC), $(i):system/usr/idc/$(notdir $(i))) \
$(foreach i, $(IA_KEY), $(i):system/usr/keychars/$(notdir $(i))) \
$(foreach i, $(IA_KLU), $(i):system/usr/keylayout/$(notdir $(i))) \
$(foreach i, $(IA_ALSA), $(i):system/usr/share/alsa/$(notdir $(i))) \
$(foreach i, $(IA_BMD), $(i):system/usr/share/bmd/$(notdir $(i))) \
$(foreach i, $(IA_ZONE), $(i):system/usr/share/zoneinfo/$(notdir $(i))) 

#Kernel Modules --------------------------------------------
IA_MDL := $(wildcard $(LOCAL_PATH)/ramdisk/lib/modules/*.*)

PRODUCT_COPY_FILES += \
$(foreach i, $(IA_MDL), $(i):root/lib/modules/$(notdir $(i))) \
$(foreach i, $(IA_MDL), $(i):system/lib/modules/$(notdir $(i)))

PRODUCT_COPY_FILES += \
#$(LOCAL_PATH)/ramdisk/sbin/cbd:root/sbin/cbd \
#$(LOCAL_PATH)/ramdisk/sbin/ffu:root/sbin/ffu 
#$(LOCAL_PATH)/lib/libva.so:recovery/root/system/lib/libva.so
#----------------------------------------------------------


#RECOVERY
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/etc/recovery.fstab:recovery/root/etc/recovery.fstab

#WiFi
IA_WIFI := $(wildcard $(LOCAL_PATH)/wifi/*.*)
PRODUCT_COPY_FILES += \
$(foreach i, $(IA_WIFI), $(i):system/etc/wifi/$(notdir $(i)))

#BT
IA_BT := $(wildcard $(LOCAL_PATH)/bluetooth/*.*)
PRODUCT_COPY_FILES += \
$(foreach i, $(IA_BT), $(i):system/etc/bluetooth/$(notdir $(i)))


