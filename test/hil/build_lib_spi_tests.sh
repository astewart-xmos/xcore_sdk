#!/bin/bash
set -e

XCORE_SDK_ROOT=`git rev-parse --show-toplevel`

source ${XCORE_SDK_ROOT}/tools/ci/helper_functions.sh

# setup configurations
if [ -z "$1" ] || [ "$1" == "all" ]
then
    # row format is: "make_target BOARD"
    applications=(
        "test_hil_spi_master_sync_multi_device_1_0_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_0_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_0_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_0_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_0_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_0_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_0_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_0_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_0_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_0_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_0_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_0_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_0_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_0_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_0_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_0_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_0_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_0_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_0_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_0_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_0_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_0_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_0_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_0_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_0_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_0_1_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_0_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_0_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_1_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_1_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_2_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_2_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_3_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_3_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_0_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_0_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_1_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_1_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_2_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_2_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_3_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_3_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_0_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_0_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_1_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_1_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_2_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_2_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_3_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_3_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_0_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_0_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_1_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_1_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_2_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_2_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_3_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_3_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_0_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_0_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_1_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_1_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_2_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_2_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_3_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_3_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_0_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_0_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_1_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_1_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_2_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_2_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_3_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_3_1 XCORE-AI-EXPLORER"
    )
elif [ "$1" == "smoke" ]
then
    applications=(
        "test_hil_spi_master_sync_multi_device_1_0_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_0_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_0_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_1_1_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_0_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_0_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_multi_device_0_1_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_0_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_0_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_4_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_4_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_4_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_4_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_8_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_8_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_8_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_8_3 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_80_0 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_80_1 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_80_2 XCORE-AI-EXPLORER"
        "test_hil_spi_master_sync_rx_tx_1_1_1_80_3 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_0_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_0_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_1_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_1_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_2_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_2_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_3_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_0_1_3_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_0_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_0_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_1_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_1_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_2_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_2_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_3_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_0_3_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_0_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_0_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_1_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_1_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_2_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_2_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_3_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_1_1_1_3_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_0_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_0_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_1_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_1_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_2_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_2_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_3_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_0_1_3_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_0_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_0_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_1_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_1_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_2_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_2_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_3_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_0_3_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_0_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_0_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_1_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_1_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_2_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_2_1 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_3_0 XCORE-AI-EXPLORER"
        "test_hil_spi_slave_rx_tx_0_1_1_3_1 XCORE-AI-EXPLORER"
    )
else
    echo "Argument $1 not a supported configuration!"
    exit
fi


# perform builds
for ((i = 0; i < ${#applications[@]}; i += 1)); do
    read -ra FIELDS <<< ${applications[i]}
    application="${FIELDS[0]}"
    board="${FIELDS[1]}"
    path="${XCORE_SDK_ROOT}"
    echo '******************************************************'
    echo '* Building' ${application} 'for' ${board}
    echo '******************************************************'

    (cd ${path}; rm -rf build_ci_${board})
    (cd ${path}; mkdir -p build_ci_${board})
    (cd ${path}/build_ci_${board}; log_errors cmake ../ -DBOARD=${board} -DXCORE_SDK_CI_TESTING=ON; log_errors make ${application} -j)
done
