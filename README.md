# device/oneplus/sm8850-common-camera

SoC-common (sm8850 / kaanapali) camera device fragment for the OnePlus
Oplus-camera port — the "common" tier of the two-tier camera topology
split (task-8 design).

Scope: only the camera surface proven byte-identical across all four
sm8850 reference dumps (infiniti / op15 / macan / macanc) belongs here —
HAL/service registration (vintf + init rc), camx provider/device impl
libraries, system_ext camera configs, the OOS-form
init.camera_process.rc, the shared 526-file odm/etc/camera algorithm
asset base, OplusCommercialEngineerCamera, the family-order-only camera
properties, and the common camera sepolicy dir.

Layout:
- `sm8850-common-camera.mk` — common camera product fragment; inherited
  by the per-device camera fragments
  (`device/oneplus/<device>-camera/<device>-camera.mk`).
- `BoardConfigCommonCamera.mk` — common camera board fragment; included
  by the device BoardConfig of camera-port targets.
- `sepolicy/vendor/` — common camera vendor sepolicy overrides.

The blob payload bytes are hosted by `vendor/oplus/camera` (the
vendor-tier common/per-device split is deferred). Per-device camera
config lives in the per-device camera repos and never lands here.
