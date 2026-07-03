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
# The blob/config payload bytes for those rows are delivered by the
# vendor/oplus/camera payload repo — the vendor-tier common/per-device
# split is deferred (task-8 section 3) — which the per-device camera
# fragment (e.g. device/oneplus/infiniti-camera/infiniti-camera.mk)
# inherits alongside this file. Per-device camera config never lands
# here (task-8 section 1 rule: commonize only within a proven-identical
# surface).

# Camera props common to the sm8850 family (order-only across all four
# dumps; task-8 section 4 "Order-only camera props" row; moved from
# device/oneplus/sm8850-common vendor.prop)
PRODUCT_VENDOR_PROPERTIES += \
    ro.camera.enableCamera1MaxZsl=1 \
    ro.camera.notify_nfc=1 \
    ro.camerax.extensions.enabled=true
