#
# Copyright (C) 2021 ArrowOS
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),x3)

$(call add-radio-file,releasetools/dynamic-remove-oplus)

subdir_makefiles=$(call first-makefiles-under,$(LOCAL_PATH))
$(foreach mk,$(subdir_makefiles),$(info including $(mk) ...)$(eval include $(mk)))

endif
