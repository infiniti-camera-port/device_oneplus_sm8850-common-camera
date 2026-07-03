# device_oneplus_sm8850-common-camera

Build-tree path: `device/oneplus/sm8850-common-camera`
Branch: `staging/16.0_crdroid` (integration branch for the crDroid 16.0 camera split)

## Purpose

SoC-common camera device tree for OnePlus sm8850 ("canoe") devices. Carries ONLY the camera
surface proven byte-identical across all four sm8850 OTA dumps:

- Camera HAL/service registration: `vendor.qti.camera.{provider,offlinecamera-impl,aon-impl}.xml`,
  `provider-service_64.rc` + provider binary, system `cameraservice.service` vintf manifest,
  `cameraserver.rc`, odm oplus AIDL manifests (cammidas, camera_rfi, sendextcamcmd, aon-impl).
- `camx.provider-impl.so` + `camx.device-impl.so`.
- system_ext camera configs (`cameraserver_proxy_config.xml`, `sys_camera_optimize_config.xml`,
  `property_list.prop`).
- `vendor/etc/vintf` set incl. `manifest_canoe.xml`.
- `odm/etc/init/init.camera_process.rc` (OOS form).
- The 526-file `odm/etc/camera` shared algorithm asset base (LUTs, basictone, filters_lut,
  seg/beauty models).
- Order-only camera props and `OplusCommercialEngineerCamera.apk`.

Per-device camera content (blob payloads, sensor tuning, `CameraHWConfiguration.config`,
presence-delta files) lives in per-device camera repos such as
`device_oneplus_infiniti-camera`; it is intentionally NOT here.

## Evidence basis

Dump analysis (Task 5 of the crDroid sm8850 camera-split plan, 2026-07-03) found:

- The registration surface and shared asset base above are **byte-identical (sha256) across all
  four sm8850 dumps** — the sole common-ization criterion used here.
- The vendor camera blob stack splits into **two provenance families** that must never be mixed:
  family A = infiniti/op15 (180-file drop, only 2/180 files match family B); family B =
  macan/macanc/fairlady (201-file drop, 201/201 byte-identical within the trio). Blob payloads
  are therefore per-family/per-device, never in this repo.

Source dumps (identities from on-dump props, not filenames):

| device | model / board / prj | OS / OTA |
|---|---|---|
| infiniti — OnePlus 15 (IN) | CPH2745(IN) / OP611FL1 / 24863 | OxygenOS 16.0.8.300(EX01), OTA 11.A.42 |
| macan — OnePlus 15R (ROW) | CPH2769 / OP612DL1 / 24877 | OxygenOS 16.0.8.300(EX01), OTA 11.A.47 |
| macanc — OnePlus Ace 6T (CN) | PLR110 / OP6117L1 / 24855 | ColorOS 16.0.8.301(CN01), OTA 11.A.62 |
| fairlady — OnePlus 15T (CN) | PLZ110 / OP64DDL1 / 25821 | ColorOS 16.0.8.300(CN01), OTA 11.A.31 |
| op15 (reference) — OnePlus 15 (ROW) | CPH2747 / OP611FL1 / 24863 | OxygenOS 16.0.5.703(EX01) |
| dodge (reference, sm8750) — OnePlus 13 | CPH2653 / OP5D55L1 / 23893 | OxygenOS 16.0.8.301(EX01) |

## Content

This repo is scaffolding only for now. The mk fragments, board-config fragment, sepolicy, and
proprietary-files listings land via Task 12 of the plan, which also adds this project to the
build manifest. Do not add this repo to a manifest before that content exists.
