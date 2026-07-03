#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# SoC-common (sm8850) camera board fragment (task-8 topology section 5).
# Included by the BoardConfig of camera-port device targets
# (device/oneplus/infiniti/BoardConfig.mk).

# SEPolicy: common camera vendor file_contexts overrides (moved from
# device/oneplus/sm8850-common BoardConfigCommon.mk + sepolicy/vendor)
BOARD_SEPOLICY_DIRS += device/oneplus/sm8850-common-camera/sepolicy/vendor
