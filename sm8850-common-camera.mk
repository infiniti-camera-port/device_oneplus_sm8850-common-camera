#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# SoC-common (sm8850/kaanapali) camera product fragment.
#
# Carries the camera surface proven byte-identical across all four sm8850
# dumps (infiniti/op15/macan/macanc): HAL/service registration vintf+rc,
# camx.{provider,device}-impl.so, the system_ext camera configs, the
# OOS-form init.camera_process.rc, the 526-file odm/etc/camera algorithm
# asset base and OplusCommercialEngineerCamera (camera topology doc,
# task-8 section 4 "common" rows).
#
# The stack-generic OEM camera glue below (PRODUCT_PACKAGES, system_ext
# configs, CameraThemedIcon overlay, generation props, soong_config, and
# — via BoardConfigCommonCamera.mk — the sepolicy dirs) was absorbed from
# the retired vendor/oplus/camera repo (Lane A vendor-tier retirement).
# The infiniti family-A blob payload + generated infiniti-camera-vendor.mk
# are delivered by the vendor/oneplus/infiniti-camera payload shell, which
# the per-device camera fragment (device/oneplus/infiniti-camera/
# infiniti-camera.mk) inherits alongside this file. Per-device camera config
# never lands here (task-8 section 1 rule: commonize only within a
# proven-identical surface).

LOCAL_PATH := $(call my-dir)

# Camera props common to the sm8850 family (order-only across all four
# dumps; task-8 section 4 "Order-only camera props" row; moved from
# device/oneplus/sm8850-common vendor.prop)
PRODUCT_VENDOR_PROPERTIES += \
    ro.camera.enableCamera1MaxZsl=1 \
    ro.camera.notify_nfc=1 \
    ro.camerax.extensions.enabled=true

# Blob dependencies (folded from the retired vendor/oplus/camera/opluscamera.mk)
PRODUCT_PACKAGES += \
    android.hardware.graphics.common-V3-ndk.vendor \
    CameraThemedIcon

# Permissions / system_ext camera configs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/oplus_google_lens_config.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/oplus_google_lens_config.xml \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-oplus.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-oplus.xml \
    $(LOCAL_PATH)/configs/sysconfig/hiddenapi-package-oplus-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/hiddenapi-package-oplus-whitelist.xml \
    $(LOCAL_PATH)/configs/permissions/default-permissions-oneplus-gallery.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/default-permissions/default-permissions-oneplus-gallery.xml \
    $(LOCAL_PATH)/configs/compatconfig/oplus-gallery-receiver-compat-config.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/compatconfig/oplus-gallery-receiver-compat-config.xml \
    $(LOCAL_PATH)/configs/init/init.oplus.camera_rus.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.oplus.camera_rus.rc

# Stack-generic camera properties (folded from opluscamera.mk). The two
# sRGB-panel preview-HDR override props (persist.camera.override_enable /
# persist.camera.override_preview_hdr_support) are device/panel-specific and
# live in device/oneplus/infiniti-camera/infiniti-camera.mk instead.
PRODUCT_PRODUCT_PROPERTIES += \
    persist.vendor.camera.privapp.list=com.oplus.camera \
    persist.sys.feature.dolby_vision=1 \
    persist.sys.feature.dolby_vision_app=1 \
    persist.sys.feature.hdr_vision_app=1 \
    persist.sys.feature.localhdr_version=2 \
    persist.sys.feature.support.edrlistener=true \
    persist.sys.feature.uhdr.support=true \
    persist.sys.camera.private.log.enable=debug,pre,mp \
    ro.build.version.module.sub_api=2 \
    ro.build.version.oplus.api=38 \
    ro.build.version.oplus.sub_api=47 \
    ro.build.version.oplusrom=V16.1.0 \
    ro.build.version.oplusrom.confidential=V16.1.0 \
    ro.build.version.oplusrom.display=16.0.8 \
    ro.com.google.lens.oem_camera_package=com.oplus.camera \
    ro.com.google.lens.oem_image_package=com.oneplus.gallery,com.oplus.screenshot \
    ro.oplus.fusionlight=true \
    ro.oplus.camera.defercap.support=1 \
    ro.oplus.system.gallery.name=com.oneplus.gallery \
    ro.oplus.system.camera.name=com.oplus.camera \
    ro.oplus.camera.defercap.all.quick.visible.support=1 \
    ro.vendor.oplus.hdr.uniform=1 \
    ro.vendor.oplus.vendorxml.enable=1 \
    vendor.oplus.hdr.uniform.debug=1 \
    oplus.software.camera.10bit=1 \
    ro.oplus.camera.facing.front.need.disable.nfc=1 \
    ro.oplus.camera.portrait.center.switch=oplus.switch.portrait.center \
    ro.oplus.camera.portrait_center.prefix=oplus.portrait.center. \
    ro.oplus.camera.video.beauty.switch=oplus.switch.video.beauty \
    ro.oplus.camera.video_beauty.prefix=oplus.video.beauty. \
    ro.oplus.camera.speechassist=true \
    ro.oplus.system.camera.flashlight=com.oplus.motor.flashlight \
    ro.camera.privileged.3rdpartyApp=com.mediatek.expert.mtkcamhelper;com.aiunit.aon; \
    persist.logd.log.load.camerahalserver.lower_limit=1000 \
    persist.logd.log.load.camerahalserver.threshold=800000 \
    persist.logd.log.load.camerahalserver.upper_limit=3000 \
    persist.logd.log.load.com.oplus.camera.lower_limit=1000 \
    persist.logd.log.load.com.oplus.camera.threshold=800000 \
    persist.logd.log.load.com.oplus.camera.upper_limit=3000 \
    persist.logd.log.load.vendor.qti.camera.provider-service_64.lower_limit=500 \
    persist.logd.log.load.vendor.qti.camera.provider-service_64.threshold=400000 \
    persist.logd.log.load.vendor.qti.camera.provider-service_64.upper_limit=1500

# Photo
$(call soong_config_set,camera,package_name,com.oplus.packageName)

# Video
$(call soong_config_set_bool,camera,override_format_from_reserved,true)
