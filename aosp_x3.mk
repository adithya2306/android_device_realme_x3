#
# Copyright (C) 2021 The Android Open Source Project
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

# Inherit framework configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/realme/x3/device.mk)

ifneq ($(VANILLA_BUILD),true)
# Inherit from goolag
$(call inherit-product, vendor/google/gms/config.mk)
$(call inherit-product, vendor/google/pixel/config.mk)
$(call inherit-product, vendor/gprivate/gprivate.mk)
$(call inherit-product, vendor/partner_modules/build/mainline_modules_s_flatten_apex.mk)
else
$(warning Building vanilla)
endif

# Device identifier
PRODUCT_NAME := aosp_x3
PRODUCT_DEVICE := x3
PRODUCT_BRAND := realme
PRODUCT_MODEL := X3
PRODUCT_MANUFACTURER := realme
PRODUCT_GMS_CLIENTID_BASE := android-oppo
